From: Sergej Sawazki <ce3a@gmx.de>
Subject: [PATCH] ASoC: wm8741: Fix (and refactor) volume
	controls
Date: Sat, 16 Jan 2016 13:25:29 +0100
Message-ID: <1452947129-11669-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F177260589
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 13:26:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, clemens@ladisch.de
Cc: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The attenuation UPDATE bits were not handled correctly on volume updates.
Fix this by implementing volume control .get and .put callbacks.

Furthermore, the DAC has two attenuation registers (LSB and MSB) per channel.
Hide this details from the user and provide a single volume control widget
(with proper dB scale) per channel.

Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
---
 sound/soc/codecs/wm8741.c | 90 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 36ef91f..cd3edc0 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -61,33 +61,95 @@ static const struct reg_default wm8741_reg_defaults[] = {
 	{ 32, 0x0002 },     /* R32 - ADDITONAL_CONTROL_1 */
 };
 
+static unsigned int _wm8741_volume_get(struct snd_soc_codec *codec,
+		struct soc_mixer_control *mc, unsigned int lsb_reg)
+{
+	unsigned int msb_reg = lsb_reg + 1;
+	unsigned int mask = mc->max;
+	unsigned int val = (snd_soc_read(codec, lsb_reg) |
+			(snd_soc_read(codec, msb_reg) << mc->shift)) & mask;
+
+	if (mc->invert)
+		val = mc->max - val;
+
+	return val;
+}
+
+static int _wm8741_volume_set(struct snd_soc_codec *codec,
+		struct soc_mixer_control *mc, unsigned int lsb_reg,
+		unsigned int val)
+{
+	unsigned int msb_reg = lsb_reg + 1;
+	unsigned int upd = (1 << mc->shift);
+	unsigned int mask = upd - 1;
+
+	if (mc->invert)
+		val = mc->max - val;
+
+	snd_soc_write(codec, lsb_reg, val & mask);
+	snd_soc_write(codec, msb_reg, (val >> mc->shift) | upd);
+
+	return 0;
+}
+
 static int wm8741_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, WM8741_RESET, 0);
 }
 
-static const DECLARE_TLV_DB_SCALE(dac_tlv_fine, -12700, 13, 0);
-static const DECLARE_TLV_DB_SCALE(dac_tlv, -12700, 400, 0);
+static int wm8741_volume_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct soc_mixer_control *mc =
+			(struct soc_mixer_control *)kcontrol->private_value;
+
+	ucontrol->value.integer.value[0] =
+			_wm8741_volume_get(codec, mc, mc->reg);
+
+	if (snd_soc_volsw_is_stereo(mc))
+		ucontrol->value.integer.value[1] =
+				_wm8741_volume_get(codec, mc, mc->rreg);
+
+	return 0;
+}
+
+static int wm8741_volume_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct soc_mixer_control *mc =
+			(struct soc_mixer_control *)kcontrol->private_value;
+
+	_wm8741_volume_set(codec, mc, mc->reg,
+			ucontrol->value.integer.value[0]);
+
+	if (snd_soc_volsw_is_stereo(mc))
+		_wm8741_volume_set(codec, mc, mc->rreg,
+				ucontrol->value.integer.value[1]);
+
+	return 0;
+}
+
+static const DECLARE_TLV_DB_MINMAX_MUTE(wm8741_vol_tlv, -12788, 0);
 
 static const struct snd_kcontrol_new wm8741_snd_controls_stereo[] = {
-SOC_DOUBLE_R_TLV("Fine Playback Volume", WM8741_DACLLSB_ATTENUATION,
-		 WM8741_DACRLSB_ATTENUATION, 1, 255, 1, dac_tlv_fine),
-SOC_DOUBLE_R_TLV("Playback Volume", WM8741_DACLMSB_ATTENUATION,
-		 WM8741_DACRMSB_ATTENUATION, 0, 511, 1, dac_tlv),
+SOC_DOUBLE_R_EXT_TLV("Playback Volume",
+		WM8741_DACLLSB_ATTENUATION, WM8741_DACRLSB_ATTENUATION,
+		WM8741_UPDATELL_SHIFT, 0x3ff, 1,
+		wm8741_volume_get, wm8741_volume_set, wm8741_vol_tlv),
 };
 
 static const struct snd_kcontrol_new wm8741_snd_controls_mono_left[] = {
-SOC_SINGLE_TLV("Fine Playback Volume", WM8741_DACLLSB_ATTENUATION,
-		 1, 255, 1, dac_tlv_fine),
-SOC_SINGLE_TLV("Playback Volume", WM8741_DACLMSB_ATTENUATION,
-		 0, 511, 1, dac_tlv),
+SOC_SINGLE_EXT_TLV("Playback Volume", WM8741_DACLLSB_ATTENUATION,
+		WM8741_UPDATELL_SHIFT, 0x3ff, 1,
+		wm8741_volume_get, wm8741_volume_set, wm8741_vol_tlv),
 };
 
 static const struct snd_kcontrol_new wm8741_snd_controls_mono_right[] = {
-SOC_SINGLE_TLV("Fine Playback Volume", WM8741_DACRLSB_ATTENUATION,
-		1, 255, 1, dac_tlv_fine),
-SOC_SINGLE_TLV("Playback Volume", WM8741_DACRMSB_ATTENUATION,
-		0, 511, 1, dac_tlv),
+SOC_SINGLE_EXT_TLV("Playback Volume", WM8741_DACRLSB_ATTENUATION,
+		WM8741_UPDATERL_SHIFT, 0x3ff, 1,
+		wm8741_volume_get, wm8741_volume_set, wm8741_vol_tlv),
 };
 
 static const struct snd_soc_dapm_widget wm8741_dapm_widgets[] = {
-- 
2.5.0
