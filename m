From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Simplify compress_type
	overriding functionality
Date: Tue, 11 Jan 2011 11:43:51 +0000
Message-ID: <1294746231-13914-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 574152448D
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:43:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2ff708a..52aaef9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1748,6 +1748,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	list_for_each_entry(codec, &codec_list, list) {
 		if (codec->cache_init)
 			continue;
+		/* by default we don't override the compress_type */
+		compress_type = 0;
 		/* check to see if we need to override the compress_type */
 		for (i = 0; i < card->num_configs; ++i) {
 			codec_conf = &card->codec_conf[i];
@@ -1758,18 +1760,6 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 					break;
 			}
 		}
-		if (i == card->num_configs) {
-			/* no need to override the compress_type so
-			 * go ahead and do the standard thing */
-			ret = snd_soc_init_codec_cache(codec, 0);
-			if (ret < 0) {
-				mutex_unlock(&card->mutex);
-				return;
-			}
-			continue;
-		}
-		/* override the compress_type with the one supplied in
-		 * the machine driver */
 		ret = snd_soc_init_codec_cache(codec, compress_type);
 		if (ret < 0) {
 			mutex_unlock(&card->mutex);
-- 
1.7.3.5
