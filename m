From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 12:06:16 -0700
Message-ID: <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
References: <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5B226170F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 20:06:36 +0100 (CET)
Received: by wmeg8 with SMTP id g8so30080178wme.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 12:06:36 -0700 (PDT)
In-Reply-To: <20151029171936.GA3492@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

STARTUP ISSUE SOLVED (INELEGANTLY)

:-)

On Thu, Oct 29, 2015 at 10:19 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Oct 29, 2015 at 06:44:12AM -0700, Caleb Crome wrote:
>> > Reported by user space? Are you saying that's an ALSA underrun in
>> > the user space, not a hardware underrun reported by the IRQ in the
>> > driver? They are quite different. ALSA underrun comes from the DMA
>> > buffer gets underrun while the other one results from FIFO feeding
>> > efficiency. For ALSA underrun, enlarging the playback period size
>> > and period number will ease the problem:
>
>> Sometimes they happen at the same time.  So, I run aplay, and all is
>
> The 'they' is indicating ALSA underrun + hardware underrun or ALSA
> underrun + channel slip?

Exactly, they tend to come together, but either can come without the other.

> It's not quite logical for a channel slip
> resulting from an ALSA underrun as it should restart by calling the
> trigger() functions in DAI drivers IIRC.

This actually is exactly what I'm seeing now.  I'm seeing the
*startup* happening from the trigger starting up slipped.  So this
does make perfect sense to me.

I am playing a very short ramp.wav file and seeing how often it starts
up 'slipped' with the extra 0.  It started up incorrectly 20 out of
300 trials.  So, the startup is failing 7% of the time.

It occurred to me that perhaps the problem has to do when exactly when
during the frame-sync period the fsl_ssi_trigger function was called.
Perhaps, if it's called near the end or beginning of a frame, somehow
something gets messed up.  (The docs for the SCR register imply some
of this, but it talks about either 2 or 6 bit clocks, so I'd expect
the error rate to be lower than 7% (more like 2.5%).

So, I implemented a really inelegant patch to synchronize the trigger
with the frame sync signal, and I got ZERO errors out of 500 trials!
This seems to have nailed the startup problem!

In addition, I have run about 20 minutes of audio with no slips or
problems, even though there have been aplay underruns.  This is a
major step forward for me :-)

The idea is to enable the SSI before enabling DMA.  Then wait for a
frame sync by polling.  Once I get the frame sync disable the SSI, and
let the trigger function continue.

How should this be done properly?

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 73778c2..8cd8284 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -328,6 +328,41 @@ static void fsl_ssi_rxtx_config(struct
fsl_ssi_private *ssi_private,
     }
 }

+/*
+ * wait for a frame sync.  do this by enabling the SSI,
+ * then waiting for sync to happen, then disabling the SSI
+ * and put it back to the state it was at first
+ */
+static void wait_for_tfs(struct regmap *regs)
+{
+    u32 tfs;
+    u32 scr;
+    int maxcount = 100000;
+    regmap_read(regs, CCSR_SSI_SCR, &scr);
+    regmap_update_bits(regs, CCSR_SSI_SCR, 0x3, 0x3);
+    while(maxcount--) {
+        /* clear TFS bit */
+        regmap_update_bits(regs, CCSR_SSI_SISR, CCSR_SSI_SISR_TFS, 0);
+        regmap_read(regs, CCSR_SSI_SISR, &tfs);
+        if ((tfs & CCSR_SSI_SISR_TFS)==0)
+            break; /* tfs went to 0 */
+    }
+    if (maxcount < 0) {
+        printk(KERN_INFO "timed out 1, sisr = 0x%08x\n", tfs);
+    }
+    maxcount = 100000;
+    while(maxcount--) {
+        /* waiting for tfs to go to 1. */
+        regmap_read(regs, CCSR_SSI_SISR, &tfs);
+        if ((tfs & CCSR_SSI_SISR_TFS))
+            break; /* tfs went to 1 */
+    }
+    if (maxcount < 0) {
+        printk(KERN_INFO "timed out 2\n");
+    }
+    regmap_write(regs, CCSR_SSI_SCR, scr);
+}
+
 /*
  * Calculate the bits that have to be disabled for the current stream that is
  * getting disabled. This keeps the bits enabled that are necessary for the
@@ -360,7 +395,10 @@ static void fsl_ssi_config(struct fsl_ssi_private
*ssi_private, bool enable,
     int nr_active_streams;
     u32 scr_val;
     int keep_active;
-
+    wait_for_tfs(regs); /* synchronize with the start of a frame
+                 * to get done with this function well
+                 * before the end of a frame
+                 */
     regmap_read(regs, CCSR_SSI_SCR, &scr_val);

     nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
@@ -943,9 +980,9 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
      * size.
      */
     if (ssi_private->use_dma)
-        wm = ssi_private->fifo_depth - 2;
+        wm = 8;
     else
-        wm = ssi_private->fifo_depth;
+        wm = 8;

     regmap_write(regs, CCSR_SSI_SFCSR,
             CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
@@ -1260,8 +1297,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
      * We have burstsize be "fifo_depth - 2" to match the SSI
      * watermark setting in fsl_ssi_startup().
      */
-    ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
-    ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
+    ssi_private->dma_params_tx.maxburst = 8;
+    ssi_private->dma_params_rx.maxburst = 8;
     ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
     ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;

>
>> fine.  Then the user space app will underrun, and then I look at the
>> scope, and the channels have slipped.  So somehow the start/restart
>> after the underrun is not always perfect I guess.
>
>> Is there any mechanism for the DMA fifo underruns to be reported back
>> to user space?  There certainly should be, because the consequences
>
> No. The release from Freescale official tree has a reset procedure
> applied to ESAI underrun but not SSI but I guess you may want to
> refer to that.

Ooh, that can be a problem.   Maybe I'll take a look.  But for the
moment, it appears that, so far, for now, the system is working.

-Caleb
