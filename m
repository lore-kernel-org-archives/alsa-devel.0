From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Send correct channel for configuring DMA descriptors" to the asoc tree
Date: Mon, 16 Jul 2018 15:30:30 +0100
Message-ID: <E1ff4WE-0005U2-7q@debutante>
References: <1531724566-4019-1-git-send-email-akshu.agrawal@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531724566-4019-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.orgMark Brown <broonie@kernel.org>, "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Send correct channel for configuring DMA descriptors

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

>From fa9d2f17c23fb3ea6b659b1bfe4ca10551a19e56 Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Mon, 16 Jul 2018 15:02:40 +0800
Subject: [PATCH] ASoC: AMD: Send correct channel for configuring DMA
 descriptors

Earlier, ch1 was used to define ACP-SYSMEM transfer and ch2 for
ACP-I2S transfer. With recent patches ch1 is used to define channel
order number 1 and ch2 as channel order number 2. Thus,
Playback:
ch1:SYSMEM->ACP
ch2:ACP->I2S
Capture:
ch1:I2S->ACP
ch1:ACP->SYSMEM

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 65c1033bd51c..eeb867767252 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -322,17 +322,27 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
+	u16 ch_acp_sysmem, ch_acp_i2s;
+
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       rtd->pte_offset);
+
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_acp_sysmem = rtd->ch1;
+		ch_acp_i2s = rtd->ch2;
+	} else {
+		ch_acp_i2s = rtd->ch1;
+		ch_acp_sysmem = rtd->ch2;
+	}
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->pte_offset,
-				       rtd->ch1, rtd->sram_bank,
+				       ch_acp_sysmem, rtd->sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->sram_bank,
-				       rtd->destination, rtd->ch2,
+				       rtd->destination, ch_acp_i2s,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
@@ -995,16 +1005,24 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
+	u16 ch_acp_sysmem, ch_acp_i2s;
 
 	if (!rtd)
 		return -EINVAL;
 
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_acp_sysmem = rtd->ch1;
+		ch_acp_i2s = rtd->ch2;
+	} else {
+		ch_acp_i2s = rtd->ch1;
+		ch_acp_sysmem = rtd->ch2;
+	}
 	config_acp_dma_channel(rtd->acp_mmio,
-			       rtd->ch1,
+			       ch_acp_sysmem,
 			       rtd->dma_dscr_idx_1,
 			       NUM_DSCRS_PER_CHANNEL, 0);
 	config_acp_dma_channel(rtd->acp_mmio,
-			       rtd->ch2,
+			       ch_acp_i2s,
 			       rtd->dma_dscr_idx_2,
 			       NUM_DSCRS_PER_CHANNEL, 0);
 	return 0;
-- 
2.18.0.rc2
