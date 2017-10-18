From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: disabling memory gating in stoney
	platform" to the asoc tree
Date: Wed, 18 Oct 2017 01:09:05 +0100
Message-ID: <E1e4buz-00041q-5b@debutante>
References: <1501270294-31153-6-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DC302673C2
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 02:11:54 +0200 (CEST)
In-Reply-To: <1501270294-31153-6-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, amd-gfx@lists.freedesktop.org, rajeevkumar.linux@gmail.com, broonie@kernel.org, dri-devel@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: disabling memory gating in stoney platform

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

>From 4fe4d93c8eb8a823f295f80ff28c7d0bd2f4458e Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Wed, 13 Sep 2017 13:57:52 -0400
Subject: [PATCH] ASoC: AMD: disabling memory gating in stoney platform

For Stoney platform, Memory gating is disabled.i.e SRAM Banks
won't be turned off. By Default, SRAM Bank state set to ON.
Added condition checks to skip SRAM Bank state set logic for
Stoney platform.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 79 +++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index dcbf9973884d..f00b6b92e076 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -20,7 +20,7 @@
 #include <linux/pm_runtime.h>
 
 #include <sound/soc.h>
-
+#include <drm/amd_asic_type.h>
 #include "acp.h"
 
 #define PLAYBACK_MIN_NUM_PERIODS    2
@@ -419,7 +419,7 @@ static void acp_set_sram_bank_state(void __iomem *acp_mmio, u16 bank,
 }
 
 /* Initialize and bring ACP hardware to default state. */
-static int acp_init(void __iomem *acp_mmio)
+static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 {
 	u16 bank;
 	u32 val, count, sram_pte_offset;
@@ -493,9 +493,14 @@ static int acp_init(void __iomem *acp_mmio)
        /* When ACP_TILE_P1 is turned on, all SRAM banks get turned on.
 	* Now, turn off all of them. This can't be done in 'poweron' of
 	* ACP pm domain, as this requires ACP to be initialized.
+	* For Stoney, Memory gating is disabled,i.e SRAM Banks
+	* won't be turned off. The default state for SRAM banks is ON.
+	* Setting SRAM bank state code skipped for STONEY platform.
 	*/
-	for (bank = 1; bank < 48; bank++)
-		acp_set_sram_bank_state(acp_mmio, bank, false);
+	if (asic_type != CHIP_STONEY) {
+		for (bank = 1; bank < 48; bank++)
+			acp_set_sram_bank_state(acp_mmio, bank, false);
+	}
 
 	return 0;
 }
@@ -646,14 +651,22 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		intr_data->play_stream = substream;
-		for (bank = 1; bank <= 4; bank++)
-			acp_set_sram_bank_state(intr_data->acp_mmio, bank,
-						true);
+		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		 * won't be turned off. The default state for SRAM banks is ON.
+		 * Setting SRAM bank state code skipped for STONEY platform.
+		 */
+		if (intr_data->asic_type != CHIP_STONEY) {
+			for (bank = 1; bank <= 4; bank++)
+				acp_set_sram_bank_state(intr_data->acp_mmio,
+							bank, true);
+		}
 	} else {
 		intr_data->capture_stream = substream;
-		for (bank = 5; bank <= 8; bank++)
-			acp_set_sram_bank_state(intr_data->acp_mmio, bank,
-						true);
+		if (intr_data->asic_type != CHIP_STONEY) {
+			for (bank = 5; bank <= 8; bank++)
+				acp_set_sram_bank_state(intr_data->acp_mmio,
+							bank, true);
+		}
 	}
 
 	return 0;
@@ -869,14 +882,23 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_stream = NULL;
-		for (bank = 1; bank <= 4; bank++)
-			acp_set_sram_bank_state(adata->acp_mmio, bank,
-						false);
-	} else {
+		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		 * won't be turned off. The default state for SRAM banks is ON.
+		 * Setting SRAM bank state code skipped for STONEY platform.
+		 * added condition checks for Carrizo platform only
+		 */
+		if (adata->asic_type != CHIP_STONEY) {
+			for (bank = 1; bank <= 4; bank++)
+				acp_set_sram_bank_state(adata->acp_mmio, bank,
+				false);
+		}
+	} else  {
 		adata->capture_stream = NULL;
-		for (bank = 5; bank <= 8; bank++)
-			acp_set_sram_bank_state(adata->acp_mmio, bank,
-						false);
+		if (adata->asic_type != CHIP_STONEY) {
+			for (bank = 5; bank <= 8; bank++)
+				acp_set_sram_bank_state(adata->acp_mmio, bank,
+						     false);
+		}
 	}
 
 	/* Disable ACP irq, when the current stream is being closed and
@@ -945,7 +967,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, audio_drv_data);
 
 	/* Initialize the ACP */
-	acp_init(audio_drv_data->acp_mmio);
+	acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
 
 	status = snd_soc_register_platform(&pdev->dev, &acp_asoc_platform);
 	if (status != 0) {
@@ -976,19 +998,27 @@ static int acp_pcm_resume(struct device *dev)
 	u16 bank;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_init(adata->acp_mmio);
+	acp_init(adata->acp_mmio, adata->asic_type);
 
 	if (adata->play_stream && adata->play_stream->runtime) {
-		for (bank = 1; bank <= 4; bank++)
-			acp_set_sram_bank_state(adata->acp_mmio, bank,
+		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		 * won't be turned off. The default state for SRAM banks is ON.
+		 * Setting SRAM bank state code skipped for STONEY platform.
+		 */
+		if (adata->asic_type != CHIP_STONEY) {
+			for (bank = 1; bank <= 4; bank++)
+				acp_set_sram_bank_state(adata->acp_mmio, bank,
 						true);
+		}
 		config_acp_dma(adata->acp_mmio,
 				adata->play_stream->runtime->private_data);
 	}
 	if (adata->capture_stream && adata->capture_stream->runtime) {
-		for (bank = 5; bank <= 8; bank++)
-			acp_set_sram_bank_state(adata->acp_mmio, bank,
+		if (adata->asic_type != CHIP_STONEY) {
+			for (bank = 5; bank <= 8; bank++)
+				acp_set_sram_bank_state(adata->acp_mmio, bank,
 						true);
+		}
 		config_acp_dma(adata->acp_mmio,
 				adata->capture_stream->runtime->private_data);
 	}
@@ -1009,7 +1039,7 @@ static int acp_pcm_runtime_resume(struct device *dev)
 {
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_init(adata->acp_mmio);
+	acp_init(adata->acp_mmio, adata->asic_type);
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
@@ -1031,6 +1061,7 @@ static struct platform_driver acp_dma_driver = {
 
 module_platform_driver(acp_dma_driver);
 
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
 MODULE_DESCRIPTION("AMD ACP PCM Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.14.1
