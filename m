From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH] ASoC: sgtl5000: add AVC configuration controls
Date: Tue, 6 Jun 2017 14:04:22 +0200
Message-ID: <1496750662-19135-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.skidata.com (mail1.skidata.com [91.230.2.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 04529266C72
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 14:04:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: clemens.gruber@pqgruber.com, kalle.kankare@vincit.fi, eric@nelint.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, dev@g0hl1n.net, richard.leitner@skidata.com
List-Id: alsa-devel@alsa-project.org

For the configuration of the automatic volume control block (AVC), which
reduces loud signals and amplifies low level signals for easier
listening, following controls are added:
	+ AVC Threshold Volume: threshold where audio is compressed when
		the measured level is above or expanded when below
	+ AVC Max Gain Volume: maximum gain which can be applied when
		the measured audio level is below threshold
	+ AVC Hard Limiter Switch: when enabled the signal is limited to
		the programmed threshold.
	+ AVC Integrator Response

These controls use the DAP_AVC_CTRL and DAP_AVC_THRESHOLD registers for
configuration.

This patch depends on "ASoC: sgtl5000: add avc enable control"

Following 2 checkpatch.pl strict checks are ignored because the
indentation style is different for the struct snd_kcontrol_new
definition:
	patch:144: CHECK: Alignment should match open parenthesis
	patch:147: CHECK: Alignment should match open parenthesis

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 sound/soc/codecs/sgtl5000.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0477f2e..2bb3235 100644
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
@@ -382,6 +396,63 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
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
+	db = clamp((int)ucontrol->value.integer.value[0], 0, 96);
+	reg = avc_thr_db2reg[db];
+	snd_soc_write(codec, SGTL5000_DAP_AVC_THRESHOLD, reg);
+
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(capture_6db_attenuate, -600, 600, 0);
 
 /* tlv for mic gain, 0db 20db 30db 40db */
@@ -396,6 +467,12 @@ static const DECLARE_TLV_DB_SCALE(headphone_volume, -5150, 50, 0);
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
@@ -435,7 +512,15 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			lineout_volume),
 	SOC_SINGLE("Lineout Playback Switch", SGTL5000_CHIP_ANA_CTRL, 8, 1, 1),
 
+	/* Automatic Volume Control (DAP AVC) */
 	SOC_SINGLE("AVC Enable Switch", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),
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
2.1.4
