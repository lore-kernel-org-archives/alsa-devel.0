From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/13] ASoC: Pass component instead of DAPM
	context to AUX dev init callback
Date: Tue, 19 Aug 2014 15:51:23 +0200
Message-ID: <1408456290-13945-7-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A868265686
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:45 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Given that the component is the containing structure it makes more sense to pass
the component rather than the DAPM context to the AUX dev init callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h          | 2 +-
 sound/soc/samsung/speyside.c | 6 ++++--
 sound/soc/soc-core.c         | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ec35ca3..f8abe22 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1022,7 +1022,7 @@ struct snd_soc_aux_dev {
 	const struct device_node *codec_of_node;
 
 	/* codec/machine specific init - e.g. add machine controls */
-	int (*init)(struct snd_soc_dapm_context *dapm);
+	int (*init)(struct snd_soc_component *component);
 };
 
 /* SoC card */
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 9902efc..a054826 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -228,10 +228,12 @@ static struct snd_soc_dai_link speyside_dai[] = {
 	},
 };
 
-static int speyside_wm9081_init(struct snd_soc_dapm_context *dapm)
+static int speyside_wm9081_init(struct snd_soc_component *component)
 {
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
 	/* At any time the WM9081 is active it will have this clock */
-	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK, 0,
+	return snd_soc_codec_set_sysclk(codec, WM9081_SYSCLK_MCLK, 0,
 					MCLK_AUDIO_RATE, 0);
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1d4776e..b84bf05 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1632,7 +1632,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 
 	/* do machine specific initialization */
 	if (aux_dev->init) {
-		ret = aux_dev->init(snd_soc_component_get_dapm(rtd->component));
+		ret = aux_dev->init(rtd->component);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: failed to init %s: %d\n",
 				aux_dev->name, ret);
-- 
1.8.0
