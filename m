From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH v2 1/3] ASoC: dwc: I2S Controller instance
	param added
Date: Wed, 18 Apr 2018 16:34:52 +0530
Message-ID: <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0047.outbound.protection.outlook.com [104.47.41.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E2FF267608
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 13:02:35 +0200 (CEST)
In-Reply-To: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

When multiple I2S controller instances created,
i2s_instance parameter refers to i2s controller instance value.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 v1->v2: removed acp dma driver specific macros from dwc header file
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
index 65112b9..58f81a4 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -553,6 +553,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
 
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
