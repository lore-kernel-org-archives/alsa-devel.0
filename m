From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Return -ENOSYS instead of
	-EINVAL
Date: Tue, 22 Mar 2011 10:48:49 +0000
Message-ID: <1300790929-26302-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48CAD1038C4
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:48:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

These functions fail with -EINVAL if the corresponding callbacks
are not implemented.  Change them to return -ENOSYS as it is more
appropriate for unimplemented callbacks.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 86beaad..0e2871e 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1295,7 +1295,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 				codec->cache_ops->name, codec->name);
 		return codec->cache_ops->init(codec);
 	}
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 /*
@@ -1310,7 +1310,7 @@ int snd_soc_cache_exit(struct snd_soc_codec *codec)
 				codec->cache_ops->name, codec->name);
 		return codec->cache_ops->exit(codec);
 	}
-	return -EINVAL;
+	return -ENOSYS;
 }
 
 /**
@@ -1334,7 +1334,7 @@ int snd_soc_cache_read(struct snd_soc_codec *codec,
 	}
 
 	mutex_unlock(&codec->cache_rw_mutex);
-	return -EINVAL;
+	return -ENOSYS;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cache_read);
 
@@ -1359,7 +1359,7 @@ int snd_soc_cache_write(struct snd_soc_codec *codec,
 	}
 
 	mutex_unlock(&codec->cache_rw_mutex);
-	return -EINVAL;
+	return -ENOSYS;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cache_write);
 
@@ -1382,7 +1382,7 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	}
 
 	if (!codec->cache_ops || !codec->cache_ops->sync)
-		return -EINVAL;
+		return -ENOSYS;
 
 	if (codec->cache_ops->name)
 		name = codec->cache_ops->name;
-- 
1.7.4.1
