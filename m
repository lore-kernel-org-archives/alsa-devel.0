From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/9] ASoC: sti: Add platform driver
Date: Wed, 27 May 2015 14:06:20 +0200
Message-ID: <5565B33C.2000300@metafoo.de>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-6-git-send-email-arnaud.pouliquen@st.com>
 <20150525125002.GQ21391@sirena.org.uk> <556584C4.3080004@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 381E1265998
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 14:06:22 +0200 (CEST)
In-Reply-To: <556584C4.3080004@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/27/2015 10:48 AM, Arnaud Pouliquen wrote:
[...]
>>> +static int sti_platform_engine_probe(struct platform_device *pdev)
>>> +{
>>> +    /*
>>> +     * Driver can not use snd_dmaengine_pcm_register.
>>> +     * Reason is that DMA needs to load a firmware.
>>> +     * This firmware is loaded on request_channel from file system.
>>> +     * So can not be done in probe while alsa card enumerated before
>>> +     * file system is mounted
>>> +     */
>>
>> This is not the only driver with similar needs, the Intel drivers use
>> firmwares as well (all the DMA is done by the DSP which needs firmware)
>> and even if it were we should be able to arrange for this to work rather
>> than having to open code things.  That might mean having the dmaengine
>> driver requesting firmware with _nowait() and then waiting until the
>> firmware appears before registering as a DMA controller for example.  We
>> may also be able to have the DMA engine only load the firmware when it's
>> used rather than at probe (that might allow us to keep the DMA
>> controller powered off for longer which would be a power win if possible).
>>
>> It's not just restricted to audio either.
>>
>
> Move dmaengine_pcm_request_chan from register to open could be a good
> compromise with (i hope) no impact on drivers that already use
> soc_generic_dma_engine. This is the implementation already proposed in of
> pcm_dmaengine.c
> Another issue i'm facing, is that i have one DMA channel per CPU_DAI
> instance. As simple card imposes to define CPU_DAIs in one platform device,
> i need to define specific DMA name per CPU_DAI.
> What is your recommendation on this point:
> Do you want that i use snd_dmaengine_pcm_register and propose
> soc_gebneric_dmaengine driver patches?
> or simply reuse pcm_dmaengine helper functions as much as possible.

You really want to request the DMA channels in the probe callback of the 
driver (and also use the the generic-dmaengine-pcm driver). This makes sure 
that you have proper support for probe deferral, etc. The DMA driver should 
probably not request the firmware inside the channel_request() callback. As 
Mark sad this will not only affect audio, but all usecases that involve 
DMAengine.

Btw. what is the DMA driver you are using, is it already upstream?

- Lars
