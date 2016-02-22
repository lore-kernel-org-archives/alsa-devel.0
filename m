From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: cache: Fall back to register by
	register read for cache defaults" to the asoc tree
Date: Mon, 22 Feb 2016 12:14:59 +0900
Message-ID: <E1aXgxf-0005tk-PM@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72EED2606FF
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:15:09 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Fabio Estevam <fabio.estevam@nxp.com>Fabio Estevam <fabio.estevam@nxp.com>Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   regmap: cache: Fall back to register by register read for cache defaults

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3245d460a1eb55b5c3ca31dde7b5c5ac71546edf Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 2 Feb 2016 10:16:51 -0200
Subject: [PATCH] regmap: cache: Fall back to register by register read for
 cache defaults

If we are unable to read the cache defaults for a regmap then fall back
on attempting to read them word by word. This is going to be painfully
slow for large regmaps but might be adequate for smaller ones.

Signed-off-by: Mark Brown <broonie@kernel.org>
[maciej: Use cache_bypass around read and skipping of unreadable regs]
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 348be3a..cccceb5 100644
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
@@ -67,27 +67,46 @@ static int regcache_hw_init(struct regmap *map)
 		ret = regmap_raw_read(map, 0, tmp_buf,
 				      map->num_reg_defaults_raw);
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
+		if (!regmap_readable(map, reg))
 			continue;
-		val = regcache_get_val(map, map->reg_defaults_raw, i);
-		map->reg_defaults[j].reg = i * map->reg_stride;
+
+		if (regmap_volatile(map, reg))
+			continue;
+
+		if (map->reg_defaults_raw) {
+			val = regcache_get_val(map, map->reg_defaults_raw, i);
+		} else {
+			bool cache_bypass = map->cache_bypass;
+
+			map->cache_bypass = true;
+			ret = regmap_read(map, reg, &val);
+			map->cache_bypass = cache_bypass;
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
2.7.0
