Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id ADF6026084B
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:52:53 +0200 (CEST)
Received: from dflxv15.itg.ti.com ([128.247.5.124])
 by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76DqqMs029194
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:52 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
 by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dqqwk023302
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dqpoq006168	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:52 -0500
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 6 Aug 2014 16:52:40 +0300
Message-ID: <6809e37af0cd57f89e5f9103ae616d51f3b06e12.1407332062.git.jsarha@ti.com>
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 3/9] drm/tilcdc: Add I2S HDMI audio config for
	tda998x
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

The configuration is needed for HDMI audio. The "swap" and "mirr"
parameters have to be correctly set in the configuration in order to
have proper colors in the HDMI picture.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_slave.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
index 595068b..e43240a 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -19,6 +19,7 @@
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/consumer.h>
 #include <drm/drm_encoder_slave.h>
+#include <drm/i2c/tda998x.h>
 
 #include "tilcdc_drv.h"
 
@@ -111,8 +112,29 @@ static const struct drm_encoder_helper_funcs slave_encoder_helper_funcs = {
 		.restore        = drm_i2c_encoder_restore,
 };
 
+static struct tda998x_encoder_params tda998x_pdata = {
+	.swap_b = 0x3,
+	.mirr_b = 0x0,
+	.swap_a = 0x2,
+	.mirr_a = 0x0,
+	.swap_d = 0x1,
+	.mirr_d = 0x0,
+	.swap_c = 0x0,
+	.mirr_c = 0x0,
+	.swap_f = 0x5,
+	.mirr_f = 0x0,
+	.swap_e = 0x4,
+	.mirr_e = 0x0,
+	.audio_cfg = 0x3,	/* I2S mode */
+	.audio_clk_cfg = 1,	/* select clock pin */
+	.audio_frame[1] = 1,	/* channels - 1 */
+	.audio_format = AFMT_I2S,
+	.audio_sample_rate = 48000,
+};
+
 static const struct i2c_board_info info = {
-		I2C_BOARD_INFO("tda998x", 0x70)
+		I2C_BOARD_INFO("tda998x", 0x70),
+		.platform_data = &tda998x_pdata,
 };
 
 static struct drm_encoder *slave_encoder_create(struct drm_device *dev,
-- 
1.7.9.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
