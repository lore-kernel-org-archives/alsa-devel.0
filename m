From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume control
Date: Wed, 18 Jul 2018 22:55:37 +0200
Message-ID: <20180718205542.12364-2-hdegoede@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 0034C267822
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:55:47 +0200 (CEST)
In-Reply-To: <20180718205542.12364-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Add a mixer control for the IN3 Boost volume, IN3 is used for the headset
mic on most devices, so this is necessary to control the headset mic
volume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 0462049e739c..985852fd9723 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -331,11 +331,13 @@ static const struct snd_kcontrol_new rt5651_snd_controls[] = {
 	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5651_DAC2_DIG_VOL,
 			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
-	/* IN1/IN2 Control */
+	/* IN1/IN2/IN3 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5651_IN1_IN2,
 		RT5651_BST_SFT1, 8, 0, bst_tlv),
 	SOC_SINGLE_TLV("IN2 Boost", RT5651_IN1_IN2,
 		RT5651_BST_SFT2, 8, 0, bst_tlv),
+	SOC_SINGLE_TLV("IN3 Boost", RT5651_IN3,
+		RT5651_BST_SFT1, 8, 0, bst_tlv),
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5651_INL1_INR1_VOL,
 			RT5651_INL_VOL_SFT, RT5651_INR_VOL_SFT,
-- 
2.17.1
