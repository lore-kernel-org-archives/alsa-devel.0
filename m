From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: s3c24xx: use const
	snd_soc_component_driver pointer" to the asoc tree
Date: Wed, 27 Jan 2016 18:37:04 +0000
Message-ID: <E1aOUxk-00084b-TT@debutante>
References: <1453741678-1988125-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E1EC26044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:17 +0100 (CET)
In-Reply-To: <1453741678-1988125-2-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: s3c24xx: use const snd_soc_component_driver pointer

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

>From ba4bc32eaa39ba7687f0958ae90eec94da613b46 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Jan 2016 18:07:33 +0100
Subject: [PATCH] ASoC: s3c24xx: use const snd_soc_component_driver pointer

An older patch to convert the API in the s3c i2s driver
ended up passing a const pointer into a function that takes
a non-const pointer, so we now get a warning:

sound/soc/samsung/s3c2412-i2s.c: In function 's3c2412_iis_dev_probe':
sound/soc/samsung/s3c2412-i2s.c:172:9: error: passing argument 3 of 's3c_i2sv2_register_component' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

However, the s3c_i2sv2_register_component() function again
passes the pointer into another function taking a const, so
we just need to change its prototype.

Fixes: eca3b01d0885 ("ASoC: switch over to use snd_soc_register_component() on s3c i2s")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 sound/soc/samsung/s3c-i2s-v2.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index df65c5b494b1..b6ab3fc5789e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -709,7 +709,7 @@ static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
 #endif
 
 int s3c_i2sv2_register_component(struct device *dev, int id,
-			   struct snd_soc_component_driver *cmp_drv,
+			   const struct snd_soc_component_driver *cmp_drv,
 			   struct snd_soc_dai_driver *dai_drv)
 {
 	struct snd_soc_dai_ops *ops = (struct snd_soc_dai_ops *)dai_drv->ops;
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
index 90abab364b49..d0684145ed1f 100644
--- a/sound/soc/samsung/s3c-i2s-v2.h
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -101,7 +101,7 @@ extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
  * soc core.
  */
 extern int s3c_i2sv2_register_component(struct device *dev, int id,
-					struct snd_soc_component_driver *cmp_drv,
+					const struct snd_soc_component_driver *cmp_drv,
 					struct snd_soc_dai_driver *dai_drv);
 
 #endif /* __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H */
-- 
2.7.0.rc3
