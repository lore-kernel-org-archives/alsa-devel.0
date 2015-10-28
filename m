From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Wed, 28 Oct 2015 15:06:40 -0700
Message-ID: <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AC6BD264FFF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 23:07:00 +0100 (CET)
Received: by wmff134 with SMTP id f134so13120692wmf.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 15:07:00 -0700 (PDT)
In-Reply-To: <20151027201101.GA9527@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Roberto Fichera <kernel@tekno-soft.it>
Cc: Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 27, 2015 at 1:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Tue, Oct 27, 2015 at 08:13:44AM +0100, Markus Pargmann wrote:
>
>> > So, the dma priority doesn't seem to be the issue.  It's now set in
>> > the device tree, and strangely it's set to priority 0 (the highest)
>> > along with the UARTS.  priority 0 is just the highest in the device
>> > tree -- it gets remapped to priority 3 in the sdma driver.  the DT
>> > exposes only 3 levels of DMA priority, low, medium, and high.  I
>> > created a new level that maps to DMA priroity 7 (the highest in the
>> > hardware), but still got the problem.
>> >
>> > So, still something unknown causing dma to miss samples.  must be in
>> > the dma ISR I would assume.  I guess it's time to look into that.
>
>> Cc Nicolin, Fabio, Shawn
>>
>> Perhaps you have an idea about this?
>
> Off the top of my head:
>
> 1) Enable TUE0, TUE1, ROE0, ROE1 to see if there is any IRQ trigged.
Ah, I found that SIER TIE & RIE were not enabled. I enabled them (and
just submitted a patch to the list, which will need to be fixed).

With my 2 patches, the

/sys/kernel/debug/2028000.ssi/stats

file now shows the proper interrupts.

>
> 2) Set the watermarks for both TX and RX to 8 while using burst sizes
>    of 6. It'd be nicer to provisionally set these numbers using hard
>    code than your current change depending on fifo_depth as it might
>    be an odd value.

Ah, this is fascinating you say this.  fifo_depth is definitely odd,
it's 15 as set in imx6qdl.dtsi:
fsl,fifo-depth = <15>;
But the DMA maxburst is made even later in the code...

Setting the watermark to 8 and maxburst to 8 dramatically reduces the
channel slip rate, in fact, i didn't see a slip for more than 30
minutes of playing.  That's a new record for sure.  But, eventually,
there was an underrun, and the channels slipped.

Setting watermark to 8 and maxburst to 6 still had some slips,
seemingly more than 8 & 8.

I feel like a monkey randomly typing at my keyboard though.  I don't
know why maxburst=8 worked better.  I get the
feeling that I was just lucky.

There does seem to be a correlation between user space reported
underruns and this channel slip, although they definitely are not 1:1
ratio:  underruns happen without slips and slips happen without
underruns.  The latter is very disturbing because user space has no
idea something is wrong.

My test is simply to run aplay with a 1000 second, 16 channel sound
file, and watch
the data decoded on my scope.   The sound file has the channel number
encoded as the most significant nibble of each word, and a do a
conditional trigger to watch to make sure the most significant nibble
after the fram sync is '0'.  i.e. trigger if there is a rising edge on
data within 300ns of the rising edge of fsync.

Here's the patch that has worked the best so far.

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 73778c2..b834f77 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -943,7 +943,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
         * size.
         */
        if (ssi_private->use_dma)
-               wm = ssi_private->fifo_depth - 2;
+               wm = 8;
        else
                wm = ssi_private->fifo_depth;

@@ -1260,8 +1260,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
         * We have burstsize be "fifo_depth - 2" to match the SSI
         * watermark setting in fsl_ssi_startup().
         */
-       ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
-       ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
+       ssi_private->dma_params_tx.maxburst = 8;
+       ssi_private->dma_params_rx.maxburst = 8;
        ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
        ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;


>
> 3) Try to enlarge the ALSA period size in the asound.conf or passing
>    parameters when you do the playback/capture so that the number of
>    interrupts from SDMA may reduce.
I checked this earlier and it seemed to help, but didn't solve the
issue.  I will check it again with my latest updates.

-Caleb



>
> You may also see if the reproducibility is somehow reduced or not.
>
> Nicolin
