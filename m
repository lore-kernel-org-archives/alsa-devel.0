From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: ac97: Fix build due to removal of
	'runtime' definition
Date: Tue, 10 Apr 2012 19:38:23 -0300
Message-ID: <1334097504-14729-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AEF9104028
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:38:38 +0200 (CEST)
Received: by yenl1 with SMTP id l1so229656yen.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 15:38:37 -0700 (PDT)
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

sound/soc/codecs/ac97.c: In function 'ac97_prepare':
sound/soc/codecs/ac97.c:33: error: 'runtime' undeclared (first use in this function)

This was caused by commit e6968a (ASoC: codecs: Remove rtd->codec usage from CODEC drivers),
which removed the 'struct snd_pcm_runtime *runtime = substream->runtime' definition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/ac97.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index a99a1b3..2023c74 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -30,7 +30,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 
 	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
-	return snd_ac97_set_rate(codec->ac97, reg, runtime->rate);
+	return snd_ac97_set_rate(codec->ac97, reg, substream->runtime->rate);
 }
 
 #define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-- 
1.7.1
