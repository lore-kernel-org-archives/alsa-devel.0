From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/2] ASoC: samsung: i2s: Fix the secondary platform device
 registration
Date: Fri, 15 Feb 2019 15:48:08 +0100
Message-ID: <20190215144809.28007-1-s.nawrocki@samsung.com>
References: <CGME20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com, m.szyprowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

This fixes unregistration of the secondary platform device so all
resources are properly released. The test for NULL priv->pdev_sec
is not necessary and it is removed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch is based off of ASoC for-next and patches:
 ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM 
 ASoC: samsung: i2s: Prevent potential NULL platform data dereference 
 ASoC: samsung: odroid: Add missing DAPM routes
 
 sound/soc/samsung/i2s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6bf0f55d1e51..e36c44e2f1bb 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 
 static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
 {
-	if (priv->pdev_sec) {
-		platform_device_del(priv->pdev_sec);
-		priv->pdev_sec = NULL;
-	}
+	platform_device_unregister(priv->pdev_sec);
+	priv->pdev_sec = NULL;
 }
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
-- 
2.17.1
