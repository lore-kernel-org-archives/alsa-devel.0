From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt298: reset AD dilter is there is
	no MCLK
Date: Tue, 26 Apr 2016 18:07:10 +0800
Message-ID: <1461665231-14070-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DC80F2608B3
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 12:07:24 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt298 need to reset AD filter and the ADC settings will take effort.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 20 ++++++++++++++++++++
 sound/soc/codecs/rt298.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index f0e6c06..178b1cc 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -481,6 +481,26 @@ static int rt298_adc_event(struct snd_soc_dapm_widget *w,
 		snd_soc_update_bits(codec,
 			VERB_CMD(AC_VERB_SET_AMP_GAIN_MUTE, nid, 0),
 			0x7080, 0x7000);
+		 /* If MCLK doesn't exist, reset AD filter */
+		if (!(snd_soc_read(codec, RT298_VAD_CTRL) & 0x200)) {
+			pr_info("NO MCLK\n");
+			switch (nid) {
+			case RT298_ADC_IN1:
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x2, 0x2);
+				mdelay(10);
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x2, 0x0);
+				break;
+			case RT298_ADC_IN2:
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x4, 0x4);
+				mdelay(10);
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x4, 0x0);
+				break;
+			}
+		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		snd_soc_update_bits(codec,
diff --git a/sound/soc/codecs/rt298.h b/sound/soc/codecs/rt298.h
index d66f884..3638f3d 100644
--- a/sound/soc/codecs/rt298.h
+++ b/sound/soc/codecs/rt298.h
@@ -137,6 +137,7 @@
 #define RT298_A_BIAS_CTRL2	0x02
 #define RT298_POWER_CTRL1	0x03
 #define RT298_A_BIAS_CTRL3	0x04
+#define RT298_D_FILTER_CTRL	0x05
 #define RT298_POWER_CTRL2	0x08
 #define RT298_I2S_CTRL1		0x09
 #define RT298_I2S_CTRL2		0x0a
@@ -148,6 +149,7 @@
 #define RT298_IRQ_CTRL		0x33
 #define RT298_WIND_FILTER_CTRL	0x46
 #define RT298_PLL_CTRL1		0x49
+#define RT298_VAD_CTRL		0x4e
 #define RT298_CBJ_CTRL1		0x4f
 #define RT298_CBJ_CTRL2		0x50
 #define RT298_PLL_CTRL		0x63
-- 
1.8.1.1.439.g50a6b54
