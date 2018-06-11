From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v3 3/3] ASoC: audio-graph-card: add hp and mic
	detect gpios same as simple-card
Date: Mon, 11 Jun 2018 17:32:14 +0900
Message-ID: <20180611083214.16858-3-suzuki.katsuhiro@socionext.com>
References: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 71929266D4C
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 10:32:23 +0200 (CEST)
In-Reply-To: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds headphone and microphone jack detection gpios as same
as simple-card driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v2:
  - Nothing

Changes from v1:
  - Move changes of audio-graph-card to other patch
---
 sound/soc/generic/audio-graph-card.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 1b6164249341..2baa60d3b3cc 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -21,7 +21,6 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
-#include <sound/jack.h>
 #include <sound/simple_card_utils.h>
 
 struct graph_card_data {
@@ -32,6 +31,8 @@ struct graph_card_data {
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
+	struct asoc_simple_jack hp_jack;
+	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
 	struct gpio_desc *pa_gpio;
 };
@@ -278,6 +279,22 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	return count;
 }
 
+static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
+{
+	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int asoc_graph_card_probe(struct platform_device *pdev)
 {
 	struct graph_card_data *priv;
@@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->num_links	= num;
 	card->dapm_widgets = asoc_graph_card_dapm_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
+	card->probe	= asoc_graph_soc_card_probe;
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.17.1
