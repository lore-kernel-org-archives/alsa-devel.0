From: <shumingf@realtek.com>
Subject: [PATCH 1/2] ASoC: rt1011: fix DC calibration offset
	not applying
Date: Thu, 11 Jul 2019 16:22:14 +0800
Message-ID: <20190711082214.8142-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16CCEF800D8
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2019 10:22:44 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Shuming Fan <shumingf@realtek.com>, derek.fang@realtek.com, sathya.prakash.m.r@intel.com, naveen.m@intel.com, mingjane_hsieh@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

There are two issues to fix:
- DC offset calibration data will be reset after stopping playback.
- DC offset calibration data should be applied in the initial setting.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 5605b660f4bf..0a6ff13d76e1 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -39,7 +39,7 @@ static const struct reg_sequence init_list[] = {
 	{ RT1011_POWER_9, 0xa840 },
 
 	{ RT1011_ADC_SET_5, 0x0a20 },
-	{ RT1011_DAC_SET_2, 0xa232 },
+	{ RT1011_DAC_SET_2, 0xa032 },
 	{ RT1011_ADC_SET_1, 0x2925 },
 
 	{ RT1011_SPK_PRO_DC_DET_1, 0xb00c },
@@ -1917,7 +1917,7 @@ static int rt1011_set_bias_level(struct snd_soc_component *component,
 		snd_soc_component_write(component,
 			RT1011_SYSTEM_RESET_2, 0x0000);
 		snd_soc_component_write(component,
-			RT1011_SYSTEM_RESET_3, 0x0000);
+			RT1011_SYSTEM_RESET_3, 0x0001);
 		snd_soc_component_write(component,
 			RT1011_SYSTEM_RESET_1, 0x003f);
 		snd_soc_component_write(component,
-- 
2.22.0
