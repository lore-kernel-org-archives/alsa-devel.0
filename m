From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v3 1/4] ASoC: add
	snd_soc_of_parse_audio_simple_widgets for DT
Date: Sat, 8 Feb 2014 15:59:52 +0800
Message-ID: <1391846395-10193-2-git-send-email-Li.Xiubo@freescale.com>
References: <1391846395-10193-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 by alsa0.perex.cz (Postfix) with ESMTP id E5C11260840
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2014 10:02:46 +0100 (CET)
In-Reply-To: <1391846395-10193-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds snd_soc_of_parse_audio_simple_widgets() and supports
below style of widgets name on DT:

	"template-wname", "user supplied wname"

For instance:
	simple-audio-widgets =
		"Microphone", "Microphone Jack",
		"Line", "Line In Jack",
		"Line", "Line Out Jack",
		"Headphone", "Headphone Jack",
		"Speaker", "Speaker External";

The "template-wname" currently includes: "Microphone", "Line", "Headphone"
and "Speaker".

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c4be7ab..21d025e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1188,6 +1188,8 @@ void snd_soc_util_exit(void);
 
 int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+					  const char *propname);
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d8daf16..abee5f4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4471,6 +4471,93 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_card_name);
 
+static const struct snd_soc_dapm_widget simple_widgets[] = {
+	SND_SOC_DAPM_MIC("Microphone", NULL),
+	SND_SOC_DAPM_LINE("Line", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+					  const char *propname)
+{
+	struct device_node *np = card->dev->of_node;
+	struct snd_soc_dapm_widget *widgets;
+	const char *template, *wname;
+	int i, j, num_widgets, ret;
+
+	num_widgets = of_property_count_strings(np, propname);
+	if (num_widgets < 0) {
+		dev_err(card->dev,
+			"ASoC: Property '%s' does not exist\n",	propname);
+		return -EINVAL;
+	}
+	if (num_widgets & 1) {
+		dev_err(card->dev,
+			"ASoC: Property '%s' length is not even\n", propname);
+		return -EINVAL;
+	}
+
+	num_widgets /= 2;
+	if (!num_widgets) {
+		dev_err(card->dev, "ASoC: Property '%s's length is zero\n",
+			propname);
+		return -EINVAL;
+	}
+
+	widgets = devm_kcalloc(card->dev, num_widgets, sizeof(*widgets),
+			       GFP_KERNEL);
+	if (!widgets) {
+		dev_err(card->dev,
+			"ASoC: Could not allocate memory for widgets\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_widgets; i++) {
+		ret = of_property_read_string_index(np, propname,
+			2 * i, &template);
+		if (ret) {
+			dev_err(card->dev,
+				"ASoC: Property '%s' index %d read error:%d\n",
+				propname, 2 * i, ret);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < ARRAY_SIZE(simple_widgets); j++) {
+			if (!strncmp(template, simple_widgets[j].name,
+				     strlen(simple_widgets[j].name))) {
+				widgets[i] = simple_widgets[j];
+				break;
+			}
+		}
+
+		if (j >= ARRAY_SIZE(simple_widgets)) {
+			dev_err(card->dev,
+				"ASoC: DAPM widget '%s' is not supported\n",
+				template);
+			return -EINVAL;
+		}
+
+		ret = of_property_read_string_index(np, propname,
+						    (2 * i) + 1,
+						    &wname);
+		if (ret) {
+			dev_err(card->dev,
+				"ASoC: Property '%s' index %d read error:%d\n",
+				propname, (2 * i) + 1, ret);
+			return -EINVAL;
+		}
+
+		widgets[i].name = wname;
+	}
+
+	card->dapm_widgets = widgets;
+	card->num_dapm_widgets = num_widgets;
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
