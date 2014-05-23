From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Fix the cache handling
Date: Fri, 23 May 2014 00:16:01 -0300
Message-ID: <1400814961-14230-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F032265634
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 05:16:12 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id i50so7073703qgf.17
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 20:16:11 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly) a 
kernel oops is observed after a suspend/resume sequence.

According to Mark Brown:

"Yes, reg_cache isn't there if we're not using ASoC level caching.  The
fix should just be to replace the direct cache references with
snd_soc_read()s which will end up in a cache lookup if the register is
cached."

Do as suggested and also complete the cache array with the missing registers
so that sgtl5000_restore_regs() can properly cache the all the registers it 
needs.

Reported-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 9626ee0..aac4fbc 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -36,18 +36,32 @@
 
 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] = {
+	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
 	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
 	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_SSS_CTRL,		0x0010 },
+	{ SGTL5000_CHIP_ADCDAC_CTRL,		0x020c },
 	{ SGTL5000_CHIP_DAC_VOL,		0x3c3c },
 	{ SGTL5000_CHIP_PAD_STRENGTH,		0x015f },
+	{ SGTL5000_CHIP_ANA_ADC_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
 	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
+	{ SGTL5000_CHIP_LINREG_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_REF_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_MIC_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_LINE_OUT_CTRL,		0x0000 },
 	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
 	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },
 	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
+	{ SGTL5000_CHIP_CLK_TOP_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_ANA_STATUS,		0x0000 },
+	{ SGTL5000_CHIP_SHORT_CTRL,		0x0000 },
+	{ SGTL5000_CHIP_ANA_TEST2,		0x0000 },
+	{ SGTL5000_DAP_CTRL,			0x0000 },
+	{ SGTL5000_DAP_PEQ,			0x0000 },
 	{ SGTL5000_DAP_BASS_ENHANCE,		0x0040 },
 	{ SGTL5000_DAP_BASS_ENHANCE_CTRL,	0x051f },
+	{ SGTL5000_DAP_AUDIO_EQ,		0x0000 },
 	{ SGTL5000_DAP_SURROUND,		0x0040 },
 	{ SGTL5000_DAP_EQ_BASS_BAND0,		0x002f },
 	{ SGTL5000_DAP_EQ_BASS_BAND1,		0x002f },
@@ -55,6 +69,7 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_DAP_EQ_BASS_BAND3,		0x002f },
 	{ SGTL5000_DAP_EQ_BASS_BAND4,		0x002f },
 	{ SGTL5000_DAP_MAIN_CHAN,		0x8000 },
+	{ SGTL5000_DAP_MIX_CHAN,		0x0000 },
 	{ SGTL5000_DAP_AVC_CTRL,		0x0510 },
 	{ SGTL5000_DAP_AVC_THRESHOLD,		0x1473 },
 	{ SGTL5000_DAP_AVC_ATTACK,		0x0028 },
@@ -925,14 +940,11 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			udelay(10);
 
-			regcache_cache_only(sgtl5000->regmap, false);
-
 			ret = regcache_sync(sgtl5000->regmap);
 			if (ret != 0) {
 				dev_err(codec->dev,
 					"Failed to restore cache: %d\n", ret);
 
-				regcache_cache_only(sgtl5000->regmap, true);
 				regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						       sgtl5000->supplies);
 
@@ -1063,7 +1075,10 @@ static bool sgtl5000_readable(struct device *dev, unsigned int reg)
 #ifdef CONFIG_SUSPEND
 static int sgtl5000_suspend(struct snd_soc_codec *codec)
 {
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+
 	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_cache_only(sgtl5000->regmap, true);
 
 	return 0;
 }
@@ -1075,7 +1090,6 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec)
  */
 static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 {
-	u16 *cache = codec->reg_cache;
 	u16 reg;
 
 	/* restore regular registers */
@@ -1089,12 +1103,12 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 			reg == SGTL5000_CHIP_REF_CTRL)
 			continue;
 
-		snd_soc_write(codec, reg, cache[reg]);
+		snd_soc_write(codec, reg, snd_soc_read(codec, reg));
 	}
 
 	/* restore dap registers */
 	for (reg = SGTL5000_DAP_REG_OFFSET; reg < SGTL5000_MAX_REG_OFFSET; reg += 2)
-		snd_soc_write(codec, reg, cache[reg]);
+		snd_soc_write(codec, reg, snd_soc_read(codec, reg));
 
 	/*
 	 * restore these regs according to the power setting sequence in
@@ -1110,29 +1124,32 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 	 *    prefer to resotre it after SGTL5000_CHIP_ANA_POWER restored
 	 */
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-			cache[SGTL5000_CHIP_LINREG_CTRL]);
+			snd_soc_read(codec, SGTL5000_CHIP_LINREG_CTRL));
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-			cache[SGTL5000_CHIP_ANA_POWER]);
+			snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER));
 
 	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-			cache[SGTL5000_CHIP_CLK_CTRL]);
+			snd_soc_read(codec, SGTL5000_CHIP_CLK_CTRL));
 
 	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-			cache[SGTL5000_CHIP_REF_CTRL]);
+			snd_soc_read(codec, SGTL5000_CHIP_REF_CTRL));
 
 	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
+			snd_soc_read(codec, SGTL5000_CHIP_LINE_OUT_CTRL));
 	return 0;
 }
 
 static int sgtl5000_resume(struct snd_soc_codec *codec)
 {
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 	/* Bring the codec back up to standby to enable regulators */
 	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Restore registers by cached in memory */
 	sgtl5000_restore_regs(codec);
+
+	regcache_cache_only(sgtl5000->regmap, false);
 	return 0;
 }
 #else
-- 
1.8.3.2
