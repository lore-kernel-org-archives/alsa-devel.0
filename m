From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v2 4/9] ASoC: da7210: Add support for mute and
 zero cross controls
Date: Thu, 13 Oct 2011 19:41:53 +0530
Message-ID: <1318515113.12107.481.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 23DAB10386E
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 16:03:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for below set of controls,
(1) Mute controls for MIC, AUX, ADC and DAC
(2) Zero cross controls for head phone, AUX, INPGA and line out
(3) Head phone mode selection - class H or G

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v1:
- Changed Mic mute control to a double control
- Fixed a typo
---
 sound/soc/codecs/da7210.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 7e36ed6..cb00935 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -45,6 +45,7 @@
 #define DA7210_DAC_L			0x15
 #define DA7210_DAC_R			0x16
 #define DA7210_DAC_SEL			0x17
+#define DA7210_SOFTMUTE			0x18
 #define DA7210_DAC_EQ1_2		0x19
 #define DA7210_DAC_EQ3_4		0x1A
 #define DA7210_DAC_EQ5			0x1B
@@ -56,6 +57,7 @@
 #define DA7210_HP_L_VOL			0x21
 #define DA7210_HP_R_VOL			0x22
 #define DA7210_HP_CFG			0x23
+#define DA7210_ZERO_CROSS		0x24
 #define DA7210_DAI_SRC_SEL		0x25
 #define DA7210_DAI_CFG1			0x26
 #define DA7210_DAI_CFG3			0x28
@@ -166,6 +168,9 @@
 /* AUX2 bit fields */
 #define DA7210_AUX2_EN			(1 << 3)
 
+/* SOFTMUTE bit fields */
+#define DA7210_RAMP_EN			(1 << 6)
+
 #define DA7210_VERSION "0.0.1"
 
 /*
@@ -211,6 +216,13 @@ static const unsigned int aux1_vol_tlv[] = {
 	0x11, 0x3f, TLV_DB_SCALE_ITEM(-4800, 150, 0)
 };
 
+static const char *da7210_hp_mode_txt[] = {
+	"Class H", "Class G"
+};
+
+static const struct soc_enum da7210_hp_mode_sel =
+	SOC_ENUM_SINGLE(DA7210_HP_CFG, 0, 2, da7210_hp_mode_txt);
+
 static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("HeadPhone Playback Volume",
@@ -267,6 +279,23 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 		       eq_gain_tlv),
 	SOC_SINGLE_TLV("ADC EQ5 Volume", DA7210_ADC_EQ5, 0, 0xf, 1,
 		       eq_gain_tlv),
+
+	/* Mute controls */
+	SOC_DOUBLE_R("Mic Mute Switch", DA7210_MIC_L, DA7210_MIC_R, 3, 1, 0),
+	SOC_SINGLE("Aux2 Mute Switch", DA7210_AUX2, 2, 1, 0),
+	SOC_SINGLE("ADC Left Mute Switch", DA7210_ADC, 2, 1, 0),
+	SOC_SINGLE("ADC Right Mute Switch", DA7210_ADC, 6, 1, 0),
+	SOC_SINGLE("DAC Mute Switch", DA7210_DAC_HPF, 2, 1, 0),
+	SOC_SINGLE("DAC Soft Mute Switch", DA7210_SOFTMUTE, 7, 1, 0),
+	SOC_SINGLE("DAC Soft Mute Rate", DA7210_SOFTMUTE, 0, 0x7, 0),
+
+	/* Zero cross controls */
+	SOC_DOUBLE("Aux1 ZC Switch", DA7210_ZERO_CROSS, 0, 1, 1, 0),
+	SOC_DOUBLE("In PGA ZC Switch", DA7210_ZERO_CROSS, 2, 3, 1, 0),
+	SOC_DOUBLE("Lineout ZC Switch", DA7210_ZERO_CROSS, 4, 5, 1, 0),
+	SOC_DOUBLE("Headphone ZC Switch", DA7210_ZERO_CROSS, 6, 7, 1, 0),
+
+	SOC_ENUM("Headphone Class", da7210_hp_mode_sel),
 };
 
 /* Codec private data */
@@ -597,6 +626,9 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	/* Enable Aux2 */
 	snd_soc_write(codec, DA7210_AUX2, DA7210_AUX2_EN);
 
+	/* Enable ramp mode for DAC gain update */
+	snd_soc_write(codec, DA7210_SOFTMUTE, DA7210_RAMP_EN);
+
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
 
-- 
1.7.1
