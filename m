From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] ASoC: tegra: Don't claim to support PCM
	pause and resume
Date: Wed,  3 Apr 2013 11:00:01 +0200
Message-ID: <1364979607-15286-3-git-send-email-lars@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-091.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id BF85E265322
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:00:58 +0200 (CEST)
In-Reply-To: <1364979607-15286-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The tegra dmaengine driver does not support pausing and resuming a DMA stream.
The tegra PCM driver still claims to support pause and resume though and
implements them by stopping and restarting the stream. This is not what an
application using pause/resume would expect. Usually applications have support
for working around PCMs which do not support suspend and resume, so don't set
the SNDRV_PCM_INFO_PAUSE and SNDRV_PCM_INFO_RESUME flags for the tegra PCM and
use the default snd_dmaengine_pcm_trigger callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/tegra/tegra_pcm.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index e67af0b..117cccc 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -43,8 +43,6 @@
 static const struct snd_pcm_hardware tegra_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME |
 				  SNDRV_PCM_INFO_INTERLEAVED,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
 	.channels_min		= 2,
@@ -121,26 +119,6 @@ static int tegra_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int tegra_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		return snd_dmaengine_pcm_trigger(substream,
-					SNDRV_PCM_TRIGGER_START);
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		return snd_dmaengine_pcm_trigger(substream,
-					SNDRV_PCM_TRIGGER_STOP);
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static int tegra_pcm_mmap(struct snd_pcm_substream *substream,
 				struct vm_area_struct *vma)
 {
@@ -158,7 +136,7 @@ static struct snd_pcm_ops tegra_pcm_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= tegra_pcm_hw_params,
 	.hw_free	= tegra_pcm_hw_free,
-	.trigger	= tegra_pcm_trigger,
+	.trigger	= snd_dmaengine_pcm_trigger,
 	.pointer	= snd_dmaengine_pcm_pointer,
 	.mmap		= tegra_pcm_mmap,
 };
-- 
1.8.0
