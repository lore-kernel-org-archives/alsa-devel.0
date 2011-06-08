From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: Implement base 5 band EQ control for
	WM8962
Date: Wed,  8 Jun 2011 14:50:53 +0100
Message-ID: <1307541055-10150-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D38F10392D
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 15:51:03 +0200 (CEST)
In-Reply-To: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

ReTune Mobile modes are not currently supported.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 859e699..56934d3 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1984,6 +1984,7 @@ static const unsigned int classd_tlv[] = {
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
 	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
 };
+static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 
 /* The VU bits for the headphones are in a different register to the mute
  * bits and only take effect on the PGA if it is actually powered.
@@ -2121,6 +2122,18 @@ SOC_SINGLE_TLV("HPMIXR MIXINR Volume", WM8962_HEADPHONE_MIXER_4,
 
 SOC_SINGLE_TLV("Speaker Boost Volume", WM8962_CLASS_D_CONTROL_2, 0, 7, 0,
 	       classd_tlv),
+
+SOC_SINGLE("EQ Switch", WM8962_EQ1, WM8962_EQ_ENA_SHIFT, 1, 0),
+SOC_DOUBLE_R_TLV("EQ1 Volume", WM8962_EQ2, WM8962_EQ22,
+		 WM8962_EQL_B1_GAIN_SHIFT, 31, 0, eq_tlv),
+SOC_DOUBLE_R_TLV("EQ2 Volume", WM8962_EQ2, WM8962_EQ22,
+		 WM8962_EQL_B2_GAIN_SHIFT, 31, 0, eq_tlv),
+SOC_DOUBLE_R_TLV("EQ3 Volume", WM8962_EQ2, WM8962_EQ22,
+		 WM8962_EQL_B3_GAIN_SHIFT, 31, 0, eq_tlv),
+SOC_DOUBLE_R_TLV("EQ4 Volume", WM8962_EQ3, WM8962_EQ23,
+		 WM8962_EQL_B4_GAIN_SHIFT, 31, 0, eq_tlv),
+SOC_DOUBLE_R_TLV("EQ5 Volume", WM8962_EQ3, WM8962_EQ23,
+		 WM8962_EQL_B5_GAIN_SHIFT, 31, 0, eq_tlv),
 };
 
 static const struct snd_kcontrol_new wm8962_spk_mono_controls[] = {
@@ -3898,6 +3911,9 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8962_HPOUTR_VOLUME,
 			    WM8962_HPOUT_VU, WM8962_HPOUT_VU);
 
+	/* Stereo control for EQ */
+	snd_soc_update_bits(codec, WM8962_EQ1, WM8962_EQ_SHARED_COEFF, 0);
+
 	wm8962_add_widgets(codec);
 
 	/* Save boards having to disable DMIC when not in use */
-- 
1.7.5.3
