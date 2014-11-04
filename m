From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Remove card field from snd_soc_dai
	struct
Date: Tue,  4 Nov 2014 11:30:58 +0100
Message-ID: <1415097059-14551-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-048.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B26B2614D4
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:31:05 +0100 (CET)
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

The card field of the snd_soc_dai field is very rarely used. We can use
dai->component->card instead and remove the card field from the snd_soc_dai
struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h | 2 --
 sound/soc/soc-core.c    | 7 +------
 sound/soc/soc-dapm.c    | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 45d0fa1..373d177 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -275,8 +275,6 @@ struct snd_soc_dai {
 	unsigned int tx_mask;
 	unsigned int rx_mask;
 
-	struct snd_soc_card *card;
-
 	struct list_head list;
 };
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3818cf3..d9b7b70 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1315,11 +1315,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
 			card->name, num, order);
 
-	/* config components */
-	cpu_dai->card = card;
-	for (i = 0; i < rtd->num_codecs; i++)
-		rtd->codec_dais[i]->card = card;
-
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
 
@@ -2314,7 +2309,7 @@ EXPORT_SYMBOL_GPL(snd_soc_add_card_controls);
 int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
-	struct snd_card *card = dai->card->snd_card;
+	struct snd_card *card = dai->component->card->snd_card;
 
 	return snd_soc_add_controls(card, dai->dev, controls, num_controls,
 			NULL, dai);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6bf2c97..c5136bb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1043,7 +1043,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list)
 {
-	struct snd_soc_card *card = dai->card;
+	struct snd_soc_card *card = dai->component->card;
 	struct snd_soc_dapm_widget *w;
 	int paths;
 
-- 
1.8.0
