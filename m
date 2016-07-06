From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: add DAC1 soft volume func
	control
Date: Wed, 6 Jul 2016 09:55:15 +0800
Message-ID: <1467770115-16706-2-git-send-email-bardliao@realtek.com>
References: <1467770115-16706-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 02AB52652F5
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2016 03:55:25 +0200 (CEST)
In-Reply-To: <1467770115-16706-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, PC.Liao@mediatek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch add an alsa control for DAC1 digital volume control function
selection. The options are:
0: Gain update immediately
1: Gain update when a zero crossing
2: Gain update when a zero crossing with a soft ramp

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 4 ++++
 sound/soc/codecs/rt5645.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9251720..036628c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -808,6 +808,10 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
 		1, 1),
 	RT5645_HWEQ("Speaker HWEQ"),
+
+	/* Digiatl Soft Volume Control */
+	SOC_SINGLE("DAC1 Digital Volume Control Func",
+		RT5645_PR_BASE, RT5645_DA1_ZDET_SFT, 3, 0),
 };
 
 /**
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 205e071..cfc5f97 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2018,6 +2018,9 @@
 
 
 /* Codec Private Register definition */
+/* DAC ADC Digital Volume (0x00) */
+#define RT5645_DA1_ZDET_SFT			6
+
 /* 3D Speaker Control (0x63) */
 #define RT5645_3D_SPK_MASK			(0x1 << 15)
 #define RT5645_3D_SPK_SFT			15
-- 
1.8.1.1.439.g50a6b54
