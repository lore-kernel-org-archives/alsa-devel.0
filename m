From: Joe Perches <joe@perches.com>
Subject: [PATCH 5/5] sound: tlv320aic31xx: Convert /n to \n
Date: Thu, 24 Apr 2014 18:51:03 -0700
Message-ID: <86cf3ef4915174777ea70f56c1c155f1e13fda0b.1398390579.git.joe@perches.com>
References: <cover.1398390579.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398390579.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use a newline character appropriately.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index b93d500..2341910 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -377,7 +377,7 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 		reg = AIC31XX_ADCFLAG;
 		break;
 	default:
-		dev_err(w->codec->dev, "Unknown widget '%s' calling %s/n",
+		dev_err(w->codec->dev, "Unknown widget '%s' calling %s\n",
 			w->name, __func__);
 		return -EINVAL;
 	}
-- 
1.8.1.2.459.gbcd45b4.dirty
