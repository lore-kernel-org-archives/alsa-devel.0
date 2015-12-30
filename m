From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: add sys clk detection
Date: Wed, 30 Dec 2015 15:33:21 +0800
Message-ID: <1451460801-24252-2-git-send-email-bardliao@realtek.com>
References: <1451460801-24252-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 56AB72658F7
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 08:33:41 +0100 (CET)
In-Reply-To: <1451460801-24252-1-git-send-email-bardliao@realtek.com>
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

Add system clock detection to prevent output DC from SPO.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 4 ++++
 sound/soc/codecs/rt5645.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 57c8d9e..594c489 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1823,9 +1823,13 @@ static int rt5645_spk_event(struct snd_soc_dapm_widget *w,
 			RT5645_PWR_CLS_D_L,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
 			RT5645_PWR_CLS_D_L);
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL3,
+			RT5645_DET_CLK_MASK, RT5645_DET_CLK_MODE1);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL3,
+			RT5645_DET_CLK_MASK, RT5645_DET_CLK_DIS);
 		snd_soc_write(codec, RT5645_EQ_CTRL2, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
 			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 093e46d..205e071 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2122,6 +2122,10 @@ enum {
 /* General Control3 (0xfc) */
 #define RT5645_JD_PSV_MODE			(0x1 << 12)
 #define RT5645_IRQ_CLK_GATE_CTRL		(0x1 << 11)
+#define RT5645_DET_CLK_MASK			(0x3 << 9)
+#define RT5645_DET_CLK_DIS			(0x0 << 9)
+#define RT5645_DET_CLK_MODE1			(0x1 << 9)
+#define RT5645_DET_CLK_MODE2			(0x2 << 9)
 #define RT5645_MICINDET_MANU			(0x1 << 7)
 #define RT5645_RING2_SLEEVE_GND			(0x1 << 5)
 
-- 
1.8.1.1.439.g50a6b54
