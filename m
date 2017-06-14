From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: add avc support" to the asoc tree
Date: Wed, 14 Jun 2017 11:12:56 +0100
Message-ID: <E1dL5IG-0007gU-Si@debutante>
References: <1497429372-27193-1-git-send-email-richard.leitner@skidata.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497429372-27193-1-git-send-email-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, clemens.gruber@pqgruber.com, kalle.kankare@vincit.fi, alsa-devel@alsa-project.org, lgirdwood@gmail.com, eric@nelint.com, linux-kernel@vger.kernel.org, tiwai@suse.com, fabio.estevam@nxp.com, dev@g0hl1n.net, richard.leitner@skidata.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: add avc support

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

>From a729526720059ae019803acc953f07d9c17ae234 Mon Sep 17 00:00:00 2001
From: Richard Leitner <richard.leitner@skidata.com>
Date: Wed, 14 Jun 2017 10:36:12 +0200
Subject: [PATCH] ASoC: sgtl5000: add avc support

The sgtl5000 features an automatic volume control block (AVC), which
reduces loud signals and amplifies low level signals for easier
listening. This patch adds support for this AVC block to the driver.

Apart from the "AVC Switch" control which enables the block following
controls for the configuration of AVC are added:
	+ AVC Threshold Volume: threshold where audio is compressed when
		the measured level is above or expanded when below
	+ AVC Max Gain Volume: maximum gain which can be applied when
		the measured audio level is below threshold
	+ AVC Hard Limiter Switch: when enabled the signal is limited to
		the programmed threshold.
	+ AVC Integrator Response: response time of the integrator

The AVC block is enabled and configured using the DAP_AVC_CTRL and
DAP_AVC_THRESHOLD registers.

Following 2 checkpatch.pl strict checks are ignored because the
indentation style is different for the struct snd_kcontrol_new
definition:
	patch:147: CHECK: Alignment should match open parenthesis
	patch:150: CHECK: Alignment should match open parenthesis

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5a2702edeb77..8f6814c1eb6b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -74,6 +74,20 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_DAP_AVC_DECAY,		0x0050 },
 };
 
+/* AVC: Threshold dB -> register: pre-calculated values */
+static const u16 avc_thr_db2reg[97] = {
+	0x5168, 0x488E, 0x40AA, 0x39A1, 0x335D, 0x2DC7, 0x28CC, 0x245D, 0x2068,
+	0x1CE2, 0x19BE, 0x16F1, 0x1472, 0x1239, 0x103E, 0x0E7A, 0x0CE6, 0x0B7F,
+	0x0A3F, 0x0922, 0x0824, 0x0741, 0x0677, 0x05C3, 0x0522, 0x0493, 0x0414,
+	0x03A2, 0x033D, 0x02E3, 0x0293, 0x024B, 0x020B, 0x01D2, 0x019F, 0x0172,
+	0x014A, 0x0126, 0x0106, 0x00E9, 0x00D0, 0x00B9, 0x00A5, 0x0093, 0x0083,
+	0x0075, 0x0068, 0x005D, 0x0052, 0x0049, 0x0041, 0x003A, 0x0034, 0x002E,
+	0x0029, 0x0025, 0x0021, 0x001D, 0x001A, 0x0017, 0x0014, 0x0012, 0x0010,
+	0x000E, 0x000D, 0x000B, 0x000A, 0x0009, 0x0008, 0x0007, 0x0006, 0x0005,
+	0x0005, 0x0004, 0x0004, 0x0003, 0x0003, 0x0002, 0x0002, 0x0002, 0x0002,
+	0x0001, 0x0001, 0x0001, 0x0001, 0x0001, 0x0001, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000};
+
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
 	VDDA,
@@ -382,6 +396,65 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/*
+ * custom function to get AVC threshold
+ *
+ * The threshold dB is calculated by rearranging the calculation from the
+ * avc_put_threshold function: register_value = 10^(dB/20) * 0.636 * 2^15 ==>
+ * dB = ( fls(register_value) - 14.347 ) * 6.02
+ *
+ * As this calculation is expensive and the threshold dB values may not exeed
+ * 0 to 96 we use pre-calculated values.
+ */
+static int avc_get_threshold(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int db, i;
+	u16 reg = snd_soc_read(codec, SGTL5000_DAP_AVC_THRESHOLD);
+
+	/* register value 0 => -96dB */
+	if (!reg) {
+		ucontrol->value.integer.value[0] = 96;
+		ucontrol->value.integer.value[1] = 96;
+		return 0;
+	}
+
+	/* get dB from register value (rounded down) */
+	for (i = 0; avc_thr_db2reg[i] > reg; i++)
+		;
+	db = i;
+
+	ucontrol->value.integer.value[0] = db;
+	ucontrol->value.integer.value[1] = db;
+
+	return 0;
+}
+
+/*
+ * custom function to put AVC threshold
+ *
+ * The register value is calculated by following formula:
+ *                                    register_value = 10^(dB/20) * 0.636 * 2^15
+ * As this calculation is expensive and the threshold dB values may not exeed
+ * 0 to 96 we use pre-calculated values.
+ */
+static int avc_put_threshold(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int db;
+	u16 reg;
+
+	db = (int)ucontrol->value.integer.value[0];
+	if (db < 0 || db > 96)
+		return -EINVAL;
+	reg = avc_thr_db2reg[db];
+	snd_soc_write(codec, SGTL5000_DAP_AVC_THRESHOLD, reg);
+
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(capture_6db_attenuate, -600, 600, 0);
 
 /* tlv for mic gain, 0db 20db 30db 40db */
@@ -396,6 +469,12 @@ static const DECLARE_TLV_DB_SCALE(headphone_volume, -5150, 50, 0);
 /* tlv for lineout volume, 31 steps of .5db each */
 static const DECLARE_TLV_DB_SCALE(lineout_volume, -1550, 50, 0);
 
+/* tlv for dap avc max gain, 0db, 6db, 12db */
+static const DECLARE_TLV_DB_SCALE(avc_max_gain, 0, 600, 0);
+
+/* tlv for dap avc threshold, */
+static const DECLARE_TLV_DB_MINMAX(avc_threshold, 0, 9600);
+
 static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 	/* SOC_DOUBLE_S8_TLV with invert */
 	{
@@ -434,6 +513,16 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			0x1f, 1,
 			lineout_volume),
 	SOC_SINGLE("Lineout Playback Switch", SGTL5000_CHIP_ANA_CTRL, 8, 1, 1),
+
+	/* Automatic Volume Control (DAP AVC) */
+	SOC_SINGLE("AVC Switch", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),
+	SOC_SINGLE("AVC Hard Limiter Switch", SGTL5000_DAP_AVC_CTRL, 5, 1, 0),
+	SOC_SINGLE_TLV("AVC Max Gain Volume", SGTL5000_DAP_AVC_CTRL, 12, 2, 0,
+			avc_max_gain),
+	SOC_SINGLE("AVC Integrator Response", SGTL5000_DAP_AVC_CTRL, 8, 3, 0),
+	SOC_SINGLE_EXT_TLV("AVC Threshold Volume", SGTL5000_DAP_AVC_THRESHOLD,
+			0, 96, 0, avc_get_threshold, avc_put_threshold,
+			avc_threshold),
 };
 
 /* mute the codec used by alsa core */
-- 
2.11.0
