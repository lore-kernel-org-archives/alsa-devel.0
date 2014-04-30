From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 5/5] ASoc: fsl_spdif: Add descriptions for
	fsl_spdif_priv
Date: Wed, 30 Apr 2014 18:54:09 +0800
Message-ID: <c17222d56dca6ff1bd32bf70dfa7715e82975f84.1398853588.git.Guangyu.Chen@freescale.com>
References: <cover.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 03F3D261AC1
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 12:52:40 +0200 (CEST)
In-Reply-To: <cover.1398853588.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Other people would clearly understand each member and improve if they want.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 074b355..b912d45 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -69,6 +69,27 @@ struct spdif_mixer_control {
 	u32 ready_buf;
 };
 
+/**
+ * fsl_spdif_priv: Freescale SPDIF private data
+ *
+ * @fsl_spdif_control: SPDIF control data
+ * @cpu_dai_drv: cpu dai driver
+ * @pdev: platform device pointer
+ * @regmap: regmap handler
+ * @dpll_locked: dpll lock flag
+ * @txrate: the best rates for playback
+ * @txclk_df: STC_TXCLK_DF dividers value for playback
+ * @sysclk_df: STC_SYSCLK_DF dividers value for playback
+ * @txclk_src: STC_TXCLK_SRC values for playback
+ * @rxclk_src: SRPC_CLKSRC_SEL values for capture
+ * @txclk: tx clock sources for playback
+ * @rxclk: rx clock sources for capture
+ * @coreclk: core clock for register access via DMA
+ * @sysclk: system clock for rx clock rate measurement
+ * @dma_params_tx: DMA parameters for transmit channel
+ * @dma_params_rx: DMA parameters for receive channel
+ * @name: driver name
+ */
 struct fsl_spdif_priv {
 	struct spdif_mixer_control fsl_spdif_control;
 	struct snd_soc_dai_driver cpu_dai_drv;
-- 
1.8.4
