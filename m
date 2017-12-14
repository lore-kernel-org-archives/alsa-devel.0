From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Fix the wrong result of the
	first jack detection
Date: Thu, 14 Dec 2017 09:54:07 +0800
Message-ID: <1513216447-26901-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D26C266D71
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 02:54:16 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shruthi.sudhakar@intel.com, albertchen@realtek.com, naveen.m@intel.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

In the first jack detection while booting, the result will always show as
headset, even we insert the headphone.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 4 ++++
 sound/soc/codecs/rt5663.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index b036c9d..d329bf7 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1560,6 +1560,10 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			RT5663_IRQ_POW_SAV_MASK, RT5663_IRQ_POW_SAV_EN);
 		snd_soc_update_bits(codec, RT5663_IRQ_1,
 			RT5663_EN_IRQ_JD1_MASK, RT5663_EN_IRQ_JD1_EN);
+		snd_soc_update_bits(codec, RT5663_EM_JACK_TYPE_1,
+			RT5663_EM_JD_MASK, RT5663_EM_JD_RST);
+		snd_soc_update_bits(codec, RT5663_EM_JACK_TYPE_1,
+			RT5663_EM_JD_MASK, RT5663_EM_JD_NOR);
 
 		while (true) {
 			regmap_read(rt5663->regmap, RT5663_INT_ST_2, &val);
diff --git a/sound/soc/codecs/rt5663.h b/sound/soc/codecs/rt5663.h
index c5a9b69..03adc80 100644
--- a/sound/soc/codecs/rt5663.h
+++ b/sound/soc/codecs/rt5663.h
@@ -1029,6 +1029,10 @@
 #define RT5663_POL_EXT_JD_SHIFT			10
 #define RT5663_POL_EXT_JD_EN			(0x1 << 10)
 #define RT5663_POL_EXT_JD_DIS			(0x0 << 10)
+#define RT5663_EM_JD_MASK			(0x1 << 7)
+#define RT5663_EM_JD_SHIFT			7
+#define RT5663_EM_JD_NOR			(0x1 << 7)
+#define RT5663_EM_JD_RST			(0x0 << 7)
 
 /* DACREF LDO Control (0x0112)*/
 #define RT5663_PWR_LDO_DACREFL_MASK		(0x1 << 9)
-- 
2.7.4
