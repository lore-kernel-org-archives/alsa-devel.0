From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Check return value of regcache_sync()" to the asoc tree
Date: Thu, 02 Jun 2016 11:18:19 +0100
Message-ID: <E1b8Phj-0001aJ-Kx@finisterre>
References: <1464735999-10384-2-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464735999-10384-2-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.comPaul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Check return value of regcache_sync()

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

>From 87a4bb11355f8b59c0d865a96044b5853f6c222e Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 31 May 2016 16:06:39 -0700
Subject: [PATCH] ASoC: cs53l30: Check return value of regcache_sync()

Regcache_sync() might fail. So this patch adds a return value Check for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 9aff449e57af..ac90dd79857e 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -1055,7 +1055,11 @@ static int cs53l30_runtime_resume(struct device *dev)
 		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
 
 	regcache_cache_only(cs53l30->regmap, false);
-	regcache_sync(cs53l30->regmap);
+	ret = regcache_sync(cs53l30->regmap);
+	if (ret) {
+		dev_err(dev, "failed to synchronize regcache: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.8.1
