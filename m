From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 02/12] ASoC: da9055: Fix module autoload for OF platform
 driver
Date: Thu, 3 Sep 2015 12:55:54 +0200
Message-ID: <20150903105554.GA16761@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/codecs/da9055.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 66bb446..ab39de6 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1533,6 +1533,7 @@ static const struct of_device_id da9055_of_match[] = {
 	{ .compatible = "dlg,da9055-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, da9055_of_match);
 
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
-- 
2.4.6
