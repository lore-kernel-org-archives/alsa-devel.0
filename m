From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: rt5645: Add Mono ADC Boost Gain control
Date: Mon,  2 Nov 2015 20:37:14 -0800
Message-ID: <1446525434-17922-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C3B03264F37
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 05:37:38 +0100 (CET)
Received: by pacfv9 with SMTP id fv9so7273322pac.3
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 20:37:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

"Mono ADC Boost Gain" (MX-20h) is a coarse capture volume
control with a step of 12dB on the Mono audio path. It is
similar to the "STO1 ADC Boost Gain" control on the Stereo1
audio path.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5645.c | 3 +++
 sound/soc/codecs/rt5645.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index f046bb8..f8c5e82 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -625,6 +625,9 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_DOUBLE_TLV("STO2 ADC Boost Gain", RT5645_ADC_BST_VOL1,
 		RT5645_STO2_ADC_L_BST_SFT, RT5645_STO2_ADC_R_BST_SFT, 3, 0,
 		adc_bst_tlv),
+	SOC_DOUBLE_TLV("Mono ADC Boost Gain", RT5645_ADC_BST_VOL2,
+		RT5645_MONO_ADC_L_BST_SFT, RT5645_MONO_ADC_R_BST_SFT, 3, 0,
+		adc_bst_tlv),
 
 	/* I2S2 function select */
 	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 7cea282..9ddba59 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -322,6 +322,14 @@
 #define RT5645_STO2_ADC_COMP_MASK		(0x3 << 4)
 #define RT5645_STO2_ADC_COMP_SFT		4
 
+/* Mono ADC Boost Volume Control (0x20) */
+#define RT5645_MONO_ADC_L_BST_MASK		(0x3 << 14)
+#define RT5645_MONO_ADC_L_BST_SFT		14
+#define RT5645_MONO_ADC_R_BST_MASK		(0x3 << 12)
+#define RT5645_MONO_ADC_R_BST_SFT		12
+#define RT5645_MONO_ADC_COMP_MASK		(0x3 << 10)
+#define RT5645_MONO_ADC_COMP_SFT		10
+
 /* Stereo2 ADC Mixer Control (0x26) */
 #define RT5645_STO2_ADC_SRC_MASK		(0x1 << 15)
 #define RT5645_STO2_ADC_SRC_SFT			15
-- 
2.6.0.rc2.230.g3dd15c0
