From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/6] ASoC: Intel: Atom: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:08 +0530
Message-ID: <1502964972-22722-3-git-send-email-bhumirks@gmail.com>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index b272df5..43e7fdd 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -76,7 +76,7 @@ int sst_unregister_dsp(struct sst_device *dev)
 }
 EXPORT_SYMBOL_GPL(sst_unregister_dsp);
 
-static struct snd_pcm_hardware sst_platform_pcm_hw = {
+static const struct snd_pcm_hardware sst_platform_pcm_hw = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_DOUBLE |
 			SNDRV_PCM_INFO_PAUSE |
-- 
1.9.1
