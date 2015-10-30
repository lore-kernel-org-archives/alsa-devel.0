From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Fri, 30 Oct 2015 15:04:37 -0700
Message-ID: <CAG5mAdwUKwzGvpO3ckKZWfE+oKXHK7umT5Z3Ru3Oyq8AD7gNMg@mail.gmail.com>
References: <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <20151029171936.GA3492@Asurada-CZ80>
 <CAG5mAdzci2hPUBzFo+k3+CorfzQZD9_knQ2TXw1db1KoBL5Eyw@mail.gmail.com>
 <20151029192816.GA43706@Asurada-CZ80>
 <CAG5mAdzJ2_MizAq2ACXwnA=wfO=xujGbUdB2OvcDi=7fHQfyBQ@mail.gmail.com>
 <20151029224713.GA44369@Asurada-CZ80>
 <CAG5mAdwnjLdxNNgC3go_NDERUSDxem9ZQFigyF5yaEWuXV2r4g@mail.gmail.com>
 <20151030012934.GA5456@Asurada-GSX>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id DA075260449
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 23:04:57 +0100 (CET)
Received: by wmll128 with SMTP id l128so22183719wml.0
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 15:04:57 -0700 (PDT)
In-Reply-To: <20151030012934.GA5456@Asurada-GSX>
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

On Thu, Oct 29, 2015 at 6:29 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Oct 29, 2015 at 04:33:26PM -0700, Caleb Crome wrote:
>
>> > A little difference between your point and mine is that you think
>> > DMA request only starts when SSIE and TDMAE both get set while I
>> > only think about TDMAE. It's hard to say which one is correct as
>> > it depends on the design of IP wrapper but you can fairly test it
>> > with your change below: Mask both TE with SSIE and set them after
>> > the delay. If it doesn't work, yours is the correct one.
>>
>> Ah, that's one thing that's very clear in the FSL datasheet:  the
>> FIFOs are ZEROED if SSIE is 0.  This means that even if the DMA were
>> trying to dump data in before SSIE is enabled, the data would go to
>> bit heaven.
>>
>> The docs for TE say, "The normal transmit enable sequence is to write
>> data to the STX register(s) and then set the TE bit." (page 5145 of
>> IMX6SDLRM.pdf)
>>
>> So in the DMA + fifo case the words, "write data to the STX
>> register(s)" imply that it's actually DMA writing to FIFOs, which then
>> write the STX register.  So, the sequence must be:  enable SSIE &
>> TDMAE to allow DMA to write to the fifo, then later enable TE, right?
>
> You have the point. If SSIEN is being treated as the reset signal
> internally, any write enable signal could be ignored.
>
>> > I encourage you to try to follow one of patches I gave you that
>> > sets TDMAE/RDMAE at the beginning of the trigger(). Surely you may
>> > change it to TDMAE | SSIE after you find out that SSIE is indeed
>> > required. If you are still having trouble, adding a delay would
>> > be nice for you but it may be hard for me to ack it if you want
>> > to merge it in the driver.
>>
>> I now I see your patch!  Okay, I'll give that a go, but it's still
>> just a race condition between the regmap_update_bits with TDMAE (your
>> patch) verses the regmap_update_bits from fsl_ssi_config. You're just
>> hoping that a DMA write happens between TDMAE and the end of
>> fsl_ssi_config where TE is enabled.
>
> DMA transaction will be issued once BD is ready (in SDMA driver)
> and SSI sends a DMA request. So I'm hoping that the context
> latency between the regmap_update_bits() and TE setting should be
> enough for DMA to fill the FIFO.
>
>> Now I think I get it though.  We do TMDAE + SSIEN like your patch,
>> then a short while loop on SFCSR.TFCNT0.  After the first word gets
>> written to the fifo, TFCNT0 should go > 0, and then we can release TE.
>>
>> There may be a better status register to wait on but TFCNT0 seems like
>> it will do the trick.
>
> Waiting for TFCNT0 sounds reasonable to me as long as the code is
> well commented.

Okay, so I tried out your patch and it has 2 separate issues:  the
first related to missing samples (even when I enabled the SSIEN), and
the second relating to the dual fifo.
So, first the missing samples.

