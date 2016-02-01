From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] regmap: cache: Fall back to register by register read for cache defaults
Date: Mon,  1 Feb 2016 21:38:15 +0000
Message-ID: <1454362695-10682-2-git-send-email-broonie@kernel.org>
References: <1454362695-10682-1-git-send-email-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454362695-10682-1-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mail@maciej.szmigiero.name, Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

If we are unable to read the cache defaults for a regmap then fall back
on attempting to read them word by word. This is going to be painfully
slow for large regmaps but might be adequate for smaller ones.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 5c5090b68939..5f788f07b74c 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -30,7 +30,7 @@ static int regcache_hw_init(struct regmap *map)
 	int i, j;
 	int ret;
 	int count;
-	unsigned int val;
+	unsigned int reg, val;
 	void *tmp_buf;
 
 	if (!map->num_reg_defaults_raw)
@@ -67,27 +67,39 @@ static int regcache_hw_init(struct regmap *map)
 		ret = regmap_raw_read(map, 0, tmp_buf,
 				      map->cache_size_raw);
 		map->cache_bypass = cache_bypass;
-		if (ret < 0)
-			goto err_cache_free;
-
-		map->reg_defaults_raw = tmp_buf;
-		map->cache_free = 1;
+		if (ret == 0) {
+			map->reg_defaults_raw = tmp_buf;
+			map->cache_free = 1;
+		} else {
+			kfree(tmp_buf);
+		}
 	}
 
 	/* fill the reg_defaults */
 	for (i = 0, j = 0; i < map->num_reg_defaults_raw; i++) {
-		if (regmap_volatile(map, i * map->reg_stride))
+		reg = i * map->reg_stride;
+
+		if (regmap_volatile(map, reg))
 			continue;
-		val = regcache_get_val(map, map->reg_defaults_raw, i);
-		map->reg_defaults[j].reg = i * map->reg_stride;
+
+		if (map->reg_defaults_raw) {
+			val = regcache_get_val(map, map->reg_defaults_raw, i);
+		} else {
+			ret = regmap_read(map, reg, &val);
+			if (ret != 0) {
+				dev_err(map->dev, "Failed to read %d: %d\n",
+					reg, ret);
+				goto err_free;
+			}
+		}
+
+		map->reg_defaults[j].reg = reg;
 		map->reg_defaults[j].def = val;
 		j++;
 	}
 
 	return 0;
 
-err_cache_free:
-	kfree(tmp_buf);
 err_free:
 	kfree(map->reg_defaults);
 
-- 
2.7.0.rc3
