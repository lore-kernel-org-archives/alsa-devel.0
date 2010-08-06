From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: multi-comp: twl4030: TI OMAP Platform
Date: Fri,  6 Aug 2010 08:49:55 +0300
Message-ID: <1281073795-4364-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F3C924399
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 07:49:56 +0200 (CEST)
In-Reply-To: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Changes for twl4030 codec:
- in mfd level
- in machine level

This can be squashed to 'ASoC: multi-component - TI OMAP Platform'
commit for now.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 drivers/mfd/twl-core.c        |    2 +-
 drivers/mfd/twl4030-codec.c   |    4 ++--
 include/linux/i2c/twl.h       |    6 +++++-
 sound/soc/omap/igep0020.c     |    1 -
 sound/soc/omap/omap2evm.c     |    1 -
 sound/soc/omap/omap3beagle.c  |    1 -
 sound/soc/omap/omap3evm.c     |    1 -
 sound/soc/omap/omap3pandora.c |    1 -
 sound/soc/omap/overo.c        |    1 -
 sound/soc/omap/sdp3430.c      |    4 +++-
 sound/soc/omap/zoom2.c        |    4 +++-
 11 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index be15203..5d0fb60 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -698,7 +698,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 
 	if (twl_has_codec() && pdata->codec && twl_class_is_4030()) {
 		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
-		child = add_child(sub_chip_id, "twl4030_audio",
+		child = add_child(sub_chip_id, "twl4030-audio",
 				pdata->codec, sizeof(*pdata->codec),
 				false, 0, 0);
 		if (IS_ERR(child))
diff --git a/drivers/mfd/twl4030-codec.c b/drivers/mfd/twl4030-codec.c
index e9e64e1..9a4b196 100644
--- a/drivers/mfd/twl4030-codec.c
+++ b/drivers/mfd/twl4030-codec.c
@@ -249,14 +249,14 @@ static int __devexit twl4030_codec_remove(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_ALIAS("platform:twl4030_audio");
+MODULE_ALIAS("platform:twl4030-audio");
 
 static struct platform_driver twl4030_codec_driver = {
 	.probe		= twl4030_codec_probe,
 	.remove		= __devexit_p(twl4030_codec_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
-		.name	= "twl4030_audio",
+		.name	= "twl4030-audio",
 	},
 };
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 6de90bf..4793d8a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -553,8 +553,12 @@ extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
 extern int twl4030_remove_script(u8 flags);
 
 struct twl4030_codec_audio_data {
-	unsigned int	audio_mclk;
+	unsigned int audio_mclk; /* not used, will be removed */
+	unsigned int digimic_delay; /* in ms */
 	unsigned int ramp_delay_value;
+	unsigned int offset_cncl_path;
+	unsigned int check_defaults:1;
+	unsigned int reset_registers:1;
 	unsigned int hs_extmute:1;
 	void (*set_hs_extmute)(int mute);
 };
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
index 050d81f..d296cfc 100644
--- a/sound/soc/omap/igep0020.c
+++ b/sound/soc/omap/igep0020.c
@@ -33,7 +33,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int igep2_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index 3af2c17..38cd189 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -35,7 +35,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int omap2evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index ebad1de..7c11e1a 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -33,7 +33,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index bd45f62..1ac5bab 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -31,7 +31,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int omap3evm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index f306f8f..dbd9d96 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -35,7 +35,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 #define OMAP3_PANDORA_DAC_POWER_GPIO	118
 #define OMAP3_PANDORA_AMP_POWER_GPIO	14
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index 81e284e..e95a607 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -33,7 +33,6 @@
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 static int overo_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 953abfb..76ce77b9 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -36,9 +36,11 @@
 #include <mach/gpio.h>
 #include <plat/mcbsp.h>
 
+/* Register descriptions for twl4030 codec part */
+#include <linux/mfd/twl4030-codec.h>
+
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 /* TWL4030 PMBR1 Register */
 #define TWL4030_INTBR_PMBR1		0x0D
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 0810b99..338dc95 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -32,9 +32,11 @@
 #include <mach/board-zoom.h>
 #include <plat/mcbsp.h>
 
+/* Register descriptions for twl4030 codec part */
+#include <linux/mfd/twl4030-codec.h>
+
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
-#include "../codecs/twl4030.h"
 
 #define ZOOM2_HEADSET_MUX_GPIO		(OMAP_MAX_GPIO_LINES + 15)
 
-- 
1.7.2
