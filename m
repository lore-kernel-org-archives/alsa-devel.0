From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 15/15] sound/soc: imx: check kzalloc() result and fix memory leak
Date: Fri, 16 Jul 2010 20:16:54 +0400
Message-ID: <1279297014-25347-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If kzalloc() fails we must exit with -ENOMEM. Also we must free
allocated runtime->private_data on error as it would be lost on next
call to snd_imx_open().

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/soc/imx/imx-pcm-fiq.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 6b518e0..b2bf272 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -192,6 +192,8 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	int ret;
 
 	iprtd = kzalloc(sizeof(*iprtd), GFP_KERNEL);
+	if (iprtd == NULL)
+		return -ENOMEM;
 	runtime->private_data = iprtd;
 
 	iprtd->substream = substream;
@@ -202,8 +204,10 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 
 	ret = snd_pcm_hw_constraint_integer(substream->runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(iprtd);
 		return ret;
+	}
 
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 	return 0;
-- 
1.7.0.4
