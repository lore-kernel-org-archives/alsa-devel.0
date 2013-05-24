From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 6/6] ASoC: ux500: Drop redundant msp id enumerations
Date: Fri, 24 May 2013 12:39:20 +0200
Message-ID: <1369391960-27320-7-git-send-email-fabio.baltieri@linaro.org>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

Ux500 has two equivalent enum for device id, one in platform_data and
one in a local header.  Fix this by dropping the local one.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index d5e4176..189a375 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -16,6 +16,7 @@
 #define UX500_MSP_I2S_H
 
 #include <linux/platform_device.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #define MSP_INPUT_FREQ_APB 48000000
 
@@ -365,13 +366,6 @@ enum msp_protocol {
  */
 #define MAX_MSP_BACKUP_REGS 36
 
-enum enum_i2s_controller {
-	MSP_0_I2S_CONTROLLER = 0,
-	MSP_1_I2S_CONTROLLER,
-	MSP_2_I2S_CONTROLLER,
-	MSP_3_I2S_CONTROLLER,
-};
-
 enum i2s_direction_t {
 	MSP_DIR_TX = 0x01,
 	MSP_DIR_RX = 0x02,
@@ -475,7 +469,7 @@ struct ux500_msp_config {
 };
 
 struct ux500_msp {
-	enum enum_i2s_controller id;
+	enum msp_i2s_id id;
 	void __iomem *registers;
 	struct device *dev;
 	struct stedma40_chan_cfg *dma_cfg_rx;
-- 
1.8.2
