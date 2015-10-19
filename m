From: Caleb Crome <caleb@crome.org>
Subject: fsl_ssi.c: Getting channel slips with fsl_ssi.c in TDM
	(network) mode.
Date: Mon, 19 Oct 2015 08:55:38 -0700
Message-ID: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 766B22654BA
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 17:55:58 +0200 (CEST)
Received: by wicfv8 with SMTP id fv8so12544965wic.0
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 08:55:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Arnaud, all,

I'm trying to get the i.MX6 SSI working in 16-channel TDM mode.  FYI, I'm
working with the stock 4.3 kernel at https://github.com/torvalds/linux.

When I apply the patch below, the SSI does all configure properly and even
starts streaming properly with all the bits in the right place on the SSI
pins.  However, given a little bit of time and/or IO to the SD card, the
bit-stream slips by 1 slot, causing all of the channels to be misaligned.

My changes to the SSI driver are very minimal (shown below), and amount to
forcing it into network (TDM) mode, and changing the maximum channels, and
setting the STCCR DC mask.

There is no indication from user space that anything has slipped, so the
data stream just continues on shifted by 1 slot.

You (Arnaud) mentioned in a previous thread ("Multiple codecs on one sound
card for multi-channel sound card"), that I should just have to set
channels_max (and presumably the other changes I mentioned), and it'll work
mostly.  However, it's very unreliable at the moment.

Any thoughts to how I can diagnose this problem would be greatly
appreciated!

So, what happens is this:

The SSI Starts sending data like this:
SLOT 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
DATA 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15

But then after time, something slips and without warning it goes to:
SLOT 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
DATA 15 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 37c5cd4..73778c2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -749,7 +749,10 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream
*substream,
                 CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
                 channels == 1 ? 0 : i2smode);
     }
-
+    ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
CCSR_SSI_SCR_NET;
+    regmap_update_bits(regs, CCSR_SSI_SCR,
+               CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
+               ssi_private->i2s_mode);
     /*
      * FIXME: The documentation says that SxCCR[WL] should not be
      * modified while the SSI is enabled.  The only time this can
@@ -863,6 +866,15 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
         return -EINVAL;
     }
     scr |= ssi_private->i2s_mode;
+    // Set to 16 slots/frame
+    regmap_update_bits(regs, CCSR_SSI_STCCR,
+               CCSR_SSI_SxCCR_DC_MASK,
+               CCSR_SSI_SxCCR_DC(16));
+
+    regmap_update_bits(regs, CCSR_SSI_SRCCR,
+               CCSR_SSI_SxCCR_DC_MASK,
+               CCSR_SSI_SxCCR_DC(16));
+

     /* DAI clock inversion */
     switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -1084,14 +1099,14 @@ static struct snd_soc_dai_driver
fsl_ssi_dai_template = {
     .playback = {
         .stream_name = "CPU-Playback",
         .channels_min = 1,
-        .channels_max = 2,
+        .channels_max = 16,
         .rates = FSLSSI_I2S_RATES,
         .formats = FSLSSI_I2S_FORMATS,
     },
     .capture = {
         .stream_name = "CPU-Capture",
         .channels_min = 1,
-        .channels_max = 2,
+        .channels_max = 16,
         .rates = FSLSSI_I2S_RATES,
         .formats = FSLSSI_I2S_FORMATS,
     },

Another thing I have tried is changing the watermark level for the fifo to
give the DMA interrupt some extra time.  The problem still happens, but
seems to be a bit better.

The fifo watermark change is this:
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 73778c2..7c2e4b0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -54,6 +54,8 @@
 #include "fsl_ssi.h"
 #include "imx-pcm.h"

+#define WATERMARK 8
+
 /**
  * FSLSSI_I2S_RATES: sample rates supported by the I2S
  *
@@ -943,7 +950,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
      * size.
      */
     if (ssi_private->use_dma)
-        wm = ssi_private->fifo_depth - 2;
+        wm = ssi_private->fifo_depth - WATERMARK;
     else
         wm = ssi_private->fifo_depth;

@@ -1260,8 +1267,8 @@ static int fsl_ssi_imx_probe(struct platform_device
*pdev,
      * We have burstsize be "fifo_depth - 2" to match the SSI
      * watermark setting in fsl_ssi_startup().
      */
-    ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
-    ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
+    ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth -
WATERMARK;
+    ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth -
WATERMARK;
     ssi_private->dma_params_tx.addr = ssi_private->ssi_phys +
CCSR_SSI_STX0;
     ssi_private->dma_params_rx.addr = ssi_private->ssi_phys +
CCSR_SSI_SRX0;


Thanks,
  -Caleb
