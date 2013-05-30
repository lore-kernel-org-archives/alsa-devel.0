From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: wm8994: Add digital loopback paths
Date: Thu, 30 May 2013 13:42:26 +0100
Message-ID: <1369917750-7322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BE5B2651A2
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:42:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There is loopback control within the audio interfaces, provide control of
this as there are some obscure scenarios where this could be used in
production.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 561c2f9..2081fa1 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1499,6 +1499,24 @@ static const char *aif1dac_text[] = {
 	"AIF1DACDAT", "AIF3DACDAT",
 };
 
+static const char *loopback_text[] = {
+	"None", "ADCDAT",
+};
+
+static const struct soc_enum aif1_loopback_enum =
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, WM8994_AIF1_LOOPBACK_SHIFT, 2,
+			loopback_text);
+
+static const struct snd_kcontrol_new aif1_loopback =
+	SOC_DAPM_ENUM("AIF1 Loopback", aif1_loopback_enum);
+
+static const struct soc_enum aif2_loopback_enum =
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, WM8994_AIF2_LOOPBACK_SHIFT, 2,
+			loopback_text);
+
+static const struct snd_kcontrol_new aif2_loopback =
+	SOC_DAPM_ENUM("AIF2 Loopback", aif2_loopback_enum);
+
 static const struct soc_enum aif1dac_enum =
 	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 0, 2, aif1dac_text);
 
@@ -1745,6 +1763,9 @@ SND_SOC_DAPM_ADC("DMIC1R", NULL, WM8994_POWER_MANAGEMENT_4, 2, 0),
 SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 
+SND_SOC_DAPM_MUX("AIF1 Loopback", SND_SOC_NOPM, 0, 0, &aif1_loopback),
+SND_SOC_DAPM_MUX("AIF2 Loopback", SND_SOC_NOPM, 0, 0, &aif2_loopback),
+
 SND_SOC_DAPM_POST("Debug log", post_ev),
 };
 
@@ -1876,9 +1897,9 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF1DAC2L", NULL, "AIF1DAC Mux" },
 	{ "AIF1DAC2R", NULL, "AIF1DAC Mux" },
 
-	{ "AIF1DAC Mux", "AIF1DACDAT", "AIF1DACDAT" },
+	{ "AIF1DAC Mux", "AIF1DACDAT", "AIF1 Loopback" },
 	{ "AIF1DAC Mux", "AIF3DACDAT", "AIF3DACDAT" },
-	{ "AIF2DAC Mux", "AIF2DACDAT", "AIF2DACDAT" },
+	{ "AIF2DAC Mux", "AIF2DACDAT", "AIF2 Loopback" },
 	{ "AIF2DAC Mux", "AIF3DACDAT", "AIF3DACDAT" },
 	{ "AIF2ADC Mux", "AIF2ADCDAT", "AIF2ADCL" },
 	{ "AIF2ADC Mux", "AIF2ADCDAT", "AIF2ADCR" },
@@ -1929,6 +1950,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF3ADCDAT", "AIF2DACDAT", "AIF2DACL" },
 	{ "AIF3ADCDAT", "AIF2DACDAT", "AIF2DACR" },
 
+	/* Loopback */
+	{ "AIF1 Loopback", "ADCDAT", "AIF1ADCDAT" },
+	{ "AIF1 Loopback", "None", "AIF1DACDAT" },
+	{ "AIF2 Loopback", "ADCDAT", "AIF2ADCDAT" },
+	{ "AIF2 Loopback", "None", "AIF2DACDAT" },
+
 	/* Sidetone */
 	{ "Left Sidetone", "ADC/DMIC1", "ADCL Mux" },
 	{ "Left Sidetone", "DMIC2", "DMIC2L" },
-- 
1.7.10.4
