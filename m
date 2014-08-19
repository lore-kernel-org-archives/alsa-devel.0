From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/13] ASoC: Remove support for legacy
	snd_soc_platform IO
Date: Tue, 19 Aug 2014 15:51:29 +0200
Message-ID: <1408456290-13945-13-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 079732657DE
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:54 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
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

There were never any actual users of this in upstream and by we have with
regmap a replacement in place, which should be used by new drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  3 ---
 sound/soc/soc-core.c | 22 ----------------------
 2 files changed, 25 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d4ba8048..e43fbb6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -890,9 +890,6 @@ struct snd_soc_platform_driver {
 	/* platform stream compress ops */
 	const struct snd_compr_ops *compr_ops;
 
-	/* platform IO - used for platform DAPM */
-	unsigned int (*read)(struct snd_soc_platform *, unsigned int);
-	int (*write)(struct snd_soc_platform *, unsigned int, unsigned int);
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5c78098..f359da2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4151,24 +4151,6 @@ static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
 	platform->driver->remove(platform);
 }
 
-static int snd_soc_platform_drv_write(struct snd_soc_component *component,
-	unsigned int reg, unsigned int val)
-{
-	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
-
-	return platform->driver->write(platform, reg, val);
-}
-
-static int snd_soc_platform_drv_read(struct snd_soc_component *component,
-	unsigned int reg, unsigned int *val)
-{
-	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
-
-	*val = platform->driver->read(platform, reg);
-
-	return 0;
-}
-
 /**
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
@@ -4205,10 +4187,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		platform->component.probe = snd_soc_platform_drv_probe;
 	if (platform_drv->remove)
 		platform->component.remove = snd_soc_platform_drv_remove;
-	if (platform_drv->write)
-		platform->component.write = snd_soc_platform_drv_write;
-	if (platform_drv->read)
-		platform->component.read = snd_soc_platform_drv_read;
 
 #ifdef CONFIG_DEBUG_FS
 	platform->component.debugfs_prefix = "platform";
-- 
1.8.0
