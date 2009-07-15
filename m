From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCH] ASoC: SDP3430: Add support for EXTMUTE using
	TWL GPIO6
Date: Tue, 14 Jul 2009 20:04:08 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id F1FCE243A1
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 03:04:18 +0200 (CEST)
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

Board sdp3430 has hardware support for EXTMUTE using TWL4030 GPIO6
line, controlled by register INTBR_PMBR1. Machine driver takes care
of enabling gpio line through i2c and codec driver manipulates the
line during headset ramp up/down sequence.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/omap/sdp3430.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index c51594d..f7e5b74 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -24,6 +24,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -39,6 +40,9 @@
 #include "omap-pcm.h"
 #include "../codecs/twl4030.h"
 
+#define TWL4030_INTBR_PMBR1	0x0D
+#define EXTMUTE(value)		(value << 2)
+
 static struct snd_soc_card snd_soc_sdp3430;
 
 static int sdp3430_hw_params(struct snd_pcm_substream *substream,
@@ -280,6 +284,7 @@ static struct snd_soc_card snd_soc_sdp3430 = {
 static struct twl4030_setup_data twl4030_setup = {
 	.ramp_delay_value = 3,
 	.sysclk = 26000,
+	.hs_extmute = 1,
 };
 
 /* Audio subsystem */
@@ -312,6 +317,10 @@ static int __init sdp3430_soc_init(void)
 	*(unsigned int *)sdp3430_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
 	*(unsigned int *)sdp3430_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
 
+	/* Set TWL4030 GPIO6 as EXTMUTE signal */
+	twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
+							TWL4030_MODULE_INTBR);
+
 	ret = platform_device_add(sdp3430_snd_device);
 	if (ret)
 		goto err1;
-- 
1.6.0.4
