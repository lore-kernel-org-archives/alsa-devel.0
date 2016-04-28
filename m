From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5651: remove unexisting widget
Date: Thu, 28 Apr 2016 10:13:01 +0800
Message-ID: <1461809581-7863-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FD122650DA
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 04:13:15 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

IN Muxes are not existing on rt5651.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5651.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 7a61970..b812c06 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -955,11 +955,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 			 RT5651_PWR_IN2_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("INR2 VOL", RT5651_PWR_VOL,
 			 RT5651_PWR_IN2_R_BIT, 0, NULL, 0),
-	/* IN Mux */
-	SND_SOC_DAPM_MUX("INL1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl1_mux),
-	SND_SOC_DAPM_MUX("INR1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr1_mux),
-	SND_SOC_DAPM_MUX("INL2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl2_mux),
-	SND_SOC_DAPM_MUX("INR2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr2_mux),
 	/* REC Mixer */
 	SND_SOC_DAPM_MIXER("RECMIXL", RT5651_PWR_MIXER, RT5651_PWR_RM_L_BIT, 0,
 			   rt5651_rec_l_mix, ARRAY_SIZE(rt5651_rec_l_mix)),
-- 
1.8.1.1.439.g50a6b54
