From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 01/11] ARM: ux500: Don't use enums for MSP IDs
	- for easy DT conversion
Date: Thu, 19 Dec 2013 15:54:58 +0000
Message-ID: <1387468508-12286-2-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 91D3A2654A4
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 16:55:29 +0100 (CET)
Received: by mail-wg0-f41.google.com with SMTP id y10so5871807wgg.4
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 07:55:29 -0800 (PST)
In-Reply-To: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, broonie@kernel.org, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-audio.c     | 8 ++++----
 include/linux/platform_data/asoc-ux500-msp.h | 9 +--------
 sound/soc/ux500/ux500_msp_i2s.h              | 2 +-
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 154e15f..43d6cb8 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -31,7 +31,7 @@ static struct stedma40_chan_cfg msp0_dma_tx = {
 };
 
 struct msp_i2s_platform_data msp0_platform_data = {
-	.id = MSP_I2S_0,
+	.id = 0,
 	.msp_i2s_dma_rx = &msp0_dma_rx,
 	.msp_i2s_dma_tx = &msp0_dma_tx,
 };
@@ -49,7 +49,7 @@ static struct stedma40_chan_cfg msp1_dma_tx = {
 };
 
 struct msp_i2s_platform_data msp1_platform_data = {
-	.id = MSP_I2S_1,
+	.id = 1,
 	.msp_i2s_dma_rx = NULL,
 	.msp_i2s_dma_tx = &msp1_dma_tx,
 };
@@ -69,13 +69,13 @@ static struct stedma40_chan_cfg msp2_dma_tx = {
 };
 
 struct msp_i2s_platform_data msp2_platform_data = {
-	.id = MSP_I2S_2,
+	.id = 2,
 	.msp_i2s_dma_rx = &msp2_dma_rx,
 	.msp_i2s_dma_tx = &msp2_dma_tx,
 };
 
 struct msp_i2s_platform_data msp3_platform_data = {
-	.id		= MSP_I2S_3,
+	.id		= 3,
 	.msp_i2s_dma_rx	= &msp1_dma_rx,
 	.msp_i2s_dma_tx	= NULL,
 };
diff --git a/include/linux/platform_data/asoc-ux500-msp.h b/include/linux/platform_data/asoc-ux500-msp.h
index 9991aea..2f34bb9 100644
--- a/include/linux/platform_data/asoc-ux500-msp.h
+++ b/include/linux/platform_data/asoc-ux500-msp.h
@@ -10,16 +10,9 @@
 
 #include <linux/platform_data/dma-ste-dma40.h>
 
-enum msp_i2s_id {
-	MSP_I2S_0 = 0,
-	MSP_I2S_1,
-	MSP_I2S_2,
-	MSP_I2S_3,
-};
-
 /* Platform data structure for a MSP I2S-device */
 struct msp_i2s_platform_data {
-	enum msp_i2s_id id;
+	int id;
 	struct stedma40_chan_cfg *msp_i2s_dma_rx;
 	struct stedma40_chan_cfg *msp_i2s_dma_tx;
 };
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 258d0bce..875de0f 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -475,7 +475,7 @@ struct ux500_msp_dma_params {
 };
 
 struct ux500_msp {
-	enum msp_i2s_id id;
+	int id;
 	void __iomem *registers;
 	struct device *dev;
 	struct ux500_msp_dma_params playback_dma_data;
-- 
1.8.3.2
