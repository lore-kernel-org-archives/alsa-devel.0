From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: Remove duplicated rtd->codec
	initialization
Date: Tue,  1 Jul 2014 22:13:45 +0200
Message-ID: <1404245628-30877-2-git-send-email-lars@metafoo.de>
References: <1404245628-30877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DE96265091
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 22:13:56 +0200 (CEST)
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

rtd->codec is already initialized in soc_bind_dai_link(), so there is no need to
do it again in soc_dai_link_init(). Removing the rtd->codec initialization from
soc_dai_link_init() also removes the need for soc_dai_link_init() to know about
the CODEC at all.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 72d4a2b..0cd36b7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1308,9 +1308,7 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
 	return 0;
 }
 
-static int soc_dai_link_init(struct snd_soc_card *card,
-			     struct snd_soc_codec *codec,
-			     int num)
+static int soc_dai_link_init(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
@@ -1325,8 +1323,6 @@ static int soc_dai_link_init(struct snd_soc_card *card,
 			return ret;
 	}
 
-	rtd->codec = codec;
-
 	return 0;
 }
 
@@ -1344,7 +1340,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 		dai_link = &card->dai_link[num];
 		rtd = &card->rtd[num];
 		name = dai_link->name;
-		ret = soc_dai_link_init(card, codec, num);
+		ret = soc_dai_link_init(card, num);
 	} else {
 		aux_dev = &card->aux_dev[num];
 		rtd = &card->rtd_aux[num];
-- 
1.8.0
