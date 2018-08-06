From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Modified DMA pointer for capture"
	to the asoc tree
Date: Mon,  6 Aug 2018 17:06:14 +0100 (BST)
Message-ID: <20180806160614.EEA7E440078@finisterre.ee.mobilebroadband>
References: <1533540439-18735-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 75446267857
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 18:06:17 +0200 (CEST)
In-Reply-To: <1533540439-18735-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mukunda@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, djkurtz@chromium.org, akshu.agrawal@amd.com, Mark Brown <broonie@kernel.org>, "Mukunda, ,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Modified DMA pointer for capture

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

>From 662fb3efe7ee835f0eeba6bc63b81e82a97fc312 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Mon, 6 Aug 2018 12:57:15 +0530
Subject: [PATCH] ASoC: AMD: Modified DMA pointer for capture

Give position on ACP->SYSMEM DMA channel for
the number of bytes that have been transferred on
the basis of current descriptor under service.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 31 ++++++++++++++++++-------------
 sound/soc/amd/acp.h         |  1 +
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 816abd65a6ed..32f27c5e4d93 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,10 +922,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -945,10 +942,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -1002,6 +996,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 buffersize;
 	u32 pos = 0;
 	u64 bytescount = 0;
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1009,11 +1005,20 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	if (!rtd)
 		return -EINVAL;
 
-	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		period_bytes = frames_to_bytes(runtime, runtime->period_size);
+		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+		if (dscr == rtd->dma_dscr_idx_1)
+			pos = period_bytes;
+		else
+			pos = 0;
+	} else {
+		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		pos = do_div(bytescount, buffersize);
+	}
 	return bytes_to_frames(runtime, pos);
 }
 
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0a2240bff62e..be3963e8f4fa 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -138,6 +138,7 @@ struct audio_substream_data {
 	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
+	u32 dma_curr_dscr;
 	uint64_t size;
 	u64 bytescount;
 	void __iomem *acp_mmio;
-- 
2.18.0
