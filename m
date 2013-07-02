From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Add GPIO output for DRC
Date: Tue,  2 Jul 2013 15:53:37 +0100
Message-ID: <1372776817-29811-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1372776817-29811-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 636CE265487
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 17:00:49 +0200 (CEST)
In-Reply-To: <1372776817-29811-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

In some use cases, such as signal activity detection, the only output
from the DRC will be a GPIO pin. This patch adds GPIO outputs to the
CODEC driver and hooks these up to the DRC when a GPIO is configured to
output the DRC activity detection.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5102.c  |    7 ++++++
 sound/soc/codecs/wm5110.c  |    7 ++++++
 4 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 389f232..5879ec5 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -223,6 +223,58 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(arizona_init_spk);
 
+static const char * const arizona_gpio_name[] = {
+	"GPIO1",
+	"GPIO2",
+	"GPIO3",
+	"GPIO4",
+	"GPIO5",
+};
+
+int arizona_init_gpio(struct snd_soc_codec *codec)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	struct snd_soc_dapm_route routes[2];
+	int i, ret;
+	bool add;
+
+	memset(&routes, 0, sizeof(routes));
+
+	for (i = 0; i < ARRAY_SIZE(arizona->pdata.gpio_defaults); i++) {
+		add = false;
+
+		switch (arizona->pdata.gpio_defaults[i] & ARIZONA_GPN_FN_MASK) {
+		case 0x1d: /* DRC1 Signal Detect */
+			routes[0].source = "DRC1L";
+			routes[1].source = "DRC1R";
+			add = true;
+			break;
+		case 0x22: /* DRC2 Signal Detect */
+			routes[0].source = "DRC2L";
+			routes[1].source = "DRC2R";
+			add = true;
+			break;
+		default:
+			break;
+		}
+
+		if (add) {
+			routes[0].sink = arizona_gpio_name[i];
+			routes[1].sink = arizona_gpio_name[i];
+
+			ret = snd_soc_dapm_add_routes(&codec->dapm,
+						      routes,
+						      ARRAY_SIZE(routes));
+			if (ret < 0)
+				return ret;
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
index 100fdad..2ff2a65 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -967,6 +967,12 @@ SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
 
+SND_SOC_DAPM_OUTPUT("GPIO1"),
+SND_SOC_DAPM_OUTPUT("GPIO2"),
+SND_SOC_DAPM_OUTPUT("GPIO3"),
+SND_SOC_DAPM_OUTPUT("GPIO4"),
+SND_SOC_DAPM_OUTPUT("GPIO5"),
+
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
 		   0, NULL, 0, arizona_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
@@ -1578,6 +1584,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	arizona_init_spk(codec);
+	arizona_init_gpio(codec);
 
 	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 88ad7db..4f8611f 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -414,6 +414,12 @@ SND_SOC_DAPM_INPUT("IN3R"),
 SND_SOC_DAPM_INPUT("IN4L"),
 SND_SOC_DAPM_INPUT("IN4R"),
 
+SND_SOC_DAPM_OUTPUT("GPIO1"),
+SND_SOC_DAPM_OUTPUT("GPIO2"),
+SND_SOC_DAPM_OUTPUT("GPIO3"),
+SND_SOC_DAPM_OUTPUT("GPIO4"),
+SND_SOC_DAPM_OUTPUT("GPIO5"),
+
 SND_SOC_DAPM_PGA_E("IN1L PGA", ARIZONA_INPUT_ENABLES, ARIZONA_IN1L_ENA_SHIFT,
 		   0, NULL, 0, arizona_in_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD |
@@ -978,6 +984,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	arizona_init_spk(codec);
+	arizona_init_gpio(codec);
 
 	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
 
-- 
1.7.2.5
