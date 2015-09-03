From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 03/12] ASoC: wm8510: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 12:56:29 +0200
Message-ID: <20150903105629.GA16812@goodgumbo.baconseed.org>
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
 sound/soc/codecs/wm8510.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index dac5beb..0617415 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -598,6 +598,7 @@ static const struct of_device_id wm8510_of_match[] = {
 	{ .compatible = "wlf,wm8510" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8510_of_match);
 
 static const struct regmap_config wm8510_regmap = {
 	.reg_bits = 7,
-- 
2.4.6
