From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Remove unused cache_only from struct
	snd_soc_codec
Date: Thu, 28 Aug 2014 14:07:11 +0300
Message-ID: <1409224031-9334-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D552E269417
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 13:07:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

There are no real users for cache_only in "struct snd_soc_codec" so remove
it and needless debugfs node.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 include/sound/soc.h  | 1 -
 sound/soc/soc-core.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e43fbb6f8f8c..29650de0df7b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -792,7 +792,6 @@ struct snd_soc_codec {
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int cache_init:1; /* codec cache has been initialized */
-	u32 cache_only;  /* Suppress writes to hardware */
 	u32 cache_sync; /* Cache needs to be synced to hardware */
 
 	/* codec IO */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4974b4f9c952..b1327ef05860 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -311,8 +311,6 @@ static void soc_init_codec_debugfs(struct snd_soc_component *component)
 
 	debugfs_create_bool("cache_sync", 0444, codec->component.debugfs_root,
 			    &codec->cache_sync);
-	debugfs_create_bool("cache_only", 0444, codec->component.debugfs_root,
-			    &codec->cache_only);
 
 	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
 						 codec->component.debugfs_root,
-- 
2.1.0
