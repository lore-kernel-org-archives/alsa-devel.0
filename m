From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5100: Fix microphone configuration
Date: Wed, 25 Jan 2012 17:57:45 +0000
Message-ID: <1327514265-17171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07A55103BCB
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 18:57:48 +0100 (CET)
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

We need to write the configuration for each microphone to a different
register.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 0c82f38..51b281b 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2610,6 +2610,13 @@ static const struct regmap_config wm5100_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static const unsigned int wm5100_mic_ctrl_reg[] = {
+	WM5100_IN1L_CONTROL,
+	WM5100_IN2L_CONTROL,
+	WM5100_IN3L_CONTROL,
+	WM5100_IN4L_CONTROL,
+};
+
 static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -2740,7 +2747,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm5100->pdata.in_mode); i++) {
-		regmap_update_bits(wm5100->regmap, WM5100_IN1L_CONTROL,
+		regmap_update_bits(wm5100->regmap, wm5100_mic_ctrl_reg[i],
 				   WM5100_IN1_MODE_MASK |
 				   WM5100_IN1_DMIC_SUP_MASK,
 				   (wm5100->pdata.in_mode[i] <<
-- 
1.7.9.rc1
