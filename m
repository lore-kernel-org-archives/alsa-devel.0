From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add Left_J
	support
Date: Wed, 3 Jun 2009 20:33:42 +0800
Message-ID: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id DEE7624382
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:33:43 +0200 (CEST)
Received: by qyk1 with SMTP id 1so12239325qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:33:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Make the pxa I2S configuration generic, add support for Left_J, add
support for variable frame width like 32fs, 48fs, 64fs and 96fs

Signed-off-by: Paul Shen <bshen9@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 +++---
 sound/soc/pxa/pxa-ssp.c                   |   62 ++++++++++++++--------------
 sound/soc/pxa/pxa-ssp.h                   |    9 ++++
 3 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h
b/arch/arm/mach-pxa/include/mach/regs-ssp.h
index 6a2ed35..27f0cd4 100644
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
+#define SSPSP_DMYSTRT(x)	((((x) & 3) << 7)  | ((((x) >> 2) & 3) << 26))
+#define SSPSP_DMYSTOP(x)	((((x) & 3) << 23) | ((((x) >> 2) & 7) << 28))
+
 #define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
 #define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
 #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6fc7876..2831c16 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -463,7 +463,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,

 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		sscr0 |= SSCR0_PSP;
+	case SND_SOC_DAIFMT_LEFT_J:
+		sscr0 |= SSCR0_PSP | SSCR0_MOD;
 		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;

 		/* See hw_params() */
@@ -541,6 +542,7 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	int chn = params_channels(params);
 	u32 sscr0;
 	u32 sspsp;
+	int frame_width;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;

@@ -585,40 +587,38 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,

 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
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
+		sspsp = ssp_read_reg(ssp, SSPSP);
+		frame_width = PXA_SSP_FRM_WIDTH(priv->dai_fmt);

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
+		if (frame_width < width * 2)
 			return -EINVAL;
-#endif
-		} else {
-			/* The frame width is the width the LRCLK is
-			 * asserted for; the delay is expressed in
-			 * half cycle units.  We need the extra cycle
-			 * because the data starts clocking out one BCLK
-			 * after LRCLK changes polarity.
+
+		if (frame_width == width * 2)
+			/* frame width is exactly double of data sample width,
+			 * use FSRT instead
 			 */
-			sspsp |= SSPSP_SFRMWDTH(width + 1);
-			sspsp |= SSPSP_SFRMDLY((width + 1) * 2);
+			sspsp |= SSPSP_FSRT | SSPSP_SFRMWDTH(width);
+		else {
 			sspsp |= SSPSP_DMYSTRT(1);
+			sspsp |= SSPSP_DMYSTOP((frame_width / 2 - width - 1));
+			sspsp |= SSPSP_SFRMWDTH(frame_width / 2);
+		}
+
+		ssp_write_reg(ssp, SSPSP, sspsp);
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		sspsp = ssp_read_reg(ssp, SSPSP);
+		frame_width = PXA_SSP_FRM_WIDTH(priv->dai_fmt);
+
+		if (frame_width < width * 2)
+			return -EINVAL;
+
+		if (frame_width == width * 2)
+			sspsp |= SSPSP_SFRMWDTH(width);
+		else {
+			sspsp |= SSPSP_DMYSTOP((frame_width / 2 - width));
+			sspsp |= SSPSP_SFRMWDTH(frame_width / 2);
 		}

 		ssp_write_reg(ssp, SSPSP, sspsp);
diff --git a/sound/soc/pxa/pxa-ssp.h b/sound/soc/pxa/pxa-ssp.h
index 91deadd..fda51d0 100644
--- a/sound/soc/pxa/pxa-ssp.h
+++ b/sound/soc/pxa/pxa-ssp.h
@@ -40,6 +40,15 @@
 #define PXA_SSP_CLK_SCDB_1		1
 #define PXA_SSP_CLK_SCDB_8		2

+/* frame size definitions for I2S and Left_J formats - default is
+ * 32fs, other possibilities are 48fs, 64fs and 96fs
+ */
+#define PXA_SSP_FRM_32FS	(0 << 16)
+#define PXA_SSP_FRM_48FS	(1 << 16)
+#define PXA_SSP_FRM_64FS	(2 << 16)
+#define PXA_SSP_FRM_96FS	(3 << 16)
+#define PXA_SSP_FRM_WIDTH(x)	(((((x) >> 16) & 0x3) + 2) << 4)
+
 #define PXA_SSP_PLL_OUT  0

 extern struct snd_soc_dai pxa_ssp_dai[4];
-- 
1.6.0.4
