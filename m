From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] asoc/multi-component: remove superfluous
	snd_card member from snd_soc_platform
Date: Wed, 11 Aug 2010 14:29:46 +0200
Message-ID: <1281529786-5267-3-git-send-email-s.hauer@pengutronix.de>
References: <1281529786-5267-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0BC34103872
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 14:29:48 +0200 (CEST)
In-Reply-To: <1281529786-5267-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 include/sound/soc.h  |    1 -
 sound/soc/soc-core.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4b0f4cd..d31e8b7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -526,7 +526,6 @@ struct snd_soc_platform {
 	unsigned int suspended:1; /* platform is suspended */
 	unsigned int probed:1;
 
-	struct snd_card *snd_card;
 	struct snd_soc_card *card;
 	struct list_head list;
 	struct list_head card_list;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4300d6f..1a2c745 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1287,7 +1287,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
 
 	/* config components */
-	platform->snd_card = card->snd_card;
 	codec_dai->codec = codec;
 	codec->card = card;
 	cpu_dai->platform = platform;
-- 
1.7.1
