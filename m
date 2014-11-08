From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Forward calls to
	snd_soc_cache_sync() to regcache_sync()
Date: Sat,  8 Nov 2014 16:38:06 +0100
Message-ID: <1415461087-31162-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E201260488
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 16:38:04 +0100 (CET)
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

For convenience for drivers that do not want to keep their own pointer to
regmap struct around forward calls to snd_soc_cache_sync() to
regcache_sync() if the driver is using regmap. This is similar to what we do
for snd_soc_read()/snd_soc_write().

This patch also fixes drivers which already have been converted to regmap,
but still use snd_soc_cache_sync() for trying to the sync the cache.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Unfortunately there are a few drivers that have already been converted to
regmap, but still use snd_soc_cache_sync(). snd_soc_cache_sync() currently
is a noop for those drivers. Some of these conversions were done as early as
3.4 and while this patch applies cleanly to earlier kernel versions, due to
the restructuring of the ASoC core it will only work on 3.16+. Hence no
Fixes tag.
---
 sound/soc/soc-cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a9f82b5..6dab817 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -187,6 +187,9 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	const char *name = "flat";
 	int ret;
 
+	if (codec->component.regmap)
+		return regcache_sync(codec->component.regmap);
+
 	if (!codec->cache_sync)
 		return 0;
 
-- 
1.8.0
