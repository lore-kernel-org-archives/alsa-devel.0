From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE" to
 the asoc tree
Date: Wed, 08 Mar 2017 14:22:41 +0100
Message-ID: <E1clbY9-0000DH-LY@finisterre>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0641614158900742392=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, mylene.josserand@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============0641614158900742392==
Content-Type: text/plain

The patch

   ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE

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

>From ca14da6e611674cad275f29ac2aaf1e2eb427c6b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Fri, 10 Feb 2017 10:41:31 +0100
Subject: [PATCH] ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the driver to use the new SOC_DAPM_DOUBLE definition
on the digital DAC mixer.
Update the names accordingly as, when they are shared, the
controls are not prefixed with the widget's name anymore.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 45 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index d60f6fbd36a2..107fa8213600 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -259,25 +259,20 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_kcontrol_new sun8i_output_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LSlot 0", SUN8I_DAC_MXR_SRC,
-			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L, 1, 0),
-	SOC_DAPM_SINGLE("LSlot 1", SUN8I_DAC_MXR_SRC,
-			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L, 1, 0),
-	SOC_DAPM_SINGLE("DACL", SUN8I_DAC_MXR_SRC,
-			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL, 1, 0),
-	SOC_DAPM_SINGLE("ADCL", SUN8I_DAC_MXR_SRC,
-			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL, 1, 0),
-};
-
-static const struct snd_kcontrol_new sun8i_output_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("RSlot 0", SUN8I_DAC_MXR_SRC,
+static const struct snd_kcontrol_new sun8i_dac_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("AIF1 Slot 0 Digital DAC Playback Switch",
+			SUN8I_DAC_MXR_SRC,
+			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L,
 			SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R, 1, 0),
-	SOC_DAPM_SINGLE("RSlot 1", SUN8I_DAC_MXR_SRC,
+	SOC_DAPM_DOUBLE("AIF1 Slot 1 Digital DAC Playback Switch",
+			SUN8I_DAC_MXR_SRC,
+			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L,
 			SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R, 1, 0),
-	SOC_DAPM_SINGLE("DACR", SUN8I_DAC_MXR_SRC,
+	SOC_DAPM_DOUBLE("AIF2 Digital DAC Playback Switch", SUN8I_DAC_MXR_SRC,
+			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL,
 			SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR, 1, 0),
-	SOC_DAPM_SINGLE("ADCR", SUN8I_DAC_MXR_SRC,
+	SOC_DAPM_DOUBLE("ADC Digital DAC Playback Switch", SUN8I_DAC_MXR_SRC,
+			SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL,
 			SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR, 1, 0),
 };
 
@@ -293,12 +288,12 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			 SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* DAC Mixers */
-	SND_SOC_DAPM_MIXER("Left DAC Mixer", SND_SOC_NOPM, 0, 0,
-			   sun8i_output_left_mixer_controls,
-			   ARRAY_SIZE(sun8i_output_left_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right DAC Mixer", SND_SOC_NOPM, 0, 0,
-			   sun8i_output_right_mixer_controls,
-			   ARRAY_SIZE(sun8i_output_right_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
+			   sun8i_dac_mixer_controls,
+			   ARRAY_SIZE(sun8i_dac_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
+			   sun8i_dac_mixer_controls,
+			   ARRAY_SIZE(sun8i_dac_mixer_controls)),
 
 	/* Clocks */
 	SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
@@ -340,8 +335,10 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "Digital Right DAC", NULL, "DAC" },
 
 	/* DAC Mixer Routes */
-	{ "Left DAC Mixer", "LSlot 0", "Digital Left DAC"},
-	{ "Right DAC Mixer", "RSlot 0", "Digital Right DAC"},
+	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
+	  "Digital Left DAC"},
+	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch ",
+	  "Digital Right DAC"},
 };
 
 static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
-- 
2.11.0



--===============0641614158900742392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0641614158900742392==--
