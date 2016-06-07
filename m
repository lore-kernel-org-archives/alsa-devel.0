From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: fix HP Playback Volume control
Date: Tue, 7 Jun 2016 11:03:08 +0800
Message-ID: <1465268588-25478-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id F0A9B265755
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 05:03:29 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The register setting for HP Playback Volume is inverted. So, set
the invert flag in SOC_DOUBLE_TLV.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 49a9e70..0af5ddb 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -619,7 +619,7 @@ static const struct snd_kcontrol_new rt5670_snd_controls[] = {
 		RT5670_L_MUTE_SFT, RT5670_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("HP Playback Volume", RT5670_HP_VOL,
 		RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
-		39, 0, out_vol_tlv),
+		39, 1, out_vol_tlv),
 	/* OUTPUT Control */
 	SOC_DOUBLE("OUT Channel Switch", RT5670_LOUT1,
 		RT5670_VOL_L_SFT, RT5670_VOL_R_SFT, 1, 1),
-- 
1.8.1.1.439.g50a6b54
