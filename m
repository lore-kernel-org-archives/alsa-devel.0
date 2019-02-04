From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] ASoC: ak4118: fix missing header
Date: Mon,  4 Feb 2019 16:35:38 +0100
Message-ID: <20190204153538.26166-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrien Charruel <adrien.charruel@devialet.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: alsa-devel@alsa-project.org

This driver use the gpio consumer interface.
Add the header as it's needed.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

This has been triggered by Kbuild-all for information:
https://lists.01.org/pipermail/kbuild-all/2019-February/057379.html

 sound/soc/codecs/ak4118.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
index 238ab29f2bf4..ce419e8cf890 100644
--- a/sound/soc/codecs/ak4118.c
+++ b/sound/soc/codecs/ak4118.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-- 
2.19.1
