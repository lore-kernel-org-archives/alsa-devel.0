From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 05/12] ASoC: wm8523: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 12:57:10 +0200
Message-ID: <20150903105710.GA16830@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/codecs/wm8523.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 43ea8ae..483ec72 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -430,6 +430,7 @@ static const struct of_device_id wm8523_of_match[] = {
 	{ .compatible = "wlf,wm8523" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8523_of_match);
 
 static const struct regmap_config wm8523_regmap = {
 	.reg_bits = 8,
-- 
2.4.6
