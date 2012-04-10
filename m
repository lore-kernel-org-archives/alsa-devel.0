From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: wm9705: Fix build due to removal of
	'runtime' definition
Date: Tue, 10 Apr 2012 19:38:24 -0300
Message-ID: <1334097504-14729-2-git-send-email-festevam@gmail.com>
References: <1334097504-14729-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 99490104028
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:38:40 +0200 (CEST)
Received: by mail-yx0-f179.google.com with SMTP id l1so229656yen.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 15:38:40 -0700 (PDT)
In-Reply-To: <1334097504-14729-1-git-send-email-festevam@gmail.com>
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

sound/soc/codecs/wm9705.c: In function 'ac97_prepare':
sound/soc/codecs/wm9705.c:251: error: 'runtime' undeclared (first use in this function)

This was caused by commit e6968a (ASoC: codecs: Remove rtd->codec usage from CODEC drivers),
which removed the 'struct snd_pcm_runtime *runtime = substream->runtime' definition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm9705.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 7c09593..e8e782a 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -248,7 +248,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return ac97_write(codec, reg, runtime->rate);
+	return ac97_write(codec, reg, substream->runtime->rate);
 }
 
 #define WM9705_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
-- 
1.7.1
