From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Audio buffer related changes for
	Stoney" to the asoc tree
Date: Wed, 18 Oct 2017 01:08:59 +0100
Message-ID: <E1e4but-0003z7-4j@debutante>
References: <1505325475-22602-6-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F853266AE1
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 02:11:48 +0200 (CEST)
In-Reply-To: <1505325475-22602-6-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, broonie@kernel.org, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Audio buffer related changes for Stoney

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

>From f672fc6de01de8ae3feb3fc59669a40dc8808434 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Wed, 13 Sep 2017 13:57:54 -0400
Subject: [PATCH] ASoC: AMD: Audio buffer related changes for Stoney

Stoney uses 16kb SRAM memory for playback and 16Kb
for capture.Modified Max buffer size to have the
correct mapping between System Memory and SRAM.

Added snd_pcm_hardware structures for playback
and capture for Stoney.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 83 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index f16e0b8e2ed7..73b58ee00383 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -35,6 +35,11 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
+#define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
+#define ST_MIN_BUFFER ST_MAX_BUFFER
+
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
@@ -73,6 +78,44 @@ static const struct snd_pcm_hardware acp_pcm_hardware_capture = {
 	.periods_max = CAPTURE_MAX_NUM_PERIODS,
 };
 
+static const struct snd_pcm_hardware acp_st_pcm_hardware_playback = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 1,
+	.channels_max = 8,
+	.rates = SNDRV_PCM_RATE_8000_96000,
+	.rate_min = 8000,
+	.rate_max = 96000,
+	.buffer_bytes_max = ST_MAX_BUFFER,
+	.period_bytes_min = PLAYBACK_MIN_PERIOD_SIZE,
+	.period_bytes_max = ST_PLAYBACK_MAX_PERIOD_SIZE,
+	.periods_min = PLAYBACK_MIN_NUM_PERIODS,
+	.periods_max = PLAYBACK_MAX_NUM_PERIODS,
+};
+
+static const struct snd_pcm_hardware acp_st_pcm_hardware_capture = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 1,
+	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_8000_48000,
+	.rate_min = 8000,
+	.rate_max = 48000,
+	.buffer_bytes_max = ST_MAX_BUFFER,
+	.period_bytes_min = CAPTURE_MIN_PERIOD_SIZE,
+	.period_bytes_max = ST_CAPTURE_MAX_PERIOD_SIZE,
+	.periods_min = CAPTURE_MIN_NUM_PERIODS,
+	.periods_max = CAPTURE_MAX_NUM_PERIODS,
+};
+
 static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
 {
 	return readl(acp_mmio + (reg * 4));
@@ -664,10 +707,23 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	if (adata == NULL)
 		return -ENOMEM;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		runtime->hw = acp_pcm_hardware_playback;
-	else
-		runtime->hw = acp_pcm_hardware_capture;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (intr_data->asic_type) {
+		case CHIP_STONEY:
+			runtime->hw = acp_st_pcm_hardware_playback;
+			break;
+		default:
+			runtime->hw = acp_pcm_hardware_playback;
+		}
+	} else {
+		switch (intr_data->asic_type) {
+		case CHIP_STONEY:
+			runtime->hw = acp_st_pcm_hardware_capture;
+			break;
+		default:
+			runtime->hw = acp_pcm_hardware_capture;
+		}
+	}
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
@@ -905,10 +961,27 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 
 static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
-	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+	int ret;
+	struct audio_drv_data *adata = dev_get_drvdata(rtd->platform->dev);
+
+	switch (adata->asic_type) {
+	case CHIP_STONEY:
+		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+							SNDRV_DMA_TYPE_DEV,
+							NULL, ST_MIN_BUFFER,
+							ST_MAX_BUFFER);
+		break;
+	default:
+		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							SNDRV_DMA_TYPE_DEV,
 							NULL, MIN_BUFFER,
 							MAX_BUFFER);
+		break;
+	}
+	if (ret < 0)
+		dev_err(rtd->platform->dev,
+				"buffer preallocation failer error:%d\n", ret);
+	return ret;
 }
 
 static int acp_dma_close(struct snd_pcm_substream *substream)
-- 
2.14.1
