From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 1/1] sgtl5000: Fix suspend/resume
Date: Mon, 04 Apr 2011 17:13:00 +0200
Message-ID: <20110404151315.251129690@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 46DC51037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 17:15:12 +0200 (CEST)
Content-Disposition: inline; filename=sgtl5000_suspend.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

sgtl5000 codec driver is assuming a wrong cache layout, leading to a broken
suspend/resume support. This patch declares properly the default cache buffer
and fix the function used to restore the regs from the cache. I've also moved
it were it belongs, in the set_bias_level function.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: imx-test/sound/soc/codecs/sgtl5000.c
===================================================================
--- imx-test.orig/sound/soc/codecs/sgtl5000.c
+++ imx-test/sound/soc/codecs/sgtl5000.c
@@ -34,37 +34,67 @@
 #define SGTL5000_MAX_REG_OFFSET	0x013A
 
 /* default value of sgtl5000 registers except DAP */
-static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
+static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET] =  {
 	0xa011, /* 0x0000, CHIP_ID. 11 stand for revison 17 */
+	0,
 	0x0000, /* 0x0002, CHIP_DIG_POWER. */
+	0,
 	0x0008, /* 0x0004, CHIP_CKL_CTRL */
+	0,
 	0x0010, /* 0x0006, CHIP_I2S_CTRL */
+	0,
 	0x0000, /* 0x0008, reserved */
+	0,
 	0x0008, /* 0x000A, CHIP_SSS_CTRL */
+	0,
 	0x0000, /* 0x000C, reserved */
+	0,
 	0x020c, /* 0x000E, CHIP_ADCDAC_CTRL */
+	0,
 	0x3c3c, /* 0x0010, CHIP_DAC_VOL */
+	0,
 	0x0000, /* 0x0012, reserved */
+	0,
 	0x015f, /* 0x0014, CHIP_PAD_STRENGTH */
+	0,
 	0x0000, /* 0x0016, reserved */
+	0,
 	0x0000, /* 0x0018, reserved */
+	0,
 	0x0000, /* 0x001A, reserved */
+	0,
 	0x0000, /* 0x001E, reserved */
+	0,
 	0x0000, /* 0x0020, CHIP_ANA_ADC_CTRL */
+	0,
 	0x1818, /* 0x0022, CHIP_ANA_HP_CTRL */
+	0,
 	0x0111, /* 0x0024, CHIP_ANN_CTRL */
+	0,
 	0x0000, /* 0x0026, CHIP_LINREG_CTRL */
+	0,
 	0x0000, /* 0x0028, CHIP_REF_CTRL */
+	0,
 	0x0000, /* 0x002A, CHIP_MIC_CTRL */
+	0,
 	0x0000, /* 0x002C, CHIP_LINE_OUT_CTRL */
+	0,
 	0x0404, /* 0x002E, CHIP_LINE_OUT_VOL */
+	0,
 	0x7060, /* 0x0030, CHIP_ANA_POWER */
+	0,
 	0x5000, /* 0x0032, CHIP_PLL_CTRL */
+	0,
 	0x0000, /* 0x0034, CHIP_CLK_TOP_CTRL */
+	0,
 	0x0000, /* 0x0036, CHIP_ANA_STATUS */
+	0,
 	0x0000, /* 0x0038, reserved */
+	0,
 	0x0000, /* 0x003A, CHIP_ANA_TEST2 */
+	0,
 	0x0000, /* 0x003C, CHIP_SHORT_CTRL */
+	0,
 	0x0000, /* reserved */
 };
 
