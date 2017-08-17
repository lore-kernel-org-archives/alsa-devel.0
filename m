From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 6/6] ASoC: qcom: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:12 +0530
Message-ID: <1502964972-22722-7-git-send-email-bhumirks@gmail.com>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is either passed as the 2nd argument
to the function snd_soc_set_runtime_hwparams, which is const or used
in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index fb3576a..e1945e1 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -32,7 +32,7 @@ struct lpass_pcm_data {
 #define LPASS_PLATFORM_BUFFER_SIZE	(16 * 1024)
 #define LPASS_PLATFORM_PERIODS		2
 
-static struct snd_pcm_hardware lpass_platform_pcm_hardware = {
+static const struct snd_pcm_hardware lpass_platform_pcm_hardware = {
 	.info			=	SNDRV_PCM_INFO_MMAP |
 					SNDRV_PCM_INFO_MMAP_VALID |
 					SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
