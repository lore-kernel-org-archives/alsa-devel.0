From: Valentin Ilie <valentin.ilie@gmail.com>
Subject: [PATCH] ASoC: blackfin: Add missing break statement to bf6xx
Date: Sat, 14 Sep 2013 02:20:37 +0300
Message-ID: <1379114437-25090-1-git-send-email-valentin.ilie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Valentin Ilie <valentin.ilie@gmail.com>
List-Id: alsa-devel@alsa-project.org

SNDRV_PCM_FORMAT_S8 isn't supposed to fall through to SNDRV_PCM_FORMAT_S16_LE

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
---
 sound/soc/blackfin/bf6xx-i2s.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index c02405c..5810a06 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -88,6 +88,7 @@ static int bfin_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S8:
 		param.spctl |= 0x70;
 		sport->wdsize = 1;
+		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		param.spctl |= 0xf0;
 		sport->wdsize = 2;
-- 
1.7.9.5
