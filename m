From: Shahina Shaik <shahina.s@samsung.com>
Subject: [PATCH 1/2] SOUND: TLV320AIC32x4: Fixed Coding style Issues
Date: Fri, 13 Jun 2014 11:18:47 +0530
Message-ID: <1402638528-5787-1-git-send-email-shahina.s@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: sharab.shaik@gmail.com, shahina.s@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Shahina Shaik <sharab.shaik@gmail.com>

Fixed a brace coding style issue in the tlv320aic32x4.c

Signed-off-by: Shahina Shaik <sharab.shaik@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 1d9b117..1e50f15 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -626,21 +626,18 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 		snd_soc_write(codec, AIC32X4_MICBIAS, AIC32X4_MICBIAS_LDOIN |
 						      AIC32X4_MICBIAS_2075V);
 	}
-	if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE) {
+	if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE)
 		snd_soc_write(codec, AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE);
-	}
 
 	tmp_reg = (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_ENABLE) ?
 			AIC32X4_LDOCTLEN : 0;
 	snd_soc_write(codec, AIC32X4_LDOCTL, tmp_reg);
 
 	tmp_reg = snd_soc_read(codec, AIC32X4_CMMODE);
-	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36) {
+	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36)
 		tmp_reg |= AIC32X4_LDOIN_18_36;
-	}
-	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED) {
+	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED)
 		tmp_reg |= AIC32X4_LDOIN2HP;
-	}
 	snd_soc_write(codec, AIC32X4_CMMODE, tmp_reg);
 
 	/* Mic PGA routing */
-- 
1.7.9.5
