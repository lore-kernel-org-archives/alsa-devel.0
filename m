From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Make cache status available via debugfs
Date: Wed, 26 Jan 2011 21:05:46 +0000
Message-ID: <1296075946-20037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8C75103A7A
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 22:05:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Could just as well live in sysfs but sysfs doesn't have the simple
value export helpers debugfs does.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    4 ++--
 sound/soc/soc-core.c |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4fd79e0..49a14da 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -494,14 +494,14 @@ struct snd_soc_codec {
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int active;
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
-	unsigned int cache_only:1;  /* Suppress writes to hardware */
-	unsigned int cache_sync:1; /* Cache needs to be synced to hardware */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
 	unsigned int probed:1; /* Codec has been probed */
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
 	unsigned int cache_init:1; /* codec cache has been initialized */
+	u32 cache_only;  /* Suppress writes to hardware */
+	u32 cache_sync; /* Cache needs to be synced to hardware */
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5dffc7a4..8af47f7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -235,6 +235,11 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 		return;
 	}
 
+	debugfs_create_bool("cache_sync", 0444, codec->debugfs_codec_root,
+			    &codec->cache_sync);
+	debugfs_create_bool("cache_only", 0444, codec->debugfs_codec_root,
+			    &codec->cache_only);
+
 	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
 						 codec->debugfs_codec_root,
 						 codec, &codec_reg_fops);
-- 
1.7.2.3
