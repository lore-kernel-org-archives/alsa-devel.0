From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: Constify the 'driver' field of
	snd_soc_platform
Date: Wed, 27 Mar 2013 12:02:22 +0100
Message-ID: <1364382144-30151-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2331D265154
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 12:06:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC core does no not modify the driver of a platform. Making it const
allows ASoC platform drivers to declare the snd_soc_platform_driver struct as
const.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 4 ++--
 sound/soc/soc-core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1ffe9d4..e666119 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -373,7 +373,7 @@ int snd_soc_suspend(struct device *dev);
 int snd_soc_resume(struct device *dev);
 int snd_soc_poweroff(struct device *dev);
 int snd_soc_register_platform(struct device *dev,
-		struct snd_soc_platform_driver *platform_drv);
+		const struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
 int snd_soc_register_codec(struct device *dev,
 		const struct snd_soc_codec_driver *codec_drv,
@@ -829,7 +829,7 @@ struct snd_soc_platform {
 	const char *name;
 	int id;
 	struct device *dev;
-	struct snd_soc_platform_driver *driver;
+	const struct snd_soc_platform_driver *driver;
 	struct mutex mutex;
 
 	unsigned int suspended:1; /* platform is suspended */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 561d589..7bf21a1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3905,7 +3905,7 @@ static void snd_soc_unregister_dais(struct device *dev, size_t count)
  * @platform: platform to register
  */
 int snd_soc_register_platform(struct device *dev,
-		struct snd_soc_platform_driver *platform_drv)
+		const struct snd_soc_platform_driver *platform_drv)
 {
 	struct snd_soc_platform *platform;
 
-- 
1.8.0
