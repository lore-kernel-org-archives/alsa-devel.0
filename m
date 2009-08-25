From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCH] ASoC: SDP3430: Fix TWL GPIO6 pin mux request
Date: Mon, 24 Aug 2009 19:04:50 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B72A1D4E3@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id BF46C24451
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 02:05:01 +0200 (CEST)
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

Fix the write to PMBR1 register through I2C. Also, the constant which
holds the value to write is now called TWL4030_GPIO6_PWM0_MUTE. This
name is based on TRM to avoid confusion.
 
Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/omap/sdp3430.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)
 
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index f7e5b74..7ad99d2 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -40,8 +40,10 @@
 #include "omap-pcm.h"
 #include "../codecs/twl4030.h"
 
-#define TWL4030_INTBR_PMBR1 0x0D
-#define EXTMUTE(value)  (value << 2)
+/* TWL4030 PMBR1 Register */
+#define TWL4030_INTBR_PMBR1  0x0D
+/* TWL4030 PMBR1 Register GPIO6 mux bit */
+#define TWL4030_GPIO6_PWM0_MUTE(value) (value << 2)
 
 static struct snd_soc_card snd_soc_sdp3430;
 
@@ -299,6 +301,7 @@ static struct platform_device *sdp3430_snd_device;
 static int __init sdp3430_soc_init(void)
 {
  int ret;
+ u8 pin_mux;
 
  if (!machine_is_omap_3430sdp()) {
   pr_debug("Not SDP3430!\n");
@@ -318,8 +321,12 @@ static int __init sdp3430_soc_init(void)
  *(unsigned int *)sdp3430_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
 
  /* Set TWL4030 GPIO6 as EXTMUTE signal */
- twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
-       TWL4030_MODULE_INTBR);
+ twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
+      TWL4030_INTBR_PMBR1);
+ pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x3);
+ pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x2);
+ twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
+      TWL4030_INTBR_PMBR1);
 
  ret = platform_device_add(sdp3430_snd_device);
  if (ret)
-- 
1.6.0.4
