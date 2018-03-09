From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: 16bit resolution support for i2s
	sp instance" to the asoc tree
Date: Fri, 09 Mar 2018 18:03:43 +0000
Message-ID: <E1euMMp-00021T-Ld@debutante>
References: <1520610182-13122-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 07EB426763C
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 19:03:47 +0100 (CET)
In-Reply-To: <1520610182-13122-1-git-send-email-Vijendar.Mukunda@amd.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Alexander.Deucher@amd.com, Akshu.Agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: 16bit resolution support for i2s sp instance

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

>From a37d48e32303d535bdfd554c57952ce31f428b3a Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Fri, 9 Mar 2018 21:13:02 +0530
Subject: [PATCH] ASoC: amd: 16bit resolution support for i2s sp instance

Moved 16bit resolution condition check for stoney platform
to acp_hw_params.Depending upon substream required register
value need to be programmed rather than enabling 16bit resolution
support all time in acp init.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 16 +++++++++-------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index c33a512283a4..9fb356db3ab2 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -579,13 +579,6 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 		for (bank = 1; bank < 48; bank++)
 			acp_set_sram_bank_state(acp_mmio, bank, false);
 	}
-
-	/* Stoney supports 16bit resolution */
-	if (asic_type == CHIP_STONEY) {
-		val = acp_reg_read(acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
-		val |= 0x03;
-		acp_reg_write(val, acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
-	}
 	return 0;
 }
 
@@ -774,6 +767,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	uint64_t size;
+	u32 val = 0;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
@@ -786,6 +780,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
+	if (adata->asic_type == CHIP_STONEY) {
+		val = acp_reg_read(adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+		else
+			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		acp_reg_write(val, adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+	}
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index ecb458935d1e..9293f179f272 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -70,6 +70,8 @@
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
+#define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
+#define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
-- 
2.16.2
