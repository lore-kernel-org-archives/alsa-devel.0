From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Set delay value for the capture
	case" to the asoc tree
Date: Mon,  6 Aug 2018 17:06:06 +0100 (BST)
Message-ID: <20180806160606.8E541440078@finisterre.ee.mobilebroadband>
References: <1533540439-18735-3-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9282677A2
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 18:06:08 +0200 (CEST)
In-Reply-To: <1533540439-18735-3-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Mukunda, , Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Set delay value for the capture case

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

>From c21c834adb5bc81e7081aa93ac50619c6d060506 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 6 Aug 2018 12:57:16 +0530
Subject: [PATCH] ASoC: AMD: Set delay value for the capture case

ACP->SYSMEM DMA happens at every I2S->SYSMEM period
completion. Thus, there is delay of x frames till
I2S->SYSMEM reaches a period length. This delay is
communicated to user space.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 32f27c5e4d93..e359938e3d7e 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,6 +922,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			adata->capture_i2sbt_stream = substream;
 			break;
@@ -942,6 +946,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			adata->capture_i2ssp_stream = substream;
 		}
@@ -997,7 +1005,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 pos = 0;
 	u64 bytescount = 0;
 	u16 dscr;
-	u32 period_bytes;
+	u32 period_bytes, delay;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1012,6 +1020,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 			pos = period_bytes;
 		else
 			pos = 0;
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		delay = do_div(bytescount, period_bytes);
+		runtime->delay = bytes_to_frames(runtime, delay);
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
2.18.0
