From: <shumingf@realtek.com>
Subject: [PATCH 3/5] ASoC: rt5682: Remove HP volume control
Date: Tue, 18 Sep 2018 19:51:24 +0800
Message-ID: <1537271484-5638-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 052D0267891
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 13:51:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

This patch removed Headphone Playback Volume control.
Due to codec settings, we don't want the user to change HP analog gain.
The user could use DAC1 Playback Volume control to
change playback volume.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index bf7d910..2725eb7 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -749,7 +749,6 @@ static bool rt5682_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_SCALE(hp_vol_tlv, -2250, 150, 0);
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
@@ -1108,10 +1107,6 @@ static void rt5682_jack_detect_handler(struct work_struct *work)
 }
 
 static const struct snd_kcontrol_new rt5682_snd_controls[] = {
-	/* Headphone Output Volume */
-	SOC_DOUBLE_R_TLV("Headphone Playback Volume", RT5682_HPL_GAIN,
-		RT5682_HPR_GAIN, RT5682_G_HP_SFT, 15, 1, hp_vol_tlv),
-
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5682_DAC1_DIG_VOL,
 		RT5682_L_VOL_SFT + 1, RT5682_R_VOL_SFT + 1, 86, 0, dac_vol_tlv),
-- 
2.7.4
