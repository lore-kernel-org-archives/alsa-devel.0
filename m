From: John Lin <john.lin@realtek.com>
Subject: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Wed, 2 Mar 2016 17:18:40 +0800
Message-ID: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A7A12614D3
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 10:18:59 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>, bardliao@realtek.com, zhengsq@rock-chips.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add kcontrol for headphone channel switch.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5616.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 3704d07..b370993 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -309,6 +309,8 @@ static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 	/* Headphone Output Volume */
 	SOC_DOUBLE("HP Playback Switch", RT5616_HP_VOL,
 		   RT5616_L_MUTE_SFT, RT5616_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE("HP Channel Switch", RT5616_HP_VOL,
+		   RT5616_VOL_L_SFT, RT5616_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("HP Playback Volume", RT5616_HP_VOL,
 		       RT5616_L_VOL_SFT, RT5616_R_VOL_SFT, 39, 1, out_vol_tlv),
 	/* OUTPUT Control */
-- 
1.8.1.1.439.g50a6b54
