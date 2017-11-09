From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] ASoC: amd: Modified DMA transfer Mechanism for
	Playback
Date: Thu,  9 Nov 2017 12:35:52 -0500
Message-ID: <20171109173552.21438-2-alexander.deucher@amd.com>
References: <20171109173552.21438-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0294A26783F
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 18:36:02 +0100 (CET)
Received: by mail-qt0-f193.google.com with SMTP id y45so2492737qty.6
 for <alsa-devel@alsa-project.org>; Thu, 09 Nov 2017 09:36:02 -0800 (PST)
In-Reply-To: <20171109173552.21438-1-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
Cc: tiwai@suse.de, Alex Deucher <alexander.deucher@amd.com>, lgirdwood@gmail.com, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Before rendering starts, DMA driver copies full buffer valid data
to ACP SRAM for the first time, after that ACP SRAM to I2S
FIFO DMA will be initiated. After rendering first half of ACP SRAM,
IOC will be raised then Audio data will be copied from first half of
System Memory to first half of ACP SRAM. Similarly after rendering
second half of ACP SRAM, IOC will be raised then Audio Data will be
copied from second half of the System Memory to second half of the
ACP SRAM in ping-pong way till rendering stops.

Old design introducing latency issues resulting stutter sound observed
during playback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <Akshu.Agrawal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ef7e98ad960c..9f521a55d610 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -193,8 +193,8 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12 + i;
-			dmadscr[i].dest = ACP_SHARED_RAM_BANK_1_ADDRESS +
-					(size / 2) - (i * (size/2));
+			dmadscr[i].dest = ACP_SHARED_RAM_BANK_1_ADDRESS
+					+ (i * (size/2));
 			dmadscr[i].src = ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS
 				+ (pte_offset * SZ_4K) + (i * (size/2));
 			switch (asic_type) {
@@ -655,9 +655,9 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_13) ==
 				PLAYBACK_START_DMA_DESCR_CH13)
-			dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-		else
 			dscr_idx = PLAYBACK_END_DMA_DESCR_CH12;
+		else
+			dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 		config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_CH_NUM, dscr_idx,
 				       1, 0);
 		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
@@ -882,23 +882,6 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
 					PLAYBACK_START_DMA_DESCR_CH13,
 					NUM_DSCRS_PER_CHANNEL, 0);
-		/* Fill ACP SRAM (2 periods) with zeros from System RAM
-		 * which is zero-ed in hw_params
-		*/
-		acp_dma_start(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
-
-		/* ACP SRAM (2 periods of buffer size) is intially filled with
-		 * zeros. Before rendering starts, 2nd half of SRAM will be
-		 * filled with valid audio data DMA'ed from first half of system
-		 * RAM and 1st half of SRAM will be filled with Zeros. This is
-		 * the initial scenario when redering starts from SRAM. Later
-		 * on, 2nd half of system memory will be DMA'ed to 1st half of
-		 * SRAM, 1st half of system memory will be DMA'ed to 2nd half of
-		 * SRAM in ping-pong way till rendering stops.
-		*/
-		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH12,
-					1, 0);
 	} else {
 		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
 					CAPTURE_START_DMA_DESCR_CH14,
@@ -913,7 +896,7 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
-	u32 loops = 1000;
+	u32 loops = 4000;
 	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
-- 
2.13.6
