From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add WM8737 ALC support
Date: Wed, 24 Nov 2010 17:46:47 +0000
Message-ID: <1290620807-6011-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDFC724440
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 18:46:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8737.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index a325fe6..2301338 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -78,6 +78,8 @@ static const unsigned int micboost_tlv[] = {
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -9750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(ng_tlv, -7800, 600, 0);
+static const DECLARE_TLV_DB_SCALE(alc_max_tlv, -1200, 600, 0);
+static const DECLARE_TLV_DB_SCALE(alc_target_tlv, -1800, 100, 0);
 
 static const char *micbias_enum_text[] = {
 	"25%",
@@ -103,6 +105,38 @@ static const char *high_cutoff_text[] = {
 static const struct soc_enum high_3d =
 	SOC_ENUM_SINGLE(WM8737_3D_ENHANCE, 5, 2, high_cutoff_text);
 
+static const char *alc_fn_text[] = {
+	"Disabled", "Right", "Left", "Stereo"
+};
+
+static const struct soc_enum alc_fn =
+	SOC_ENUM_SINGLE(WM8737_ALC1, 7, 4, alc_fn_text);
+
+static const char *alc_hold_text[] = {
+	"0", "2.67ms", "5.33ms", "10.66ms", "21.32ms", "42.64ms", "85.28ms",
+	"170.56ms", "341.12ms", "682.24ms", "1.364s", "2.728s", "5.458s",
+	"10.916s", "21.832s", "43.691s"
+};
+
+static const struct soc_enum alc_hold =
+	SOC_ENUM_SINGLE(WM8737_ALC2, 0, 16, alc_hold_text);
+
+static const char *alc_atk_text[] = {
+	"8.4ms", "16.8ms", "33.6ms", "67.2ms", "134.4ms", "268.8ms", "537.6ms",
+	"1.075s", "2.15s", "4.3s", "8.6s"
+};
+
+static const struct soc_enum alc_atk =
+	SOC_ENUM_SINGLE(WM8737_ALC3, 0, 11, alc_atk_text);
+
+static const char *alc_dcy_text[] = {
+	"33.6ms", "67.2ms", "134.4ms", "268.8ms", "537.6ms", "1.075s", "2.15s",
+	"4.3s", "8.6s", "17.2s", "34.41s"
+};
+
+static const struct soc_enum alc_dcy =
+	SOC_ENUM_SINGLE(WM8737_ALC3, 4, 11, alc_dcy_text);
+
 static const struct snd_kcontrol_new wm8737_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Mic Boost Volume", WM8737_AUDIO_PATH_L, WM8737_AUDIO_PATH_R,
 		 6, 3, 0, micboost_tlv),
@@ -132,6 +166,14 @@ SOC_SINGLE_TLV("3D ADC Volume", WM8737_3D_ENHANCE, 7, 1, 1, adc_tlv),
 SOC_SINGLE("Noise Gate Switch", WM8737_NOISE_GATE, 0, 1, 0),
 SOC_SINGLE_TLV("Noise Gate Threshold Volume", WM8737_NOISE_GATE, 2, 7, 0,
 	       ng_tlv),
+
+SOC_ENUM("ALC", alc_fn),
+SOC_SINGLE_TLV("ALC Max Gain Volume", WM8737_ALC1, 4, 7, 0, alc_max_tlv),
+SOC_SINGLE_TLV("ALC Target Volume", WM8737_ALC1, 0, 15, 0, alc_target_tlv),
+SOC_ENUM("ALC Hold Time", alc_hold),
+SOC_SINGLE("ALC ZC Switch", WM8737_ALC2, 4, 1, 0),
+SOC_ENUM("ALC Attack Time", alc_atk),
+SOC_ENUM("ALC Decay Time", alc_dcy),
 };
 
 static const char *linsel_text[] = {
-- 
1.7.1
