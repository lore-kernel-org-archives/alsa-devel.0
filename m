From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Simplify compress_type
	overriding functionality
Date: Tue, 11 Jan 2011 11:36:13 +0000
Message-ID: <1294745773-5123-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6817F245F7
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:36:21 +0100 (CET)
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
 sound/soc/soc-core.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2ff708a..13c4092 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1761,15 +1761,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		if (i == card->num_configs) {
 			/* no need to override the compress_type so
 			 * go ahead and do the standard thing */
-			ret = snd_soc_init_codec_cache(codec, 0);
-			if (ret < 0) {
-				mutex_unlock(&card->mutex);
-				return;
-			}
-			continue;
+			compress_type = 0;
 		}
-		/* override the compress_type with the one supplied in
-		 * the machine driver */
 		ret = snd_soc_init_codec_cache(codec, compress_type);
 		if (ret < 0) {
 			mutex_unlock(&card->mutex);
-- 
1.7.3.5
