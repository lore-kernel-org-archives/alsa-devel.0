From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8998: Correct handling of input
	muxes" to the asoc tree
Date: Mon, 25 Sep 2017 17:00:52 +0100 (BST)
Message-ID: <20170925160053.034EB440052@finisterre.ee.mobilebroadband>
References: <20170925115507.5956-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 35342266FBD
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:41 +0200 (CEST)
In-Reply-To: <20170925115507.5956-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8998: Correct handling of input muxes

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d24e95f8757e9df5d7a9f56448e609cabe611d0a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 25 Sep 2017 12:55:07 +0100
Subject: [PATCH] ASoC: wm8998: Correct handling of input muxes

Currently, wm8998 has two input mux controls on IN1 and attempts to
switch these together when the A position is configured to be in digital
mode. This is because the digital mode requires pins from both the L and
R channels. However, this doesn't work as intended because whilst the
registers on the chip are changed the corresponding DAPM
representation is only updated for the mux actually being changed by the
user. The DAPM graph being out of sync with the hardware can cause some
odd issues with incorrect things being powered etc.

To avoid this issue and simplify the code somewhat, simply let the user
set the muxes as they desire. If they set an invalid configuration they
might not get audio from the DMIC but most of the chip requires you to
set a valid audio route to get audio.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8998.c | 84 +++++++++++------------------------------------
 1 file changed, 19 insertions(+), 65 deletions(-)

diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 44f447136e22..4b64bb46eb21 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -101,7 +101,7 @@ static int wm8998_asrc_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wm8998_in1mux_put(struct snd_kcontrol *kcontrol,
+static int wm8998_inmux_put(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
@@ -109,84 +109,38 @@ static int wm8998_in1mux_put(struct snd_kcontrol *kcontrol,
 	struct wm8998_priv *wm8998 = snd_soc_codec_get_drvdata(codec);
 	struct arizona *arizona = wm8998->core.arizona;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int mux, inmode;
-	unsigned int mode_val, src_val;
+	unsigned int mode_reg, mode_index;
+	unsigned int mux, inmode, src_val, mode_val;
 
 	mux = ucontrol->value.enumerated.item[0];
 	if (mux > 1)
 		return -EINVAL;
 
-	/* L and R registers have same shift and mask */
-	inmode = arizona->pdata.inmode[2 * mux];
-	src_val = mux << ARIZONA_IN1L_SRC_SHIFT;
-	if (inmode & ARIZONA_INMODE_SE)
-		src_val |= 1 << ARIZONA_IN1L_SRC_SE_SHIFT;
-
-	switch (arizona->pdata.inmode[0]) {
-	case ARIZONA_INMODE_DMIC:
-		if (mux)
-			mode_val = 0;	/* B always analogue */
-		else
-			mode_val = 1 << ARIZONA_IN1_MODE_SHIFT;
-
-		snd_soc_update_bits(codec, ARIZONA_IN1L_CONTROL,
-				    ARIZONA_IN1_MODE_MASK, mode_val);
-
-		/* IN1A is digital so L and R must change together */
-		/* src_val setting same for both registers */
-		snd_soc_update_bits(codec,
-				    ARIZONA_ADC_DIGITAL_VOLUME_1L,
-				    ARIZONA_IN1L_SRC_MASK |
-				    ARIZONA_IN1L_SRC_SE_MASK, src_val);
-		snd_soc_update_bits(codec,
-				    ARIZONA_ADC_DIGITAL_VOLUME_1R,
-				    ARIZONA_IN1R_SRC_MASK |
-				    ARIZONA_IN1R_SRC_SE_MASK, src_val);
+	switch (e->reg) {
+	case ARIZONA_ADC_DIGITAL_VOLUME_2L:
+		mode_reg = ARIZONA_IN2L_CONTROL;
+		mode_index = 1 + (2 * mux);
 		break;
 	default:
-		/* both analogue */
-		snd_soc_update_bits(codec,
-				    e->reg,
-				    ARIZONA_IN1L_SRC_MASK |
-				    ARIZONA_IN1L_SRC_SE_MASK,
-				    src_val);
+		mode_reg = ARIZONA_IN1L_CONTROL;
+		mode_index = (2 * mux);
 		break;
 	}
 
-	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
-					     ucontrol->value.enumerated.item[0],
-					     e, NULL);
-}
-
-static int wm8998_in2mux_put(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8998_priv *wm8998 = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = wm8998->core.arizona;
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int mux, inmode, src_val, mode_val;
-
-	mux = ucontrol->value.enumerated.item[0];
-	if (mux > 1)
-		return -EINVAL;
-
-	inmode = arizona->pdata.inmode[1 + (2 * mux)];
+	inmode = arizona->pdata.inmode[mode_index];
 	if (inmode & ARIZONA_INMODE_DMIC)
-		mode_val = 1 << ARIZONA_IN2_MODE_SHIFT;
+		mode_val = 1 << ARIZONA_IN1_MODE_SHIFT;
 	else
 		mode_val = 0;
 
-	src_val = mux << ARIZONA_IN2L_SRC_SHIFT;
+	src_val = mux << ARIZONA_IN1L_SRC_SHIFT;
 	if (inmode & ARIZONA_INMODE_SE)
-		src_val |= 1 << ARIZONA_IN2L_SRC_SE_SHIFT;
+		src_val |= 1 << ARIZONA_IN1L_SRC_SE_SHIFT;
 
-	snd_soc_update_bits(codec, ARIZONA_IN2L_CONTROL,
-			    ARIZONA_IN2_MODE_MASK, mode_val);
+	snd_soc_update_bits(codec, mode_reg, ARIZONA_IN1_MODE_MASK, mode_val);
 
-	snd_soc_update_bits(codec, ARIZONA_ADC_DIGITAL_VOLUME_2L,
-			    ARIZONA_IN2L_SRC_MASK | ARIZONA_IN2L_SRC_SE_MASK,
+	snd_soc_update_bits(codec, e->reg,
+			    ARIZONA_IN1L_SRC_MASK | ARIZONA_IN1L_SRC_SE_MASK,
 			    src_val);
 
 	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
@@ -216,14 +170,14 @@ static SOC_ENUM_SINGLE_DECL(wm8998_in2mux_enum,
 
 static const struct snd_kcontrol_new wm8998_in1mux[2] = {
 	SOC_DAPM_ENUM_EXT("IN1L Mux", wm8998_in1muxl_enum,
-			  snd_soc_dapm_get_enum_double, wm8998_in1mux_put),
+			  snd_soc_dapm_get_enum_double, wm8998_inmux_put),
 	SOC_DAPM_ENUM_EXT("IN1R Mux", wm8998_in1muxr_enum,
-			  snd_soc_dapm_get_enum_double, wm8998_in1mux_put),
+			  snd_soc_dapm_get_enum_double, wm8998_inmux_put),
 };
 
 static const struct snd_kcontrol_new wm8998_in2mux =
 	SOC_DAPM_ENUM_EXT("IN2 Mux", wm8998_in2mux_enum,
-			  snd_soc_dapm_get_enum_double, wm8998_in2mux_put);
+			  snd_soc_dapm_get_enum_double, wm8998_inmux_put);
 
 static DECLARE_TLV_DB_SCALE(ana_tlv, 0, 100, 0);
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
-- 
2.14.1
