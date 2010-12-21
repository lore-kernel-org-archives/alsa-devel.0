From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: If we can't find a cache compression
	type default to flat
Date: Tue, 21 Dec 2010 17:10:42 +0000
Message-ID: <1292951442-32687-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29949103817
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 18:10:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This makes it easier to make cache types build time configurable as we
don't have a hard dependency on a given cache being built in.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 678fd75..d78e5b7 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1531,6 +1531,7 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 
 /* an array of all supported compression types */
 static const struct snd_soc_cache_ops cache_types[] = {
+	/* Flat *must* be the first entry for fallback */
 	{
 		.id = SND_SOC_FLAT_COMPRESSION,
 		.name = "flat",
@@ -1567,10 +1568,12 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(cache_types); ++i)
 		if (cache_types[i].id == codec->compress_type)
 			break;
+
+	/* Fall back to flat compression */
 	if (i == ARRAY_SIZE(cache_types)) {
-		dev_err(codec->dev, "Could not match compress type: %d\n",
-			codec->compress_type);
-		return -EINVAL;
+		dev_warn(codec->dev, "Could not match compress type: %d\n",
+			 codec->compress_type);
+		i = 0;
 	}
 
 	mutex_init(&codec->cache_rw_mutex);
-- 
1.7.2.3
