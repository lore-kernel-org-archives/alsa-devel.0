From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8996: Fix /RESET bounce ordering
Date: Wed, 29 Feb 2012 17:45:58 +0000
Message-ID: <1330537558-20879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17A9F103C44
	for <alsa-devel@alsa-project.org>; Wed, 29 Feb 2012 18:47:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We want to leave the device out of rather than in reset.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index c1c7ef0..9376b19 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1719,8 +1719,8 @@ static bool wm8996_volatile_register(struct device *dev, unsigned int reg)
 static int wm8996_reset(struct wm8996_priv *wm8996)
 {
 	if (wm8996->pdata.ldo_ena > 0) {
-		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 1);
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 1);
 		return 0;
 	} else {
 		return regmap_write(wm8996->regmap, WM8996_SOFTWARE_RESET,
-- 
1.7.9.1
