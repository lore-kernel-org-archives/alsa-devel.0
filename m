From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ASoC: nau8825: Export I2C module alias information
Date: Tue, 17 May 2016 12:00:09 -0400
Message-ID: <1463500829-9723-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, John Hsu <KCHSU0@nuvoton.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Yong Zhi <yong.zhi@intel.com>, "Yang A\"" <yang.a.fang@intel.com>, kbuild test robot <lkp@intel.com>, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

The I2C driver has an i2c_device_id array but that information isn't
exported to the module using the MODULE_DEVICE_TABLE() macro. So the
module autoloading won't work if the I2C device is registered using
OF or legacy board files due missing alias information in the module.

The issue was found using Kieran Bingham's coccinelle semantic patch:
https://lkml.org/lkml/2016/5/10/520

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 sound/soc/codecs/nau8825.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 81fc97b07751..e988f89ef715 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1493,6 +1493,7 @@ static const struct i2c_device_id nau8825_i2c_ids[] = {
 	{ "nau8825", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, nau8825_i2c_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id nau8825_of_ids[] = {
-- 
2.5.5
