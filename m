From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: add
	snd_soc_of_parse_audio_simple_widgets for DeviceTree
Date: Tue, 14 Jan 2014 16:54:24 +0800
Message-ID: <1389689664-24980-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 56045261663
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 10:52:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org
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
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 03ce45b..b2b5900 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1172,6 +1172,8 @@ void snd_soc_util_exit(void);
 
 int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
+int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+					  const char *propname);
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a128f0..36cadd3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4417,6 +4417,68 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
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
+				"ASoC: Property '%s' index %d could not be read: %d\n",
+				propname, i, ret);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < ARRAY_SIZE(simple_widgets); j++) {
+			if (!strncmp(wname, simple_widgets[j].name,
+					strlen(simple_widgets[j].name))) {
+				widgets[i] = simple_widgets[j];
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
