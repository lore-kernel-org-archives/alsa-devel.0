From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: pxa-ssp.c handle the I2S and LEFT_J
	cases.
Date: Thu,  6 Aug 2009 15:55:19 +0100
Message-ID: <1249570519-32622-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 016D624553
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 16:55:21 +0200 (CEST)
In-Reply-To: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <boshen9@gmail.com>, Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Ribeiro <drwyrm@gmail.com>

Handles I2S and LEFT_J cases, if the user does _not_ call set_tdm_slot
we assume that the codec is I2S compliant, and that we can use
frame_width = sample_width * channels.

If the user calls set_tdm_slot then we assume that the wire is _not_
networked, and that the user wants to set a non-standard frame format
instead, in this case we set the frame duration (the LRCLK falling edge)
to be half of the wire frame width.

eg.
* standard 2*[16|24|32|..] bits I2S/LEFT_J doesn't need to call
set_tdm_slot
* to use 2*16bits I2S/LEFTJ on 64bits frames, with the LRCLK falling
edge at the 32nd bitclk (+1 for I2S) needs to set_tdm_slot(5, 5, 4, 16)
(4 slots of 16 bits, first and third RX/TX slots active). This should
work even if pxa is slave of SFRM.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 ++--
 sound/soc/pxa/pxa-ssp.c                   |  121 +++++++++++++---------------
 2 files changed, 63 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h b/arch/arm/mach-pxa/include/mach/regs-ssp.h
index 6a2ed35..060e23b 100644
--- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
+++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
@@ -108,21 +108,21 @@
 #define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
 #define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */
 
-#if defined(CONFIG_PXA3xx)
-#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
-#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
-#endif
-
 #define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
-#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
 #define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
 #define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
-#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
 #define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
 #define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
 #define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
 #define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
 
+/* NOTE: PXA3xx extends the bit number of dummy start and stop, the macros
+ * below are compatible with PXA25x/27x as long as the parameter is within
+ * the correct limits, driver code has to take care of this.
+ */
+#define SSPSP_DMYSTRT(x)       ((((x) & 3) << 7)  | ((((x) >> 2) & 3) << 26))
+#define SSPSP_DMYSTOP(x)       ((((x) & 3) << 23) | ((((x) >> 2) & 7) << 28))
+
 #define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
 #define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
 #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index d60492e..aac85fe 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -179,21 +179,6 @@ static void ssp_set_scr(struct ssp_device *ssp, u32 div)
 	ssp_write_reg(ssp, SSCR0, sscr0);
 }
 
-/**
- * ssp_get_clkdiv - get SSP clock divider
- */
-static u32 ssp_get_scr(struct ssp_device *ssp)
-{
-	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
-	u32 div;
-
-	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
-		div = ((sscr0 >> 8) & 0xff) * 2 + 2;
-	else
-		div = ((sscr0 >> 8) & 0xfff) + 1;
-	return div;
-}
-
 /*
  * Set the SSP ports SYSCLK.
  */
@@ -487,17 +472,14 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		sscr0 |= SSCR0_PSP;
-		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
-		/* See hw_params() */
-		break;
-
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |= SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_I2S:
 		sscr0 |= SSCR0_PSP;
 		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
+		/* See hw_params() for I2S and LEFT_J */
 		break;
 
 	default:
@@ -561,6 +543,59 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		sscr0 |= SSCR0_FPCKE;
 #endif
 
+	sspsp = ssp_read_reg(ssp, SSPSP);
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		/*
+		 * I2S and LEFT_J are stereo only, we have to send data for
+		 * both channels.
+		 */
+		if (chn == 1)
+			frame_width *= 2;
+
+		/*
+		 * If the user did not use network mode, we assume the codec
+		 * is I2S compliant.
+		 */
+		if (frame_width > 0) {
+			sspsp |= SSPSP_SFRMWDTH(frame_width / 2);
+			sspsp |= SSPSP_FSRT;
+		} else {
+			/*
+			 * Otherwise we assume that it is a single TDM slot, and
+			 * the user is abusing set_tdm_slot to support an
+			 * out of spec codec.
+			 */
+			int slots = ((sscr0 & SSCR0_SlotsPerFrm(8)) >> 24) + 1;
+
+			/* PXA2XX doesn't support DMYSTOP > 3 */
+			if (slot_width != (width * 2) && !cpu_is_pxa3xx())
+				return -EINVAL;
+
+			sspsp |= SSPSP_DMYSTRT(1);
+			sspsp |= SSPSP_DMYSTOP(
+					(slot_width * slots) / 2 - width - 1);
+			sspsp |= SSPSP_SFRMWDTH((slot_width * slots) / 2);
+		}
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		if (chn == 1)
+			frame_width *= 2;
+
+		if (frame_width > 0) {
+			sspsp |= SSPSP_SFRMWDTH(frame_width / 2);
+		} else {
+			int slots = ((sscr0 & SSCR0_SlotsPerFrm(8)) >> 24) + 1;
+
+			sspsp |= SSPSP_SFRMWDTH((slot_width * slots) / 2);
+		}
+		break;
+	default:
+		break;
+	}
+	ssp_write_reg(ssp, SSPSP, sspsp);
+
 	if (frame_width > 0) {
 		/* Not using network mode */
 		if (frame_width > 16)
@@ -598,50 +633,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 
 	ssp_write_reg(ssp, SSCR0, sscr0);
 
-	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-	       sspsp = ssp_read_reg(ssp, SSPSP);
-
-		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {
-			/* This is a special case where the bitclk is 64fs
-			* and we're not dealing with 2*32 bits of audio
-			* samples.
-			*
-			* The SSP values used for that are all found out by
-			* trying and failing a lot; some of the registers
-			* needed for that mode are only available on PXA3xx.
-			*/
-
-#ifdef CONFIG_PXA3xx
-			if (!cpu_is_pxa3xx())
-				return -EINVAL;
-
-			sspsp |= SSPSP_SFRMWDTH(width * 2);
-			sspsp |= SSPSP_SFRMDLY(width * 4);
-			sspsp |= SSPSP_EDMYSTOP(3);
-			sspsp |= SSPSP_DMYSTOP(3);
-			sspsp |= SSPSP_DMYSTRT(1);
-#else
-			return -EINVAL;
-#endif
-		} else {
-			/* The frame width is the width the LRCLK is
-			 * asserted for; the delay is expressed in
-			 * half cycle units.  We need the extra cycle
-			 * because the data starts clocking out one BCLK
-			 * after LRCLK changes polarity.
-			 */
-			sspsp |= SSPSP_SFRMWDTH(width + 1);
-			sspsp |= SSPSP_SFRMDLY((width + 1) * 2);
-			sspsp |= SSPSP_DMYSTRT(1);
-		}
-
-		ssp_write_reg(ssp, SSPSP, sspsp);
-		break;
-	default:
-		break;
-	}
-
 	dump_registers(ssp);
 
 	return 0;
-- 
1.6.3.3
