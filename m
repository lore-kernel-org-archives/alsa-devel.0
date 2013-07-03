From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/2] ASoC: arizona: Add signal activity
	output for DRC
Date: Wed,  3 Jul 2013 13:38:46 +0100
Message-ID: <1372855126-13122-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1372855126-13122-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DE80265570
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 14:46:03 +0200 (CEST)
In-Reply-To: <1372855126-13122-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, sameo@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When doing signal activity detection, the only output from the DRC will
often be a GPIO pin. This patch adds a signal activity output that is
activated when a GPIO is configured to output the DRC signal activity
detection.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   35 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5102.c  |    6 ++++++
 sound/soc/codecs/wm5110.c  |    9 +++++++++
 4 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 389f232..cf2a413 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -19,6 +19,7 @@
 #include <sound/tlv.h>
 
 #include <linux/mfd/arizona/core.h>
+#include <linux/mfd/arizona/gpio.h>
 #include <linux/mfd/arizona/registers.h>
 
 #include "arizona.h"
@@ -223,6 +224,40 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(arizona_init_spk);
 
+int arizona_init_gpio(struct snd_soc_codec *codec)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	int i;
+
+	switch (arizona->type) {
+	case WM5110:
+		snd_soc_dapm_disable_pin(&codec->dapm, "DRC2 Signal Activity");
+		/* Intentional fall through */
+	default:
+		snd_soc_dapm_disable_pin(&codec->dapm, "DRC1 Signal Activity");
+		break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(arizona->pdata.gpio_defaults); i++) {
+		switch (arizona->pdata.gpio_defaults[i] & ARIZONA_GPN_FN_MASK) {
+		case ARIZONA_GP_FN_DRC1_SIGNAL_DETECT:
+			snd_soc_dapm_enable_pin(&codec->dapm,
+						"DRC1 Signal Activity");
+			break;
+		case ARIZONA_GP_FN_DRC2_SIGNAL_DETECT:
+			snd_soc_dapm_enable_pin(&codec->dapm,
+						"DRC2 Signal Activity");
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_gpio);
+
 const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 	"None",
 	"Tone Generator 1",
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index af39f10..fe8bd3d 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -241,6 +241,7 @@ extern int arizona_set_fll(struct arizona_fll *fll, int source,
 			   unsigned int Fref, unsigned int Fout);
 
 extern int arizona_init_spk(struct snd_soc_codec *codec);
+extern int arizona_init_gpio(struct snd_soc_codec *codec);
 
 extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 100fdad..20e11f1 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -967,6 +967,8 @@ SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
 
+SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
+
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
 		   0, NULL, 0, arizona_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
@@ -1468,6 +1470,9 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "SPKDAT1R", NULL, "OUT5R" },
 
 	{ "MICSUPP", NULL, "SYSCLK" },
+
+	{ "DRC1 Signal Activity", NULL, "DRC1L" },
+	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
 
 static int wm5102_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
@@ -1578,6 +1583,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	arizona_init_spk(codec);
+	arizona_init_gpio(codec);
 
 	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 88ad7db..f36f9bd 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -414,6 +414,9 @@ SND_SOC_DAPM_INPUT("IN3R"),
 SND_SOC_DAPM_INPUT("IN4L"),
 SND_SOC_DAPM_INPUT("IN4R"),
 
+SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
+SND_SOC_DAPM_OUTPUT("DRC2 Signal Activity"),
+
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
 		   0, NULL, 0, arizona_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
@@ -871,6 +874,11 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "SPKDAT2R", NULL, "OUT6R" },
 
 	{ "MICSUPP", NULL, "SYSCLK" },
+
+	{ "DRC1 Signal Activity", NULL, "DRC1L" },
+	{ "DRC1 Signal Activity", NULL, "DRC1R" },
+	{ "DRC2 Signal Activity", NULL, "DRC2L" },
+	{ "DRC2 Signal Activity", NULL, "DRC2R" },
 };
 
 static int wm5110_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
@@ -978,6 +986,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	arizona_init_spk(codec);
+	arizona_init_gpio(codec);
 
 	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
 
-- 
1.7.2.5
