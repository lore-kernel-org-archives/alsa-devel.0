From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Always stop ch2 first" to the asoc tree
Date: Tue, 03 Jul 2018 16:34:22 +0100
Message-ID: <E1faNJu-0003oT-09@debutante>
References: <20180702211956.149355-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>, Akshu Agrawal <akshu.agrawal@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Always stop ch2 first

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

>From 30896d3619bd80486a3f8a75d62ea3b58fc61ad5 Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:50 -0600
Subject: [PATCH] ASoC: AMD: Always stop ch2 first

Commit 6b116dfb4633a ("ASoC: AMD: make channel 1 dma as circular") made
both channels circular, so this comment and logic no longer applies.  Always
stop ch2 (the channel closest to the output) before ch1.  This ensures
that the downstream circular DMA channel does not continue to play/capture
repeated samples after the upstream circular DMA channel has already
stopped.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3c3d398d0d0b..4665ae12e74e 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1067,21 +1067,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* For playback, non circular dma should be stopped first
-		 * i.e Sysram to acp dma transfer channel(rtd->ch1) should be
-		 * stopped before stopping cirular dma which is acp sram to i2s
-		 * fifo dma transfer channel(rtd->ch2). Where as in Capture
-		 * scenario, i2s fifo to acp sram dma channel(rtd->ch2) stopped
-		 * first before stopping acp sram to sysram which is circular
-		 * dma(rtd->ch1).
-		 */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-		} else {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-		}
+		acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+		ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		rtd->bytescount = 0;
 		break;
 	default:
-- 
2.18.0.rc2
