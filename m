From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [v2,
	2/2] ASoC: AMD: Configure channel 1 or channel 0 for capture
Date: Thu, 21 Jun 2018 12:58:17 +0800
Message-ID: <1529557112-5525-2-git-send-email-akshu.agrawal@amd.com>
References: <1529557112-5525-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690068.outbound.protection.outlook.com [40.107.69.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E59322676B2
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 06:59:44 +0200 (CEST)
In-Reply-To: <1529557112-5525-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

ST/CZ SoC have 2 channels for capture in the I2SSP path.
The DMA though these channels is done using the same dma
descriptors.
We configure the channel and enable it on the basis of
channel selected by machine driver. Machine driver knows
which codec sits on which channel and thus sends the information
to dma driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Split acp_dma_cap_channel into 2 functions.

 sound/soc/amd/acp-da7219-max98357a.c | 43 +++++++++++++++++++---
 sound/soc/amd/acp-pcm-dma.c          | 71 +++++++++++++++++++++++++++++++++++-
 sound/soc/amd/acp.h                  |  4 ++
 3 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 566bd26..f42606e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -149,6 +149,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
 }
 
@@ -172,7 +173,7 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
-static int cz_dmic_startup(struct snd_pcm_substream *substream)
+static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
@@ -182,6 +183,17 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	return da7219_clk_enable(substream);
 }
 
+static int cz_dmic1_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL0;
+	return da7219_clk_enable(substream);
+}
+
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 {
 	da7219_clk_disable();
@@ -197,8 +209,13 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	.shutdown = cz_max_shutdown,
 };
 
-static const struct snd_soc_ops cz_dmic_cap_ops = {
-	.startup = cz_dmic_startup,
+static const struct snd_soc_ops cz_dmic0_cap_ops = {
+	.startup = cz_dmic0_startup,
+	.shutdown = cz_dmic_shutdown,
+};
+
+static const struct snd_soc_ops cz_dmic1_cap_ops = {
+	.startup = cz_dmic1_startup,
 	.shutdown = cz_dmic_shutdown,
 };
 
@@ -241,8 +258,9 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.ops = &cz_max_play_ops,
 	},
 	{
-		.name = "dmic",
-		.stream_name = "DMIC Capture",
+		/* C panel DMIC */
+		.name = "dmic0",
+		.stream_name = "DMIC0 Capture",
 		.platform_name = "acp_audio_dma.0.auto",
 		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
@@ -250,7 +268,20 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
-		.ops = &cz_dmic_cap_ops,
+		.ops = &cz_dmic0_cap_ops,
+	},
+	{
+		/* A/B panel DMIC */
+		.name = "dmic1",
+		.stream_name = "DMIC1 Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "adau7002-hifi",
+		.codec_name = "ADAU7002:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_capture = 1,
+		.ops = &cz_dmic1_cap_ops,
 	},
 };
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 1458b50..3c3d398 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -336,6 +336,61 @@ static void config_acp_dma(void __iomem *acp_mmio,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
+static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
+				       u16 cap_channel)
+{
+	u32 val, ch_reg, imr_reg, res_reg;
+
+	switch (cap_channel) {
+	case CAP_CHANNEL1:
+		ch_reg = mmACP_I2SMICSP_RER1;
+		res_reg = mmACP_I2SMICSP_RCR1;
+		imr_reg = mmACP_I2SMICSP_IMR1;
+		break;
+	case CAP_CHANNEL0:
+	default:
+		ch_reg = mmACP_I2SMICSP_RER0;
+		res_reg = mmACP_I2SMICSP_RCR0;
+		imr_reg = mmACP_I2SMICSP_IMR0;
+		break;
+	}
+	val = acp_reg_read(acp_mmio,
+			   mmACP_I2S_16BIT_RESOLUTION_EN);
+	if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
+		acp_reg_write(0x0, acp_mmio, ch_reg);
+		/* Set 16bit resolution on capture */
+		acp_reg_write(0x2, acp_mmio, res_reg);
+	}
+	val = acp_reg_read(acp_mmio, imr_reg);
+	val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+	val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+	acp_reg_write(val, acp_mmio, imr_reg);
+	acp_reg_write(0x1, acp_mmio, ch_reg);
+}
+
+static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
+					u16 cap_channel)
+{
+	u32 val, ch_reg, imr_reg;
+
+	switch (cap_channel) {
+	case CAP_CHANNEL1:
+		imr_reg = mmACP_I2SMICSP_IMR1;
+		ch_reg = mmACP_I2SMICSP_RER1;
+		break;
+	case CAP_CHANNEL0:
+	default:
+		imr_reg = mmACP_I2SMICSP_IMR0;
+		ch_reg = mmACP_I2SMICSP_RER0;
+		break;
+	}
+	val = acp_reg_read(acp_mmio, imr_reg);
+	val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+	val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+	acp_reg_write(val, acp_mmio, imr_reg);
+	acp_reg_write(0x0, acp_mmio, ch_reg);
+}
+
 /* Start a given DMA channel transfer */
 static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 {
@@ -773,8 +828,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	if (pinfo)
+	if (pinfo) {
 		rtd->i2s_instance = pinfo->i2s_instance;
+		rtd->capture_channel = pinfo->capture_channel;
+	}
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
@@ -990,6 +1047,18 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		} else {
+			if (rtd->capture_channel == CAP_CHANNEL0) {
+				acp_dma_cap_channel_disable(rtd->acp_mmio,
+							    CAP_CHANNEL1);
+				acp_dma_cap_channel_enable(rtd->acp_mmio,
+							   CAP_CHANNEL0);
+			}
+			if (rtd->capture_channel == CAP_CHANNEL1) {
+				acp_dma_cap_channel_disable(rtd->acp_mmio,
+							    CAP_CHANNEL0);
+				acp_dma_cap_channel_enable(rtd->acp_mmio,
+							   CAP_CHANNEL1);
+			}
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..3190fdc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -55,6 +55,8 @@
 
 #define I2S_SP_INSTANCE                 0x01
 #define I2S_BT_INSTANCE                 0x02
+#define CAP_CHANNEL0			0x00
+#define CAP_CHANNEL1			0x01
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -125,6 +127,7 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 i2s_instance;
+	u16 capture_channel;
 	u16 direction;
 	u16 ch1;
 	u16 ch2;
@@ -155,6 +158,7 @@ struct audio_drv_data {
  */
 struct acp_platform_info {
 	u16 i2s_instance;
+	u16 capture_channel;
 };
 
 union acp_dma_count {
-- 
1.9.1
