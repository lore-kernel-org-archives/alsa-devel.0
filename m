From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: memory release for rtd structure" to the asoc tree
Date: Mon, 21 May 2018 16:48:36 +0100
Message-ID: <E1fKn36-0007Jc-EB@debutante>
References: <1524741374-13523-7-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524741374-13523-7-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukunda@sirena.org.uk
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>Mark Brown <broonie@kernel.org>Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: memory release for rtd structure

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

>From cac6f59717e1084552e509172d40d5c9d278feb9 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:49 +0530
Subject: [PATCH] ASoC: amd: memory release for rtd structure

rtd structure freed early may result in kernel panic in dma close
call back. moved releasing memory for rtd structure to the end of
dma close callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 39cd54f1b493..1c44b26ad2db 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -998,8 +998,6 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
 		/*
@@ -1028,7 +1026,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
-
+	kfree(rtd);
 	return 0;
 }
 
-- 
2.17.0
