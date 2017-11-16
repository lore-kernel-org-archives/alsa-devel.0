From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8540: fix the record pop noise" to
	the asoc tree
Date: Thu, 16 Nov 2017 19:29:25 +0000 (GMT)
Message-ID: <20171116192925.A6A5944005B@finisterre.ee.mobilebroadband>
References: <1510039399-12807-3-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4D9267782
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:29:26 +0100 (CET)
In-Reply-To: <1510039399-12807-3-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8540: fix the record pop noise

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

>From 6573c0510be611fb886d005b7b2321658dc5df87 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 7 Nov 2017 15:23:19 +0800
Subject: [PATCH] ASoC: nau8540: fix the record pop noise

When the record starts, the driver turns on MICBIAS and the voltage is
pulled up for an instant. If the receiver starts to capture the signal
between the instant, there is an pop noise in the stream beginning.
To avoid the pop noise, the driver makes a delay in the sequence.
After MICBIAS powered up, the driver waits 300 ms for the voltage
going down. Then turns on the ADC output, and sends signal to receiver.
The pop noise can be erased.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8540.c | 47 ++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/nau8540.h |  2 ++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 8246486a588d..9565f9a181a9 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -233,6 +233,28 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new digital_ch1_mux =
 	SOC_DAPM_ENUM("Digital CH1 Select", digital_ch1_enum);
 
+static int adc_power_control(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		msleep(300);
+		/* DO12 and DO34 pad output enable */
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
+			NAU8540_I2S_DO12_TRI, 0);
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
+			NAU8540_I2S_DO34_TRI, 0);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
+			NAU8540_I2S_DO12_TRI, NAU8540_I2S_DO12_TRI);
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
+			NAU8540_I2S_DO34_TRI, NAU8540_I2S_DO34_TRI);
+	}
+	return 0;
+}
+
 static int aiftx_power_control(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *k, int  event)
 {
@@ -260,14 +282,18 @@ static const struct snd_soc_dapm_widget nau8540_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("Frontend PGA3", NAU8540_REG_PWR, 14, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Frontend PGA4", NAU8540_REG_PWR, 15, 0, NULL, 0),
 
-	SND_SOC_DAPM_ADC("ADC1", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 0, 0),
-	SND_SOC_DAPM_ADC("ADC2", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 1, 0),
-	SND_SOC_DAPM_ADC("ADC3", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 2, 0),
-	SND_SOC_DAPM_ADC("ADC4", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 3, 0),
+	SND_SOC_DAPM_ADC_E("ADC1", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 0, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 1, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("ADC3", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 2, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("ADC4", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 3, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 	SND_SOC_DAPM_PGA("ADC CH1", NAU8540_REG_ANALOG_PWR, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("ADC CH2", NAU8540_REG_ANALOG_PWR, 1, 0, NULL, 0),
@@ -737,6 +763,11 @@ static void nau8540_init_regs(struct nau8540 *nau8540)
 	regmap_update_bits(regmap, NAU8540_REG_FEPGA2,
 		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT,
 		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT);
+	/* DO12 and DO34 pad output disable */
+	regmap_update_bits(regmap, NAU8540_REG_PCM_CTRL1,
+		NAU8540_I2S_DO12_TRI, NAU8540_I2S_DO12_TRI);
+	regmap_update_bits(regmap, NAU8540_REG_PCM_CTRL2,
+		NAU8540_I2S_DO34_TRI, NAU8540_I2S_DO34_TRI);
 }
 
 static int __maybe_unused nau8540_suspend(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index 7083d4821ce4..dceb04b23c19 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -146,6 +146,7 @@
 #define NAU8540_I2S_DF_PCM_AB		0x3
 
 /* PCM_CTRL1 (0x11) */
+#define NAU8540_I2S_DO12_TRI		(0x1 << 15)
 #define NAU8540_I2S_LRC_DIV_SFT	12
 #define NAU8540_I2S_LRC_DIV_MASK	(0x3 << NAU8540_I2S_LRC_DIV_SFT)
 #define NAU8540_I2S_DO12_OE		(0x1 << 4)
@@ -156,6 +157,7 @@
 #define NAU8540_I2S_BLK_DIV_MASK	0x7
 
 /* PCM_CTRL1 (0x12) */
+#define NAU8540_I2S_DO34_TRI		(0x1 << 15)
 #define NAU8540_I2S_DO34_OE		(0x1 << 11)
 #define NAU8540_I2S_TSLOT_L_MASK	0x3ff
 
-- 
2.14.1
