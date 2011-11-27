From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove unneeded platform_device.h
	inclusions from CODECs
Date: Sun, 27 Nov 2011 12:15:20 +0000
Message-ID: <1322396120-5327-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3FD72437C
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 13:15:22 +0100 (CET)
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

They've not been needed for a long time if they were ever required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c        |    1 -
 sound/soc/codecs/ak4641.c        |    1 -
 sound/soc/codecs/ak4642.c        |    1 -
 sound/soc/codecs/alc5623.c       |    1 -
 sound/soc/codecs/cs4270.c        |    1 -
 sound/soc/codecs/cs42l51.c       |    1 -
 sound/soc/codecs/da7210.c        |    1 -
 sound/soc/codecs/max98088.c      |    1 -
 sound/soc/codecs/max98095.c      |    1 -
 sound/soc/codecs/rt5631.c        |    1 -
 sound/soc/codecs/sgtl5000.c      |    1 -
 sound/soc/codecs/ssm2602.c       |    1 -
 sound/soc/codecs/sta32x.c        |    1 -
 sound/soc/codecs/tlv320aic23.c   |    1 -
 sound/soc/codecs/tlv320aic32x4.c |    1 -
 sound/soc/codecs/tlv320aic3x.c   |    1 -
 sound/soc/codecs/tlv320dac33.c   |    1 -
 sound/soc/codecs/wm2000.c        |    1 -
 sound/soc/codecs/wm5100.c        |    1 -
 sound/soc/codecs/wm8510.c        |    1 -
 sound/soc/codecs/wm8523.c        |    1 -
 sound/soc/codecs/wm8580.c        |    1 -
 sound/soc/codecs/wm8711.c        |    1 -
 sound/soc/codecs/wm8731.c        |    1 -
 sound/soc/codecs/wm8737.c        |    1 -
 sound/soc/codecs/wm8741.c        |    1 -
 sound/soc/codecs/wm8750.c        |    1 -
 sound/soc/codecs/wm8753.c        |    1 -
 sound/soc/codecs/wm8770.c        |    1 -
 sound/soc/codecs/wm8776.c        |    1 -
 sound/soc/codecs/wm8900.c        |    1 -
 sound/soc/codecs/wm8903.c        |    1 -
 sound/soc/codecs/wm8904.c        |    1 -
 sound/soc/codecs/wm8940.c        |    1 -
 sound/soc/codecs/wm8955.c        |    1 -
 sound/soc/codecs/wm8960.c        |    1 -
 sound/soc/codecs/wm8961.c        |    1 -
 sound/soc/codecs/wm8962.c        |    1 -
 sound/soc/codecs/wm8971.c        |    1 -
 sound/soc/codecs/wm8974.c        |    1 -
 sound/soc/codecs/wm8978.c        |    1 -
 sound/soc/codecs/wm8988.c        |    1 -
 sound/soc/codecs/wm8990.c        |    1 -
 sound/soc/codecs/wm8991.c        |    1 -
 sound/soc/codecs/wm9081.c        |    1 -
 sound/soc/codecs/wm_hubs.c       |    1 -
 46 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index f6c4734..e1f5310 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 3657c76..f53f314 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -17,7 +17,6 @@
 #include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 30ce3d6..9b4ee6c 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -25,7 +25,6 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/soc.h>
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 88647d3..6a5c001 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -22,7 +22,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 5396b91..dc77ff7b 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/soc.h>
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 2f268f2..528510b 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/soc.h>
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 8ef820fd..e4ca61c 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -17,7 +17,6 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 48a52a1..9b6036e 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index cc712d5..01f4ad7 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index dac4d05..9fd50bd 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d73e654..8060b15 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -16,7 +16,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/clk.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 620411c..0d43e4b 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -33,7 +33,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index edcbeef..b3d1c78 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -24,7 +24,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 9782631..cba798e 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -24,7 +24,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index d2e38af..f553375 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -29,7 +29,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 7d665ea..21625dd 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -40,7 +40,6 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index abcb97e..6b0f0e2 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -27,7 +27,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index a3b9cbb..01b1abe 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -29,7 +29,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 40a2249..3c456cb 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -18,7 +18,6 @@
 #include <linux/gcd.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/fixed.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 26571b2..3a65571 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index d0ae82d..0c89f8e 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 0aa3e4d..764b2bf 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index a6f1e39..760080e 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index f95cba0..d3168fa 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -19,7 +19,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index b7d6615..c13e4f7 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index e51f4f0..bf471dc 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -18,7 +18,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index dfb41ad..b312fcc 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 736749d..d5afa4f 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -39,7 +39,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 87957e8..391c385 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/of_device.h>
 #include <linux/pm.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 359319c..af542a2 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -19,7 +19,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index a430930..6ac80cf 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -24,7 +24,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ff251d3..0cf78c1 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -23,7 +23,6 @@
 #include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/jack.h>
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index f0b0c7a..babca49 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 0dd1e0c..9f1cce8 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index dbf2a83..ca38722 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 06dca88..ed2773f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 783a3d1..c058701 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8b21d4a..7162f9f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -20,7 +20,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 98bfbdd..b01df56 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 16569c7..e41f999 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 517bb22..649a2e3 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 9d83bed5..608c672 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -18,7 +18,6 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 61c620e..58d7f0b 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index ac957ec..35c5389 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 48bf80b..ba12690 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index bde0e84..d1debfb 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
 #include <linux/mfd/wm8994/registers.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
1.7.7.3
