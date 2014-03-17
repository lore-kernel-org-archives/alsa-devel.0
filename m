From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Turn power off only once.
Date: Mon, 17 Mar 2014 09:31:31 +0200
Message-ID: <1395041491-22152-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Regulator code keep count of enables and disables. Double disable
causes an ugly warning.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 89f808b..07ddec3 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1021,7 +1021,8 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		aic31xx_power_off(codec);
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+			aic31xx_power_off(codec);
 		break;
 	}
 	codec->dapm.bias_level = level;
-- 
1.7.9.5

