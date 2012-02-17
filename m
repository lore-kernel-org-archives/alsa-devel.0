From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8996: Make sure we bounce /RESET to
	reset
Date: Fri, 17 Feb 2012 13:13:28 -0800
Message-ID: <1329513208-20204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11919103FF0
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 22:13:34 +0100 (CET)
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

While it matches the current code only bringing the device out of reset
isn't actually doing what the function says so make sure we set the GPIO
high before we pull it low.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e3e3a37..03d191a 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1713,6 +1713,7 @@ static bool wm8996_volatile_register(struct device *dev, unsigned int reg)
 static int wm8996_reset(struct wm8996_priv *wm8996)
 {
 	if (wm8996->pdata.ldo_ena > 0) {
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 1);
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 		return 0;
 	} else {
-- 
1.7.9