@@ -903,6 +933,63 @@ static int ldo_regulator_remove(struct s
 }
 
 /*
+ * restore all sgtl5000 registers,
+ * since a big hole between dap and regular registers,
+ * we will restore them respectively.
+ */
+static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
+{
+	u16 *cache = codec->reg_cache;
+	int i, step = codec->driver->reg_cache_step;
+	int regular_regs = SGTL5000_CHIP_SHORT_CTRL;
+
+	if (!codec->cache_sync)
+		return 0;
+
+	codec->cache_only = 0;
+	/*
+	 * restore power and other regs according
+	 * to set_power() and set_clock()
+	 */
+	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
+			cache[SGTL5000_CHIP_LINREG_CTRL]);
+
+	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
+			cache[SGTL5000_CHIP_ANA_POWER]);
+
+	msleep(10);
+	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
+			cache[SGTL5000_CHIP_CLK_CTRL]);
+
+	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
+			cache[SGTL5000_CHIP_REF_CTRL]);
+
+	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
+			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
+
+	/* restore regular registers */
+	for (i = 0; i < regular_regs; i += step) {
+		/* this regs depends on the others */
+		if (i == SGTL5000_CHIP_ANA_POWER ||
+			i == SGTL5000_CHIP_CLK_CTRL ||
+			i == SGTL5000_CHIP_LINREG_CTRL ||
+			i == SGTL5000_CHIP_LINE_OUT_CTRL ||
+			i == SGTL5000_CHIP_CLK_CTRL)
+			continue;
+
+		snd_soc_write(codec, i, cache[i]);
+	}
+
+	/* restore dap registers */
+	for (i = SGTL5000_DAP_REG_OFFSET;
+			i < SGTL5000_MAX_REG_OFFSET; i += step)
+		snd_soc_write(codec, i, cache[i]);
+
+	codec->cache_sync = 0;
+	return 0;
+}
+
+/*
  * set dac bias
  * common state changes:
  * startup:
@@ -927,15 +1014,22 @@ static int sgtl5000_set_bias_level(struc
 			ret = regulator_bulk_enable(
 						ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
-			if (ret)
+			if (ret) {
+				dev_err(codec->dev,
+					"Unable en enable regulators: %d\n",
+					ret);
 				return ret;
+			}
 			udelay(10);
+			/* Restore registers by cached in memory */
+			sgtl5000_restore_regs(codec);
 		}
 
 		break;
 	case SND_SOC_BIAS_OFF:
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
+		codec->cache_sync = 1;
 		break;
 	}
 
@@ -995,74 +1089,13 @@ static int sgtl5000_volatile_register(st
 #ifdef CONFIG_SUSPEND
 static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-/*
- * restore all sgtl5000 registers,
- * since a big hole between dap and regular registers,
- * we will restore them respectively.
- */
-static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
-{
-	u16 *cache = codec->reg_cache;
-	int i;
-	int regular_regs = SGTL5000_CHIP_SHORT_CTRL >> 1;
-
-	/* restore regular registers */
-	for (i = 0; i < regular_regs; i++) {
-		int reg = i << 1;
-
-		/* this regs depends on the others */
-		if (reg == SGTL5000_CHIP_ANA_POWER ||
-			reg == SGTL5000_CHIP_CLK_CTRL ||
-			reg == SGTL5000_CHIP_LINREG_CTRL ||
-			reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
-			reg == SGTL5000_CHIP_CLK_CTRL)
-			continue;
-
-		snd_soc_write(codec, reg, cache[i]);
-	}
-
-	/* restore dap registers */
-	for (i = SGTL5000_DAP_REG_OFFSET >> 1;
-			i < SGTL5000_MAX_REG_OFFSET >> 1; i++) {
-		int reg = i << 1;
-
-		snd_soc_write(codec, reg, cache[i]);
-	}
-
-	/*
-	 * restore power and other regs according
-	 * to set_power() and set_clock()
-	 */
-	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-			cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-			cache[SGTL5000_CHIP_ANA_POWER >> 1]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-			cache[SGTL5000_CHIP_CLK_CTRL >> 1]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-			cache[SGTL5000_CHIP_REF_CTRL >> 1]);
-
-	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			cache[SGTL5000_CHIP_LINE_OUT_CTRL >> 1]);
-	return 0;
+	return sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
 
 static int sgtl5000_resume(struct snd_soc_codec *codec)
 {
 	/* Bring the codec back up to standby to enable regulators */
-	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* Restore registers by cached in memory */
-	sgtl5000_restore_regs(codec);
-	return 0;
+	return sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 }
 #else
 #define sgtl5000_suspend NULL
