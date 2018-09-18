From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Improve HP performance" to the
	asoc tree
Date: Tue, 18 Sep 2018 18:45:34 +0100 (BST)
Message-ID: <20180918174534.B3F30440078@finisterre.ee.mobilebroadband>
References: <1537271468-5589-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B19DE267896
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:45:37 +0200 (CEST)
In-Reply-To: <1537271468-5589-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Improve HP performance

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From bf0fa00fd8410b377a3403adb58e32fc703e86e8 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 18 Sep 2018 19:51:08 +0800
Subject: [PATCH] ASoC: rt5682: Improve HP performance

We change the settings while HP power-up for better performance.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 32 +++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5682.h | 14 ++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 731c6a849f69..83202e9e5abd 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1437,6 +1437,28 @@ static const struct snd_kcontrol_new hpor_switch =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5682_HP_CTRL_1,
 					RT5682_R_MUTE_SFT, 1, 1);
 
+static int rt5682_charge_pump_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component,
+			RT5682_HP_CHARGE_PUMP_1, RT5682_PM_HP_MASK, RT5682_PM_HP_HV);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_update_bits(component,
+			RT5682_HP_CHARGE_PUMP_1, RT5682_PM_HP_MASK, RT5682_PM_HP_LV);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -1449,8 +1471,6 @@ static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 			RT5682_HP_LOGIC_CTRL_2, 0x0012);
 		snd_soc_component_write(component,
 			RT5682_HP_CTRL_2, 0x6000);
-		snd_soc_component_update_bits(component, RT5682_STO_NG2_CTRL_1,
-			RT5682_NG2_EN_MASK, RT5682_NG2_EN);
 		snd_soc_component_update_bits(component,
 			RT5682_DEPOP_1, 0x60, 0x60);
 		break;
@@ -1723,7 +1743,8 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("HP Amp R", RT5682_PWR_ANLG_1,
 		RT5682_PWR_HA_R_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("Charge Pump", 1, RT5682_DEPOP_1,
-		RT5682_PUMP_EN_SFT, 0, NULL, 0),
+		RT5682_PUMP_EN_SFT, 0, rt5682_charge_pump_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY_S("Capless", 2, RT5682_DEPOP_1,
 		RT5682_CAPLESS_EN_SFT, 0, NULL, 0),
 
@@ -1884,6 +1905,7 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"HP Amp", NULL, "Charge Pump"},
 	{"HP Amp", NULL, "CLKDET SYS"},
 	{"HP Amp", NULL, "CBJ Power"},
+	{"HP Amp", NULL, "Vref1"},
 	{"HP Amp", NULL, "Vref2"},
 	{"HPOL Playback", "Switch", "HP Amp"},
 	{"HPOR Playback", "Switch", "HP Amp"},
@@ -2607,6 +2629,10 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 			RT5682_GP4_PIN_MASK | RT5682_GP5_PIN_MASK,
 			RT5682_GP4_PIN_ADCDAT1 | RT5682_GP5_PIN_DACDAT1);
 	regmap_write(rt5682->regmap, RT5682_TEST_MODE_CTRL_1, 0x0000);
+	regmap_update_bits(rt5682->regmap, RT5682_BIAS_CUR_CTRL_8,
+			RT5682_HPA_CP_BIAS_CTRL_MASK, RT5682_HPA_CP_BIAS_3UA);
+	regmap_update_bits(rt5682->regmap, RT5682_CHARGE_PUMP_1,
+			RT5682_CP_CLK_HP_MASK, RT5682_CP_CLK_HP_300KHZ);
 
 	INIT_DELAYED_WORK(&rt5682->jack_detect_work,
 				rt5682_jack_detect_handler);
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 8068140ebe3f..d82a8301fd74 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1214,6 +1214,20 @@
 #define RT5682_JDH_NO_PLUG			(0x1 << 4)
 #define RT5682_JDH_PLUG				(0x0 << 4)
 
+/* Bias current control 8 (0x0111) */
+#define RT5682_HPA_CP_BIAS_CTRL_MASK			(0x3 << 2)
+#define RT5682_HPA_CP_BIAS_2UA			(0x0 << 2)
+#define RT5682_HPA_CP_BIAS_3UA			(0x1 << 2)
+#define RT5682_HPA_CP_BIAS_4UA			(0x2 << 2)
+#define RT5682_HPA_CP_BIAS_6UA			(0x3 << 2)
+
+/* Charge Pump Internal Register1 (0x0125) */
+#define RT5682_CP_CLK_HP_MASK			(0x3 << 4)
+#define RT5682_CP_CLK_HP_100KHZ			(0x0 << 4)
+#define RT5682_CP_CLK_HP_200KHZ			(0x1 << 4)
+#define RT5682_CP_CLK_HP_300KHZ			(0x2 << 4)
+#define RT5682_CP_CLK_HP_600KHZ			(0x3 << 4)
+
 /* Chopper and Clock control for DAC (0x013a)*/
 #define RT5682_CKXEN_DAC1_MASK			(0x1 << 13)
 #define RT5682_CKXEN_DAC1_SFT			13
-- 
2.19.0
