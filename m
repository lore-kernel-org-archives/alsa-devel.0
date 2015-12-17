From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: fix VAG power up timing
Date: Thu, 17 Dec 2015 11:07:23 +0100
Message-ID: <1450346843-6700-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: fbrozovic@gmail.com, alexander.stein@systec-electronic.com, eric.nelson@boundarydevices.com, gianlucarenzi@eurekelettronica.it, lars@metafoo.de, tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
List-Id: alsa-devel@alsa-project.org

When power up, a "pop" is heard on line-in and mic-in.
An analysis of the PCM shows it lasts ~400ms
and looks like a filter response.
VAG power up should be delayed by 400ms as VAG power down is.

Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
---
 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index f540f82..08b4046 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -189,6 +189,7 @@ static int power_vag_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
+		msleep(400);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-- 
2.6.4
