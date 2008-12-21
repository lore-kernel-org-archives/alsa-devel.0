From: naveenkrishna.ch <naveenkrishna.ch@gmail.com>
Subject: Re: patch 1/1: ASoC,
	DMA crash with application- resolved
Date: Sun, 21 Dec 2008 15:08:21 +0530
Message-ID: <ef0d8a250812210138q3cad7dbay21611e2088a1525b@mail.gmail.com>
References: <ef0d8a250812202322i3fe62ed2n2d1e09ab830e27dd@mail.gmail.com>
	<bd7b27490812210136m710dc896j43c060e14bc5fb4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 772F924156
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 10:38:22 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so562409yxh.2
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 01:38:21 -0800 (PST)
In-Reply-To: <bd7b27490812210136m710dc896j43c060e14bc5fb4a@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 21, 2008 at 3:06 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Sun, Dec 21, 2008 at 9:22 AM, naveenkrishna. ch <
> naveenkrishna.ch@gmail.com> wrote:
>
>> Hi ALSA SOC,
>>
>> I am using a OMAP3 + TWL4030 combination with ASoC
>>
>> in the sound/soc/omap/omap-pcm.c
>> DMA channels are being freed after unlinking in the omap_pcm_hw_free
>> function
>>
>> Which is causing a crash during applications
>> So, stopping the DMA channels before unlinking resolves the issue.
>>
>> here is the patch that solves the issue
>>
>> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
>> index e9084fd..679e384 100644
>> --- a/sound/soc/omap/omap-pcm.c
>> +++ b/sound/soc/omap/omap-pcm.c
>> @@ -116,6 +116,7 @@ static int omap_pcm_hw_free(struct snd_pcm_substream
>> *substream)
>>        if (prtd->dma_data == NULL)
>>                return 0;
>>
>> +       omap_stop_dma(prtd->dma_ch);
>>        if (!cpu_is_omap1510())
>>                omap_dma_unlink_lch(prtd->dma_ch, prtd->dma_ch);
>>        omap_free_dma(prtd->dma_ch);
>>
>>
>> Is this ok or is there any better way out
>> --
>>
>
> This looks a bit familiar, I hope so. Is this from linux-omap, mainline or
> in-house kernel?
>
This is what i have seen in the alsa-kernel

>
>
> There were similar issues fixed by following two patches in linux-omap.
> Second one is not yet in mainline, have to confirm with Tony has he queued
> it now.
>
> commit 66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e
> Author: Jarkko Nikula <jarkko.nikula@nokia.com>
> Date:   Tue May 13 13:26:03 2008 +0300
>
>     ARM: OMAP: DMA: Don't mark channel active in omap_enable_channel_irq
>
>     Channel should be marked active only when DMA is really started.
> Otherwise
>     just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch will
> cause
>     incorrect dump_stack().
>
>
> commit 55502f74b56f609a84d8919b9b29390b2e0147ff
> Author: Jarkko Nikula <jarkko.nikula@nokia.com>
> Date:   Mon Aug 18 12:28:22 2008 +0300
>
>     ARM: OMAP: DMA: Fix uninitialized channel flags
>
>     This has similar symptoms than 66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e
>     where just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch
>     can cause incorrect dump_stack(). Here it can happen if channel has
> been
>     used before and the channel flags variable holds old status.
>
>     Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
>
>
> Then it's worth to verify also this very recent fix. This is already in
> mainline and will flow into linux-omap when Tony does the pull.
>
> commit 19b3f31609dc8be3a56c78dcb7da723f10f7009c
> Author: Stanley Miao <stanley.miao@windriver.com>
> Date:   Fri Dec 19 22:08:22 2008 +0800
>
>     ALSA: Fix a Oops bug in omap soc driver.
>
>     There will be a Oops or frequent underrun messages when playing music
> with
>     omap soc driver, this is because a data region is incorretly sized,
> other da
>     region will be overwriten when writing to this data region.
>
>
> Jarkko
>



-- 
Thanks,
keep smiling...
keep winning...

(: Naveen Krishna Ch :)
