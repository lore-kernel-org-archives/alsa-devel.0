From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 3/6] ASoC: core: Add helper for DAI widgets
	linking
Date: Fri, 21 Mar 2014 16:27:27 +0100
Message-ID: <1395415650-20045-4-git-send-email-bcousson@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CDEE265460
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:28:23 +0100 (CET)
Received: by mail-wg0-f52.google.com with SMTP id k14so1698861wgh.11
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:28:23 -0700 (PDT)
In-Reply-To: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
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
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, lars@metafoo.de, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Add a helper for DAI widgets linking in preparation for
DAI-multicodec support.

No functional change.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[fparent@baylibre.com: Adapt to 3.14+]
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 64 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1bcc446..1debe3d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1418,6 +1418,42 @@ static int soc_probe_codec_dai(struct snd_soc_card *card,
 	return 0;
 }
 
+static int soc_link_dai_widgets(struct snd_soc_card *card,
+				struct snd_soc_dai_link *dai_link,
+				struct snd_soc_dai *cpu_dai,
+				struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_dapm_widget *play_w, *capture_w;
+	int ret;
+
+	/* link the DAI widgets */
+	play_w = codec_dai->playback_widget;
+	capture_w = cpu_dai->capture_widget;
+	if (play_w && capture_w) {
+		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+					   capture_w, play_w);
+		if (ret != 0) {
+			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
+				play_w->name, capture_w->name, ret);
+			return ret;
+		}
+	}
+
+	play_w = cpu_dai->playback_widget;
+	capture_w = codec_dai->capture_widget;
+	if (play_w && capture_w) {
+		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+					   capture_w, play_w);
+		if (ret != 0) {
+			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
+				play_w->name, capture_w->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
@@ -1426,7 +1462,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dapm_widget *play_w, *capture_w;
 	int ret;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
@@ -1507,29 +1542,10 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 						codec2codec_close_delayed_work);
 
 			/* link the DAI widgets */
-			play_w = codec_dai->playback_widget;
-			capture_w = cpu_dai->capture_widget;
-			if (play_w && capture_w) {
-				ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-						   capture_w, play_w);
-				if (ret != 0) {
-					dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-						play_w->name, capture_w->name, ret);
-					return ret;
-				}
-			}
-
-			play_w = cpu_dai->playback_widget;
-			capture_w = codec_dai->capture_widget;
-			if (play_w && capture_w) {
-				ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-						   capture_w, play_w);
-				if (ret != 0) {
-					dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-						play_w->name, capture_w->name, ret);
-					return ret;
-				}
-			}
+			ret = soc_link_dai_widgets(card, dai_link,
+					cpu_dai, codec_dai);
+			if (ret)
+				return ret;
 		}
 	}
 
-- 
1.8.3.2
