From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ASoC: max98090: Fix build warning
Date: Mon,  7 Jul 2014 15:18:19 +0200
Message-ID: <1404739099-20717-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Thierry Reding <treding@nvidia.com>

The max98090_{suspend,resume}() functions are used for system sleep and
therefore need to be guarded by CONFIG_PM_SLEEP rather than CONFIG_PM.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index ca74f502a4cb..e806065d68cc 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2415,7 +2415,7 @@ static int max98090_runtime_suspend(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int max98090_resume(struct device *dev)
 {
 	struct max98090_priv *max98090 = dev_get_drvdata(dev);
-- 
2.0.1
