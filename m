From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 1/3] ASoC: AMD: Make ACP->SYSMEM DMA non
	circular
Date: Mon, 6 Aug 2018 12:56:39 +0530
Message-ID: <70bbe810-5a84-85b6-01d3-1226c7645825@amd.com>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
 <20180802095617.GC9117@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0066.outbound.protection.outlook.com [104.47.33.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A086267692
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 09:28:21 +0200 (CEST)
In-Reply-To: <20180802095617.GC9117@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org



On 8/2/2018 3:26 PM, Mark Brown wrote:
> On Thu, Aug 02, 2018 at 12:11:54PM +0530, Akshu Agrawal wrote:
>> In capture case we don't want ACP to SYSMEM dma
>> to be circular. This is because if an in place DSP
>> filter is applied to captured output then circular DMA
>> can overwrite the filter value with stale data.
> 
> Isn't that just a problem with userspace not giving itself enough buffer
> to get the in place processing done before we loop round again.  This
> will simply change the type of error, it won't actually fix anything
> AFAICT but perhaps I'm missing something.
> 

Sorry for the delayed reply. Will try and explain more on whats happening:
We have 2 DMAs, one being I2S->ACP(Audio Co-Processor memory) and the
second being ACP->SYSMEM. When ACP->SYSMEM is circular then this DMA is
faster and keeps updating from ACP memory. This leaves no time for user
space to do any kind of in place post processing. This design works fine
if the user reads the data from SYSMEM at capture rate (that is the rate
at which I2S->ACP transfer happens). But, when an in place post
processing happens on SYSMEM then the data gets overwritten.

Sending and updated series with changes in 2/3 and 3/3 patch.

Thanks,
Akshu
