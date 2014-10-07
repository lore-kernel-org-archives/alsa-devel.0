From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: sgtl5000: Cleanup the comments
Date: Tue, 7 Oct 2014 10:50:56 -0300
Message-ID: <1412689856-7605-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0114.outbound.protection.outlook.com [157.56.111.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1F1260490
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 15:51:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix grammar and typos. 

Besides that, also fix the comment about the range of SYS_MCLK, which is from
8 to 27 MHz.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6bb77d7..10160e7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -530,16 +530,16 @@ static int sgtl5000_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 /*
  * set clock according to i2s frame clock,
- * sgtl5000 provide 2 clock sources.
- * 1. sys_mclk. sample freq can only configure to
+ * sgtl5000 provides 2 clock sources:
+ * 1. sys_mclk: sample freq can only be configured to
  *	1/256, 1/384, 1/512 of sys_mclk.
- * 2. pll. can derive any audio clocks.
+ * 2. pll: can derive any audio clocks.
  *
  * clock setting rules:
- * 1. in slave mode, only sys_mclk can use.
- * 2. as constraint by sys_mclk, sample freq should
- *	set to 32k, 44.1k and above.
- * 3. using sys_mclk prefer to pll to save power.
+ * 1. in slave mode, only sys_mclk can be used
+ * 2. as constraint by sys_mclk, sample freq should be set to 32 kHz, 44.1 kHz
+ * and above.
+ * 3. usage of sys_mclk is preferred over pll to save power.
  */
 static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 {
@@ -549,8 +549,8 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 
 	/*
 	 * sample freq should be divided by frame clock,
-	 * if frame clock lower than 44.1khz, sample feq should set to
-	 * 32khz or 44.1khz.
+	 * if frame clock is lower than 44.1 kHz, sample freq should be set to
+	 * 32 kHz or 44.1 kHz.
 	 */
 	switch (frame_rate) {
 	case 8000:
@@ -603,7 +603,8 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 
 	/*
 	 * calculate the divider of mclk/sample_freq,
-	 * factor of freq =96k can only be 256, since mclk in range (12m,27m)
+	 * factor of freq = 96 kHz can only be 256, since mclk is in the range
+	 * of 8 MHz - 27 MHz
 	 */
 	switch (sgtl5000->sysclk / sys_fs) {
 	case 256:
@@ -619,7 +620,7 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 			SGTL5000_MCLK_FREQ_SHIFT;
 		break;
 	default:
-		/* if mclk not satisify the divider, use pll */
+		/* if mclk does not satisfy the divider, use pll */
 		if (sgtl5000->master) {
 			clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
 				SGTL5000_MCLK_FREQ_SHIFT;
@@ -795,7 +796,7 @@ static int ldo_regulator_enable(struct regulator_dev *dev)
 				SGTL5000_LINEREG_D_POWERUP,
 				SGTL5000_LINEREG_D_POWERUP);
 
-	/* when internal ldo enabled, simple digital power can be disabled */
+	/* when internal ldo is enabled, simple digital power can be disabled */
 	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				SGTL5000_LINREG_SIMPLE_POWERUP,
 				0);
@@ -1079,7 +1080,7 @@ static bool sgtl5000_readable(struct device *dev, unsigned int reg)
 /*
  * sgtl5000 has 3 internal power supplies:
  * 1. VAG, normally set to vdda/2
- * 2. chargepump, set to different value
+ * 2. charge pump, set to different value
  *	according to voltage of vdda and vddio
  * 3. line out VAG, normally set to vddio/2
  *
-- 
1.9.1
