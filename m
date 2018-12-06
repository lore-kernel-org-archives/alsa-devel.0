From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use dma_ops of parent device for acp_audio_dma" to the asoc tree
Date: Thu,  6 Dec 2018 20:26:04 +0000 (GMT)
Message-ID: <20181206202604.3B4DD11252F7@debutante.sirena.org.uk>
References: <20181204224253.216075-2-yuzhao@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204224253.216075-2-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Zhao <yuzhao@google.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use dma_ops of parent device for acp_audio_dma

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

>From 23aa128bb28d9da69bb1bdb2b70e50128857884a Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 4 Dec 2018 15:42:53 -0700
Subject: [PATCH] ASoC: use dma_ops of parent device for acp_audio_dma

AMD platform device acp_audio_dma can only be created by parent PCI
device driver (drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c). Pass struct
device of the parent to snd_pcm_lib_preallocate_pages() so
dma_alloc_coherent() can use correct dma_ops. Otherwise, it will
use default dma_ops which is nommu_dma_ops on x86_64 even when
IOMMU is enabled and set to non passthrough mode.

Though platform device inherits some dma related fields during its
creation in mfd_add_device(), we can't simply pass its struct device
to snd_pcm_lib_preallocate_pages() because dma_ops is not among the
inherited fields. Even it were, drivers/iommu/amd_iommu.c would
ignore it because get_device_id() doesn't handle platform device.

This change shouldn't give us any trouble even struct device of the
parent becomes null or represents some non PCI device in the future,
because get_dma_ops() correctly handles null struct device or uses
the default dma_ops if struct device doesn't have it set.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index fd3db4c37882..f4011bebc7ec 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1146,18 +1146,21 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct device *parent = component->dev->parent;
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    NULL, ST_MIN_BUFFER,
+							    parent,
+							    ST_MIN_BUFFER,
 							    ST_MAX_BUFFER);
 		break;
 	default:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    NULL, MIN_BUFFER,
+							    parent,
+							    MIN_BUFFER,
 							    MAX_BUFFER);
 		break;
 	}
-- 
2.19.0.rc2
