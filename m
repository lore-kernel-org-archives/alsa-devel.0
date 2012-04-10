From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: wm9712: Fix build due to removal of
	'runtime' definition
Date: Tue, 10 Apr 2012 19:12:19 -0300
Message-ID: <1334095939-32233-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CE7C1103D92
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:12:34 +0200 (CEST)
Received: by yenl1 with SMTP id l1so221111yen.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 15:12:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix the following build error:

sound/soc/codecs/wm9712.c:482:32: error: 'runtime' undeclared (first use in this function)
sound/soc/codecs/wm9712.c:499:33: error: 'runtime' undeclared (first use in this function)

This was caused by commit e6968a (ASoC: codecs: Remove rtd->codec usage from CODEC drivers),
which removed the 'struct snd_pcm_runtime *runtime = substream->runtime' definition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
 sound/soc/codecs/wm9712.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 2603863..eee8170 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -479,7 +479,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return ac97_write(codec, reg, runtime->rate);
+	return ac97_write(codec, reg, substream->runtime->rate);
 }
 
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
@@ -496,7 +496,8 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 
-	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE,
+					substream->runtime->rate);
 }
 
 #define WM9712_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-- 
1.7.1
