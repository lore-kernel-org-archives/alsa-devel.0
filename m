From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Configure channel 1 or channel 0
	for capture" to the asoc tree
Date: Fri, 22 Jun 2018 15:50:27 +0100
Message-ID: <E1fWNON-0002df-TP@debutante>
References: <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BFAA2676B0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 16:50:43 +0200 (CEST)
In-Reply-To: <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, djkurtz@chromium.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Configure channel 1 or channel 0 for capture

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2718c89a233bf8549fdba0925947b2c3cb887a95 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Thu, 21 Jun 2018 12:58:17 +0800
Subject: [PATCH] ASoC: AMD: Configure channel 1 or channel 0 for capture

ST/CZ SoC have 2 channels for capture in the I2SSP path.
The DMA though these channels is done using the same dma
descriptors.
We configure the channel and enable it on the basis of
channel selected by machine driver. Machine driver knows
which codec sits on which channel and thus sends the information
to dma driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 43 ++++++++++++++---
 sound/soc/amd/acp-pcm-dma.c          | 71 +++++++++++++++++++++++++++-
 sound/soc/amd/acp.h                  |  4 ++
 3 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 566bd268be3a..f42606e5879e 100644
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
@@ -197,8 +209,13 @@ static const struct snd_soc_ops cz_max_play_ops = {
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
 
@@ -241,8 +258,9 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
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
@@ -250,7 +268,20 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
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
index 1458b5048498..3c3d398d0d0b 100644
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
index 9cd3e96c84d4..3190fdce6307 100644
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
2.18.0.rc2
