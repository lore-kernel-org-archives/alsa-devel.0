From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Added asic_type as ACP DMA driver
	platform data" to the asoc tree
Date: Wed, 18 Oct 2017 01:09:26 +0100
Message-ID: <E1e4bvK-00044M-VU@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DE23B266AE1
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 02:11:37 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Added asic_type as ACP DMA driver platform data

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 01a6b1634d50dba65133a89fe19f182173bb8e8f Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 9 Oct 2017 16:36:08 -0400
Subject: [PATCH] ASoC: AMD: Added asic_type as ACP DMA driver platform data

asic_type information is passed to ACP DMA Driver as platform data.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 8 ++------
 sound/soc/amd/acp.h         | 7 +++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 08b1399d1da2..dcbf9973884d 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -73,12 +73,6 @@ static const struct snd_pcm_hardware acp_pcm_hardware_capture = {
 	.periods_max = CAPTURE_MAX_NUM_PERIODS,
 };
 
-struct audio_drv_data {
-	struct snd_pcm_substream *play_stream;
-	struct snd_pcm_substream *capture_stream;
-	void __iomem *acp_mmio;
-};
-
 static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
 {
 	return readl(acp_mmio + (reg * 4));
@@ -916,6 +910,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	int status;
 	struct audio_drv_data *audio_drv_data;
 	struct resource *res;
+	const u32 *pdata = pdev->dev.platform_data;
 
 	audio_drv_data = devm_kzalloc(&pdev->dev, sizeof(struct audio_drv_data),
 					GFP_KERNEL);
@@ -932,6 +927,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_stream = NULL;
 	audio_drv_data->capture_stream = NULL;
+	audio_drv_data->asic_type =  *pdata;
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 330832ef4e5e..28cf9140f49c 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -84,6 +84,13 @@ struct audio_substream_data {
 	void __iomem *acp_mmio;
 };
 
+struct audio_drv_data {
+	struct snd_pcm_substream *play_stream;
+	struct snd_pcm_substream *capture_stream;
+	void __iomem *acp_mmio;
+	u32 asic_type;
+};
+
 enum {
 	ACP_TILE_P1 = 0,
 	ACP_TILE_P2,
-- 
2.14.1
