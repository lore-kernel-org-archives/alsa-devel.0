From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8824: fix the issue of the widget
	with prefix name
Date: Mon, 11 Mar 2019 09:36:45 +0800
Message-ID: <20190311013645.31523-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 3C6F2F806F5
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2019 02:36:58 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The driver has two issues when machine add prefix name for codec.
(1)The stream name of DAI can't find the AIF widgets.
(2)The drivr can enable/disalbe the MICBIAS and SAR widgets.

The patch will fix these issues caused by prefixed name added.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8824.c | 46 +++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 87ed3dc496dc..5ab05e75edea 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -681,8 +681,8 @@ static const struct snd_soc_dapm_widget nau8824_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADCR", NULL, NAU8824_REG_ANALOG_ADC_2,
 		NAU8824_ADCR_EN_SFT, 0),
 
-	SND_SOC_DAPM_AIF_OUT("AIFTX", "HiFi Capture", 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("AIFRX", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIFRX", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_DAC("DACL", NULL, NAU8824_REG_RDAC,
 		NAU8824_DACL_EN_SFT, 0),
@@ -831,6 +831,36 @@ static void nau8824_int_status_clear_all(struct regmap *regmap)
 	}
 }
 
+static void nau8824_dapm_disable_pin(struct nau8824 *nau8824, const char *pin)
+{
+	struct snd_soc_dapm_context *dapm = nau8824->dapm;
+	const char *prefix = dapm->component->name_prefix;
+	char prefixed_pin[80];
+
+	if (prefix) {
+		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
+			 prefix, pin);
+		snd_soc_dapm_disable_pin(dapm, prefixed_pin);
+	} else {
+		snd_soc_dapm_disable_pin(dapm, pin);
+	}
+}
+
+static void nau8824_dapm_enable_pin(struct nau8824 *nau8824, const char *pin)
+{
+	struct snd_soc_dapm_context *dapm = nau8824->dapm;
+	const char *prefix = dapm->component->name_prefix;
+	char prefixed_pin[80];
+
+	if (prefix) {
+		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
+			 prefix, pin);
+		snd_soc_dapm_force_enable_pin(dapm, prefixed_pin);
+	} else {
+		snd_soc_dapm_force_enable_pin(dapm, pin);
+	}
+}
+
 static void nau8824_eject_jack(struct nau8824 *nau8824)
 {
 	struct snd_soc_dapm_context *dapm = nau8824->dapm;
@@ -839,8 +869,8 @@ static void nau8824_eject_jack(struct nau8824 *nau8824)
 	/* Clear all interruption status */
 	nau8824_int_status_clear_all(regmap);
 
-	snd_soc_dapm_disable_pin(dapm, "SAR");
-	snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+	nau8824_dapm_disable_pin(nau8824, "SAR");
+	nau8824_dapm_disable_pin(nau8824, "MICBIAS");
 	snd_soc_dapm_sync(dapm);
 
 	/* Enable the insertion interruption, disable the ejection
@@ -870,8 +900,8 @@ static void nau8824_jdet_work(struct work_struct *work)
 	struct regmap *regmap = nau8824->regmap;
 	int adc_value, event = 0, event_mask = 0;
 
-	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
-	snd_soc_dapm_force_enable_pin(dapm, "SAR");
+	nau8824_dapm_enable_pin(nau8824, "MICBIAS");
+	nau8824_dapm_enable_pin(nau8824, "SAR");
 	snd_soc_dapm_sync(dapm);
 
 	msleep(100);
@@ -882,8 +912,8 @@ static void nau8824_jdet_work(struct work_struct *work)
 	if (adc_value < HEADSET_SARADC_THD) {
 		event |= SND_JACK_HEADPHONE;
 
-		snd_soc_dapm_disable_pin(dapm, "SAR");
-		snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+		nau8824_dapm_disable_pin(nau8824, "SAR");
+		nau8824_dapm_disable_pin(nau8824, "MICBIAS");
 		snd_soc_dapm_sync(dapm);
 	} else {
 		event |= SND_JACK_HEADSET;
-- 
2.18.0
