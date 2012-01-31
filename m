From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: max9768: Fix up review comments in
	max9768 driver
Date: Tue, 31 Jan 2012 11:01:13 +0000
Message-ID: <1328007673-16695-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0F9F103A33
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 12:01:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Mute Switch should be called Playback Switch to match the volume
and the regmap core has been updated so we don't need to mark all the
registers as non-volatile.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/max9768.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 6348995..79e9901 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -115,7 +115,7 @@ static const struct snd_kcontrol_new max9768_volume[] = {
 };
 
 static const struct snd_kcontrol_new max9768_mute[] = {
-	SOC_SINGLE_BOOL_EXT("Mute Switch", 0, max9768_get_gpio, max9768_set_gpio),
+	SOC_SINGLE_BOOL_EXT("Playback Switch", 0, max9768_get_gpio, max9768_set_gpio),
 };
 
 static int max9768_probe(struct snd_soc_codec *codec)
@@ -150,18 +150,12 @@ static struct snd_soc_codec_driver max9768_codec_driver = {
 	.num_controls = ARRAY_SIZE(max9768_volume),
 };
 
-static bool max9768_always_false(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
 static const struct regmap_config max9768_i2c_regmap_config = {
 	.reg_bits = 2,
 	.val_bits = 6,
 	.max_register = 3,
 	.reg_defaults = max9768_default_regs,
 	.num_reg_defaults = ARRAY_SIZE(max9768_default_regs),
-	.volatile_reg = max9768_always_false,
 	.cache_type = REGCACHE_RBTREE,
 };
 
-- 
1.7.9.rc1
