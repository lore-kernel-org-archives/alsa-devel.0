From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: Replace soc_find_matching_codec()
	with soc_find_codec()
Date: Tue,  1 Jul 2014 22:13:46 +0200
Message-ID: <1404245628-30877-3-git-send-email-lars@metafoo.de>
References: <1404245628-30877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id CAAF52650C2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 22:13:57 +0200 (CEST)
In-Reply-To: <1404245628-30877-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

soc_find_matching_codec() works in the same way as soc_find_codec() except that
it only works for auxdevs. It can easily be replaced by the generic
soc_find_codec().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0cd36b7..c8bdac2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1649,32 +1649,13 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
-static struct snd_soc_codec *soc_find_matching_codec(struct snd_soc_card *card,
-	int num)
-{
-	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	struct snd_soc_codec *codec;
-
-	/* find CODEC from registered CODECs */
-	list_for_each_entry(codec, &codec_list, list) {
-		if (aux_dev->codec_of_node &&
-		   (codec->dev->of_node != aux_dev->codec_of_node))
-			continue;
-		if (aux_dev->codec_name &&
-			strcmp(codec->component.name, aux_dev->codec_name))
-			continue;
-		return codec;
-	}
-
-	return NULL;
-}
-
 static int soc_check_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	const char *codecname = aux_dev->codec_name;
-	struct snd_soc_codec *codec = soc_find_matching_codec(card, num);
+	struct snd_soc_codec *codec;
 
+	codec = soc_find_codec(aux_dev->codec_of_node, aux_dev->codec_name);
 	if (codec)
 		return 0;
 	if (aux_dev->codec_of_node)
@@ -1689,8 +1670,9 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	const char *codecname = aux_dev->codec_name;
 	int ret = -ENODEV;
-	struct snd_soc_codec *codec = soc_find_matching_codec(card, num);
+	struct snd_soc_codec *codec;
 
+	codec = soc_find_codec(aux_dev->codec_of_node, aux_dev->codec_name);
 	if (!codec) {
 		if (aux_dev->codec_of_node)
 			codecname = of_node_full_name(aux_dev->codec_of_node);
-- 
1.8.0
