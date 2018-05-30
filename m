From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ASoC: core: Fix return code shown on error for hw_params
Date: Wed, 30 May 2018 16:12:58 +0100
Message-ID: <1527693178-5038-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The call to hw_params for a component fails the error code is held by
the variable '__ret' but the error message displays the value held by
the variable 'ret'. Fix the return code shown when hw_params fails for
a component.

Fixes: b8135864d4d3 ("ASoC: snd_soc_component_driver has snd_pcm_ops")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2df4719a84db..9376eb476364 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -956,7 +956,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		if (__ret < 0) {
 			dev_err(component->dev,
 				"ASoC: %s hw params failed: %d\n",
-				component->name, ret);
+				component->name, __ret);
 			ret = __ret;
 		}
 	}
-- 
2.7.4
