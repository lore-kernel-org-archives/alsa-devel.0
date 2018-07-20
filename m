From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5651: add Volume to the name of
	volume control
Date: Fri, 20 Jul 2018 09:48:18 +0800
Message-ID: <1532051300-11884-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id BD44926770A
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 03:48:37 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

add Volume to the name of volume control

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 985852f..fe970ed 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -332,11 +332,11 @@ static const struct snd_kcontrol_new rt5651_snd_controls[] = {
 			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
 	/* IN1/IN2/IN3 Control */
-	SOC_SINGLE_TLV("IN1 Boost", RT5651_IN1_IN2,
+	SOC_SINGLE_TLV("IN1 Boost Volume", RT5651_IN1_IN2,
 		RT5651_BST_SFT1, 8, 0, bst_tlv),
-	SOC_SINGLE_TLV("IN2 Boost", RT5651_IN1_IN2,
+	SOC_SINGLE_TLV("IN2 Boost Volume", RT5651_IN1_IN2,
 		RT5651_BST_SFT2, 8, 0, bst_tlv),
-	SOC_SINGLE_TLV("IN3 Boost", RT5651_IN3,
+	SOC_SINGLE_TLV("IN3 Boost Volume", RT5651_IN3,
 		RT5651_BST_SFT1, 8, 0, bst_tlv),
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5651_INL1_INR1_VOL,
-- 
2.7.4
