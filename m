From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCH] ASoC: Zoom2: Update twl4030_setup_data
	parameters
Date: Thu, 2 Jul 2009 19:04:07 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B5214663B@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B07524645
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 02:04:19 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add support for EXTMUTE in Zoom2 machine driver. This is necessary
to further reduce pop noise problem. Signal EXTMUTE is connected to
signal GPIO 153 in Zoom2 board.

In addition, change ramp delay value to 3 (218/161/109 ms). With
previous ramp delay value, pop noise was louder. With a longer value
the beep tone can be observed.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/omap/zoom2.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index be2e307..ec549a4 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -35,7 +35,8 @@
 #include "omap-pcm.h"
 #include "../codecs/twl4030.h"
 
-#define ZOOM2_HEADSET_MUX_GPIO	(OMAP_MAX_GPIO_LINES + 15)
+#define ZOOM2_HEADSET_MUX_GPIO		(OMAP_MAX_GPIO_LINES + 15)
+#define ZOOM2_HEADSET_EXTMUTE_GPIO	153
 
 static int zoom2_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
@@ -234,10 +235,18 @@ static struct snd_soc_card snd_soc_zoom2 = {
 	.num_links = ARRAY_SIZE(zoom2_dai),
 };
 
+/* EXTMUTE callback function */
+void zoom2_set_hs_extmute(int mute)
+{
+	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
+}
+
 /* twl4030 setup */
 static struct twl4030_setup_data twl4030_setup = {
-	.ramp_delay_value = 2,	/* 81 ms */
+	.ramp_delay_value = 3,	/* 161 ms */
 	.sysclk = 26000,
+	.hs_extmute = 1,
+	.set_hs_extmute = zoom2_set_hs_extmute,
 };
 
 /* Audio subsystem */
@@ -277,6 +286,9 @@ static int __init zoom2_soc_init(void)
 	BUG_ON(gpio_request(ZOOM2_HEADSET_MUX_GPIO, "hs_mux") < 0);
 	gpio_direction_output(ZOOM2_HEADSET_MUX_GPIO, 0);
 
+	BUG_ON(gpio_request(ZOOM2_HEADSET_EXTMUTE_GPIO, "ext_mute") < 0);
+	gpio_direction_output(ZOOM2_HEADSET_EXTMUTE_GPIO, 0);
+
 	return 0;
 
 err1:
@@ -290,6 +302,7 @@ module_init(zoom2_soc_init);
 static void __exit zoom2_soc_exit(void)
 {
 	gpio_free(ZOOM2_HEADSET_MUX_GPIO);
+	gpio_free(ZOOM2_HEADSET_EXTMUTE_GPIO);
 
 	platform_device_unregister(zoom2_snd_device);
 }
-- 
1.6.0.4
