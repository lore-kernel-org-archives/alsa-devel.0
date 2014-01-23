From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH Resend 7/8] ASoC: add snd_soc_of_parse_audio_simple_widgets for DeviceTree
Date: Thu, 23 Jan 2014 13:02:49 +0800
Message-ID: <1390453370-29194-8-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch adds snd_soc_of_parse_audio_simple_widgets() and supports
below style of widgets name on DT.

"wname-prefix[ individual name]"
"wname-prefix" includes: "Mic", "Line", "Hp", "Spk"...

For instance:
	simple-audio-widgets =
		"Mic Jack", "Line In Jack",
		"Hp Jack", "Spk Ext",
		"Line Out Jack";

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

Add :
                  widgets[i].name = wname;

And this will use the widget name from DT node.




 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a00147..465dc6e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1173,6 +1173,8 @@ void snd_soc_util_exit(void);
 
 int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+					  const char *propname);
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 393ff06..9c8a686 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4417,6 +4417,69 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_card_name);
 
+static struct snd_soc_dapm_widget simple_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_LINE("Line", NULL),
+	SND_SOC_DAPM_HP("Hp", NULL),
+	SND_SOC_DAPM_SPK("Spk", NULL),
+};
+
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+					  const char *propname)
+{
+	struct device_node *np = card->dev->of_node;
+	struct snd_soc_dapm_widget *widgets;
+	const char *wname;
+	int i, j, cnt, ret;
+
+	cnt = of_property_count_strings(np, propname);
+	if (cnt <= 0) {
+		dev_err(card->dev,
+			"ASoC: Property '%s' does not exist or "
+			"length is zero\n", propname);
+		return -EINVAL;
+	}
+
+	widgets = devm_kcalloc(card->dev, cnt, sizeof(*widgets), GFP_KERNEL);
+	if (!widgets) {
+		dev_err(card->dev,
+			"ASoC: Could not allocate DAPM widgets table\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_string_index(np, propname, i, &wname);
+		if (ret) {
+			dev_err(card->dev,
+				"ASoC: Property '%s' index %d could not be "
+				"read: %d\n", propname, i, ret);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < ARRAY_SIZE(simple_widgets); j++) {
+			if (!strncmp(wname, simple_widgets[j].name,
+				     strlen(simple_widgets[j].name))) {
+				widgets[i] = simple_widgets[j];
+				widgets[i].name = wname;
+				break;
+			}
+		}
+
+		if (j >= ARRAY_SIZE(simple_widgets)) {
+			dev_err(card->dev,
+				"ASoC: DAPM widget : '%s' is not supported\n",
+				wname);
+			return -EINVAL;
+		}
+	}
+
+	card->dapm_widgets = widgets;
+	card->num_dapm_widgets = cnt;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
+
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname)
 {
-- 
1.8.4
