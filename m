From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Modify the headphone depop and
	calibration function to prevent the pop sound in the booting
	time" to the asoc tree
Date: Tue, 25 Aug 2015 19:13:11 +0100
Message-ID: <E1ZUIid-0006Ct-O6@debutante>
References: <1440419579-9970-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD7C226525B
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 20:13:26 +0200 (CEST)
In-Reply-To: <1440419579-9970-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Modify the headphone depop and calibration function to prevent the pop sound in the booting time

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 588cd850f5089cb63e031e8d70e9c081b0d97ab2 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 24 Aug 2015 20:32:56 +0800
Subject: [PATCH] ASoC: rt5645: Modify the headphone depop and calibration
 function to prevent the pop sound in the booting time

Remove the original calibration function and modify the depop and
calibration function to prevent the pop sound in the booting time.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 111 +++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 79 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2ee42781cc52..ac2f42f4e3a0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -254,6 +254,7 @@ struct rt5645_priv {
 
 	int jack_type;
 	bool en_button_func;
+	bool hp_on;
 };
 
 static int rt5645_reset(struct snd_soc_codec *codec)
@@ -1364,15 +1365,23 @@ static void hp_amp_power(struct snd_soc_codec *codec, int on)
 	if (on) {
 		if (hp_amp_power_count <= 0) {
 			if (rt5645->codec_type == CODEC_TYPE_RT5650) {
+				snd_soc_write(codec, RT5645_DEPOP_M2, 0x3100);
 				snd_soc_write(codec, RT5645_CHARGE_PUMP,
 					0x0e06);
-				snd_soc_write(codec, RT5645_DEPOP_M1, 0x001d);
+				snd_soc_write(codec, RT5645_DEPOP_M1, 0x000d);
+				regmap_write(rt5645->regmap, RT5645_PR_BASE +
+					RT5645_HP_DCC_INT1, 0x9f01);
+				msleep(20);
+				snd_soc_update_bits(codec, RT5645_DEPOP_M1,
+					RT5645_HP_CO_MASK, RT5645_HP_CO_EN);
 				regmap_write(rt5645->regmap, RT5645_PR_BASE +
 					0x3e, 0x7400);
 				snd_soc_write(codec, RT5645_DEPOP_M3, 0x0737);
 				regmap_write(rt5645->regmap, RT5645_PR_BASE +
 					RT5645_MAMP_INT_REG2, 0xfc00);
 				snd_soc_write(codec, RT5645_DEPOP_M2, 0x1140);
+				mdelay(5);
+				rt5645->hp_on = true;
 			} else {
 				/* depop parameters */
 				snd_soc_update_bits(codec, RT5645_DEPOP_M2,
@@ -1586,6 +1595,27 @@ static int rt5645_bst2_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5650_hp_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (rt5645->hp_on) {
+			msleep(100);
+			rt5645->hp_on = false;
+		}
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5645_PWR_MIXER,
 		RT5645_PWR_LDO2_BIT, 0, NULL, 0),
@@ -1870,6 +1900,7 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("PDM1R"),
 	SND_SOC_DAPM_OUTPUT("SPOL"),
 	SND_SOC_DAPM_OUTPUT("SPOR"),
+	SND_SOC_DAPM_POST("DAPM_POST", rt5650_hp_event),
 };
 
 static const struct snd_soc_dapm_widget rt5645_specific_dapm_widgets[] = {
@@ -2721,77 +2752,6 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int rt5650_calibration(struct rt5645_priv *rt5645)
-{
-	int val, i;
-	int ret = -1;
-
-	regcache_cache_bypass(rt5645->regmap, true);
-	regmap_write(rt5645->regmap, RT5645_RESET, 0);
-	regmap_write(rt5645->regmap, RT5645_GEN_CTRL3, 0x0800);
-	regmap_write(rt5645->regmap, RT5645_PR_BASE + RT5645_CHOP_DAC_ADC,
-		0x3600);
-	regmap_write(rt5645->regmap, RT5645_PR_BASE + 0x25, 0x7000);
-	regmap_write(rt5645->regmap, RT5645_I2S1_SDP, 0x8008);
-	/* headset type */
-	regmap_write(rt5645->regmap, RT5645_GEN_CTRL1, 0x2061);
-	regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0006);
-	regmap_write(rt5645->regmap, RT5645_PWR_ANLG1, 0x2012);
-	regmap_write(rt5645->regmap, RT5645_PWR_MIXER, 0x0002);
-	regmap_write(rt5645->regmap, RT5645_PWR_VOL, 0x0020);
-	regmap_write(rt5645->regmap, RT5645_JD_CTRL3, 0x00f0);
-	regmap_write(rt5645->regmap, RT5645_IN1_CTRL1, 0x0006);
-	regmap_write(rt5645->regmap, RT5645_IN1_CTRL2, 0x1827);
-	regmap_write(rt5645->regmap, RT5645_IN1_CTRL2, 0x0827);
-	msleep(400);
-	/* Inline command */
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M1, 0x0001);
-	regmap_write(rt5645->regmap, RT5650_4BTN_IL_CMD2, 0xc000);
-	regmap_write(rt5645->regmap, RT5650_4BTN_IL_CMD1, 0x0008);
-	/* Calbration */
-	regmap_write(rt5645->regmap, RT5645_GLB_CLK, 0x8000);
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M1, 0x0000);
-	regmap_write(rt5645->regmap, RT5650_4BTN_IL_CMD2, 0xc000);
-	regmap_write(rt5645->regmap, RT5650_4BTN_IL_CMD1, 0x0008);
-	regmap_write(rt5645->regmap, RT5645_PWR_DIG2, 0x8800);
-	regmap_write(rt5645->regmap, RT5645_PWR_ANLG1, 0xe8fa);
-	regmap_write(rt5645->regmap, RT5645_PWR_ANLG2, 0x8c04);
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M2, 0x3100);
-	regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0e06);
-	regmap_write(rt5645->regmap, RT5645_BASS_BACK, 0x8a13);
-	regmap_write(rt5645->regmap, RT5645_GEN_CTRL3, 0x0820);
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M1, 0x000d);
-	/* Power on and Calbration */
-	regmap_write(rt5645->regmap, RT5645_PR_BASE + RT5645_HP_DCC_INT1,
-		0x9f01);
-	msleep(200);
-	for (i = 0; i < 5; i++) {
-		regmap_read(rt5645->regmap, RT5645_PR_BASE + 0x7a, &val);
-		if (val != 0 && val != 0x3f3f) {
-			ret = 0;
-			break;
-		}
-		msleep(50);
-	}
-	pr_debug("%s: PR-7A = 0x%x\n", __func__, val);
-
-	/* mute */
-	regmap_write(rt5645->regmap, RT5645_PR_BASE + 0x3e, 0x7400);
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M3, 0x0737);
-	regmap_write(rt5645->regmap, RT5645_PR_BASE + RT5645_MAMP_INT_REG2,
-		0xfc00);
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M2, 0x1140);
-	regmap_write(rt5645->regmap, RT5645_DEPOP_M1, 0x0000);
-	regmap_write(rt5645->regmap, RT5645_GEN_CTRL2, 0x4020);
-	regmap_write(rt5645->regmap, RT5645_PWR_ANLG2, 0x0006);
-	regmap_write(rt5645->regmap, RT5645_PWR_DIG2, 0x0000);
-	msleep(350);
-
-	regcache_cache_bypass(rt5645->regmap, false);
-
-	return ret;
-}
-
 static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	bool enable)
 {
@@ -3319,13 +3279,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
-	if (rt5645->codec_type == CODEC_TYPE_RT5650) {
-		ret = rt5650_calibration(rt5645);
-
-		if (ret < 0)
-			pr_err("calibration failed!\n");
-	}
-
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
 
 	ret = regmap_register_patch(rt5645->regmap, init_list,
-- 
2.5.0