**********************
** Problem 1 *******
**********************
When I enable your patch in single fifo mode we get maxburst lost
samples at the beginning of the stream.  The important bit is below.
It doesn't matter if the SSIEN comes before or after the TDMAE, the
samples are lost.  Surely because something in the fsl_ssi_config
clears the fifo.  I didn't look into that yet.
--------------------------- snip -------------------
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 73778c2..9d414e8 100644
@@ -1039,6 +1070,20 @@ static int fsl_ssi_trigger(struct
snd_pcm_substream *substream, int cmd,
     case SNDRV_PCM_TRIGGER_START:
     case SNDRV_PCM_TRIGGER_RESUME:
     case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+        /* eanble SSI */
+        regmap_update_bits(regs, CCSR_SSI_SCR,
+                   CCSR_SSI_SCR_SSIEN,
+                   CCSR_SSI_SCR_SSIEN);
+        /* and enable DMA to start data pumping */
+        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+            regmap_update_bits(regs, CCSR_SSI_SIER,
+                       CCSR_SSI_SIER_TDMAE,
+                       CCSR_SSI_SIER_TDMAE);
+        else
+            regmap_update_bits(regs, CCSR_SSI_SIER,
+                       CCSR_SSI_SIER_RDMAE,
+                       CCSR_SSI_SIER_RDMAE);
+
         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
             fsl_ssi_tx_config(ssi_private, true);
         else

--------------------------- snip -------------------

If instead, I do the SSIEN at the bottom of the fsl_ssi_configure
function like this, it works perfectly (in single fifo mode)

--------------------------- snip -------------------
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -435,8 +435,49 @@ static void fsl_ssi_config(struct fsl_ssi_private
*ssi_private, bool enable,

 config_done:
     /* Enabling of subunits is done after configuration */
-    if (enable)
+    if (enable) {
+        /* eanble SSI */
+        regmap_update_bits(regs, CCSR_SSI_SCR,
+                   CCSR_SSI_SCR_SSIEN,
+                   CCSR_SSI_SCR_SSIEN);
+        /*
+         * We must wait here until the DMA actually manages to
+         * get a word into the Tx FIFO.  Only if starting a Tx
+         * stream.
+         * In tests on an MX6 at 1GHz clock speed, the do
+         * loop below never iterated at all (i.e. it dropped
+         * through without repeating ever.  which means that
+         * the DMA has had time to get some words into the TX
+         * buffer. In fact, the tfcnt0 was always 13, so it
+         * was quite full by the time it reached this point,
+         * so this do loop should never be a bottleneck.  If
+         * max iterations is hit, then something might be
+         * wrong.  report it in that case.
+         */
+        int tfcnt0 = 0;
+        int tfcnt1 = 1;
+        int max_iterations = 1000;
+        if (vals->scr & CCSR_SSI_SCR_TE) {
+            u32 sfcsr;
+            do {
+                regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
+                tfcnt0 = CCSR_SSI_SFCSR_TFCNT0(sfcsr);
+                tfcnt1 = CCSR_SSI_SFCSR_TFCNT0(sfcsr);
+            } while(max_iterations-- && (tfcnt0 == 0) && (tfcnt1 == 0));
+        }
+        if (max_iterations <= 0) {
+            /*
+             * The DMA definitely should have stuck at
+             * least a word into the FIFO by now.  Report
+             * an error, but continue on blindly anyway,
+             * even though the SSI might not start right.
+             */
+            struct platform_device *pdev = ssi_private->pdev;
+            dev_err(&pdev->dev, "max_iterations reached when"
+                "starting SSI Tx\n");
+        }
         regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
+    }
 }
--------------------------- snip -------------------

When all is fixed, the data comes in perfect order:
(most significant nibble is channel # from wav file, least significant
12 bits are frame number).
(hope that lines don't wrap at 79 characters...)
0000,1000,2000,3000,4000,5000,6000,7000,8000,9000,a000,b000,c000,d000,e000,f000
0001,1001,2001,3001,4001,5001,6001,7001,8001,9001,a001,b001,c001,d001,e001,f001
0002,1002,2002,3002,4002,5002,6002,7002,8002,9002,a002,b002,c002,d002,e002,f002
0003,1003,2003,3003,4003,5003,6003,7003,8003,9003,a003,b003,c003,d003,e003,f003
...
00fd,10fd,20fd,30fd,40fd,50fd,60fd,70fd,80fd,90fd,a0fd,b0fd,c0fd,d0fd,e0fd,f0fd
00fe,10fe,20fe,30fe,40fe,50fe,60fe,70fe,80fe,90fe,a0fe,b0fe,c0fe,d0fe,e0fe,f0fe
00ff,10ff,20ff,30ff,40ff,50ff,60ff,70ff,80ff,90ff,a0ff,b0ff,c0ff,d0ff,e0ff,f0ff
and all zeros after that.

FYI, this is a 256 frame, 16 channel sound file for doing this test.

**********************
** Problem 2 *******
**********************
When the dual fifo mode is enabled, the data comes in the following order:
0000,1000,2000,3000,4000,5000,6000,7000,8000,9000,a000,b000,c000,d000,e000,f000
0001,1001,2001,3001,4001,5001,6001,7001,8001,9001,a001,b001,c001,d001,e001,1002
0002,3002,2002,5002,4002,7002,6002,9002,8002,b002,a002,d002,c002,f002,e002,1003
0003,3003,2003,5003,4003,7003,6003,9003,8003,b003,a003,d003,c003,f003,e003,1004

Strange, right?  Frame 0 is perfect, however after the first frame,
the data gets scrambled and from then on is wrong.
The pattern stays consistent after frame 2.


Looks like I need to stick with single fifo for now.

So, bottom line is:  single fifo seems to work perfectly with my
proposed fix above.  Dual fifo doesn't seem to work.

-caleb
