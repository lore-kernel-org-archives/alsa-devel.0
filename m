From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: dwc: I2S Controller instance param added
Date: Mon, 19 Mar 2018 12:05:32 +0530
Message-ID: <1521441332-18821-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0076.outbound.protection.outlook.com [104.47.36.76])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E6F267299
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 07:33:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, lgirdwood@gmail.com, Akshu.Agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

When multiple I2S controller instances created,
i2s_instance parameter refers to i2s controller instance value.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/sound/designware_i2s.h | 4 ++++
 sound/soc/dwc/dwc-i2s.c        | 1 +
 sound/soc/dwc/local.h          | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 830f5ca..2a94e7c 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -44,6 +44,10 @@ struct i2s_platform_data {
 	int channel;
 	u32 snd_fmts;
 	u32 snd_rates;
+	/* i2s_instance parameter returns I2S controller instance value
+	 * when multiple I2S controllers instantiated
+	 */
+	u32 i2s_instance;
 
 	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
 	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index e27e21f..20145c0 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -549,6 +549,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
 
 	if (dev->quirks & DW_I2S_QUIRK_16BIT_IDX_OVERRIDE)
 		idx = 1;
+	dev->i2s_instance = pdata->i2s_instance;
 	/* Set DMA slaves info */
 	dev->play_dma_data.pd.data = pdata->play_dma_data;
 	dev->capture_dma_data.pd.data = pdata->capture_dma_data;
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 91dc70a..e89e464 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -98,6 +98,7 @@ struct dw_i2s_dev {
 	u32 ccr;
 	u32 xfer_resolution;
 	u32 fifo_th;
+	u32 i2s_instance;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
-- 
2.7.4
