From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Convert wm8996 to use devm_kzalloc()
Date: Sun, 27 Nov 2011 16:03:12 +0000
Message-ID: <1322409792-5132-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322409792-5132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5D1D2447E
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 17:03:17 +0100 (CET)
In-Reply-To: <1322409792-5132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 304a0e5..41cc9d2 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3104,7 +3104,8 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 	int ret, i;
 	unsigned int reg;
 
-	wm8996 = kzalloc(sizeof(struct wm8996_priv), GFP_KERNEL);
+	wm8996 = devm_kzalloc(&i2c->dev, sizeof(struct wm8996_priv),
+			      GFP_KERNEL);
 	if (wm8996 == NULL)
 		return -ENOMEM;
 
@@ -3216,7 +3217,6 @@ err_gpio:
 	if (wm8996->pdata.ldo_ena > 0)
 		gpio_free(wm8996->pdata.ldo_ena);
 err:
-	kfree(wm8996);
 
 	return ret;
 }
@@ -3234,7 +3234,6 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 		gpio_free(wm8996->pdata.ldo_ena);
 	}
-	kfree(wm8996);
 	return 0;
 }
 
-- 
1.7.7.3
