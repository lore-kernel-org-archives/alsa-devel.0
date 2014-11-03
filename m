From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: wm9712/wm9713: Replace virtual
	registers with custom put/get callbacks
Date: Mon,  3 Nov 2014 19:33:03 +0100
Message-ID: <1415039583-4858-3-git-send-email-lars@metafoo.de>
References: <1415039583-4858-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-249.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ABB726050A
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 19:33:07 +0100 (CET)
In-Reply-To: <1415039583-4858-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm9712/wm9713 has separate mixers for the left and the right channel,
but the inputs to the mixers are enabled/disabled by the same control.
Currently this is implemented by the driver by registering two virtual
controls for each physical control, one for the left mixer and one for the
right mixer.

Using virtual registers will no longer work when the driver has
been converted to regmap. This patch converts the driver to use controls
with custom put/get callbacks instead which implement the logic making sure
that the physical control is unmuted when either the left or the right
control is unmuted.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9712.c | 163 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/wm9713.c | 153 +++++++++++++++++++++++++------------------
 2 files changed, 194 insertions(+), 122 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index f3aab6e..3fad37e 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -23,6 +23,11 @@
 #include <sound/tlv.h>
 #include "wm9712.h"
 
+struct wm9712_priv {
+	unsigned int hp_mixer[2];
+	struct mutex lock;
+};
+
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg);
 static int ac97_write(struct snd_soc_codec *codec,
@@ -48,12 +53,10 @@ static const u16 wm9712_reg[] = {
 	0x0000, 0x0000, 0x0000, 0x0000, /* 6e */
 	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
 	0x0001, 0x0000, 0x574d, 0x4c12, /* 7e */
-	0x0000, 0x0000 /* virtual hp mixers */
 };
 
-/* virtual HP mixers regs */
-#define HPL_MIXER	0x80
-#define HPR_MIXER	0x82
+#define HPL_MIXER	0x0
+#define HPR_MIXER	0x1
 
 static const char *wm9712_alc_select[] = {"None", "Left", "Right", "Stereo"};
 static const char *wm9712_alc_mux[] = {"Stereo", "Left", "Right", "None"};
@@ -157,75 +160,108 @@ SOC_SINGLE_TLV("Mic 2 Volume", AC97_MIC, 0, 31, 1, main_tlv),
 SOC_SINGLE_TLV("Mic Boost Volume", AC97_MIC, 7, 1, 0, boost_tlv),
 };
 
+static const unsigned int wm9712_mixer_mute_regs[] = {
+	AC97_VIDEO,
+	AC97_PCM,
+	AC97_LINE,
+	AC97_PHONE,
+	AC97_CD,
+	AC97_PC_BEEP,
+};
+
 /* We have to create a fake left and right HP mixers because
  * the codec only has a single control that is shared by both channels.
  * This makes it impossible to determine the audio path.
  */
-static int mixer_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
+static int wm9712_hp_mixer_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
 {
-	u16 l, r, beep, line, phone, mic, pcm, aux;
-
-	l = ac97_read(w->codec, HPL_MIXER);
-	r = ac97_read(w->codec, HPR_MIXER);
-	beep = ac97_read(w->codec, AC97_PC_BEEP);
-	mic = ac97_read(w->codec, AC97_VIDEO);
-	phone = ac97_read(w->codec, AC97_PHONE);
-	line = ac97_read(w->codec, AC97_LINE);
-	pcm = ac97_read(w->codec, AC97_PCM);
-	aux = ac97_read(w->codec, AC97_CD);
-
-	if (l & 0x1 || r & 0x1)
-		ac97_write(w->codec, AC97_VIDEO, mic & 0x7fff);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = ucontrol->value.enumerated.item[0];
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int mixer, mask, shift, old;
+	struct snd_soc_dapm_update update;
+	bool change;
+
+	mixer = mc->shift >> 8;
+	shift = mc->shift & 0xff;
+	mask = 1 << shift;
+
+	mutex_lock(&wm9712->lock);
+	old = wm9712->hp_mixer[mixer];
+	if (ucontrol->value.enumerated.item[0])
+		wm9712->hp_mixer[mixer] |= mask;
 	else
-		ac97_write(w->codec, AC97_VIDEO, mic | 0x8000);
+		wm9712->hp_mixer[mixer] &= ~mask;
+
+	change = old != wm9712->hp_mixer[mixer];
+	if (change) {
+		update.kcontrol = kcontrol;
+		update.reg = wm9712_mixer_mute_regs[shift];
+		update.mask = 0x8000;
+		if ((wm9712->hp_mixer[0] & mask) ||
+		    (wm9712->hp_mixer[1] & mask))
+			update.val = 0x0;
+		else
+			update.val = 0x8000;
+
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, val,
+			&update);
+	}
 
-	if (l & 0x2 || r & 0x2)
-		ac97_write(w->codec, AC97_PCM, pcm & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PCM, pcm | 0x8000);
+	mutex_unlock(&wm9712->lock);
 
-	if (l & 0x4 || r & 0x4)
-		ac97_write(w->codec, AC97_LINE, line & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_LINE, line | 0x8000);
+	return change;
+}
 
-	if (l & 0x8 || r & 0x8)
-		ac97_write(w->codec, AC97_PHONE, phone & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PHONE, phone | 0x8000);
+static int wm9712_hp_mixer_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
+	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int shift, mixer;
 
-	if (l & 0x10 || r & 0x10)
-		ac97_write(w->codec, AC97_CD, aux & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_CD, aux | 0x8000);
+	mixer = mc->shift >> 8;
+	shift = mc->shift & 0xff;
 
-	if (l & 0x20 || r & 0x20)
-		ac97_write(w->codec, AC97_PC_BEEP, beep & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PC_BEEP, beep | 0x8000);
+	ucontrol->value.enumerated.item[0] =
+		(wm9712->hp_mixer[mixer] >> shift) & 1;
 
 	return 0;
 }
 
+#define WM9712_HP_MIXER_CTRL(xname, xmixer, xshift) { \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = wm9712_hp_mixer_get, .put = wm9712_hp_mixer_put, \
+	.private_value = SOC_SINGLE_VALUE(SND_SOC_NOPM, \
+		(xmixer << 8) | xshift, 1, 0, 0) \
+}
+
 /* Left Headphone Mixers */
 static const struct snd_kcontrol_new wm9712_hpl_mixer_controls[] = {
-	SOC_DAPM_SINGLE("PCBeep Bypass Switch", HPL_MIXER, 5, 1, 0),
-	SOC_DAPM_SINGLE("Aux Playback Switch", HPL_MIXER, 4, 1, 0),
-	SOC_DAPM_SINGLE("Phone Bypass Switch", HPL_MIXER, 3, 1, 0),
-	SOC_DAPM_SINGLE("Line Bypass Switch", HPL_MIXER, 2, 1, 0),
-	SOC_DAPM_SINGLE("PCM Playback Switch", HPL_MIXER, 1, 1, 0),
-	SOC_DAPM_SINGLE("Mic Sidetone Switch", HPL_MIXER, 0, 1, 0),
+	WM9712_HP_MIXER_CTRL("PCBeep Bypass Switch", HPL_MIXER, 5),
+	WM9712_HP_MIXER_CTRL("Aux Playback Switch", HPL_MIXER, 4),
+	WM9712_HP_MIXER_CTRL("Phone Bypass Switch", HPL_MIXER, 3),
+	WM9712_HP_MIXER_CTRL("Line Bypass Switch", HPL_MIXER, 2),
+	WM9712_HP_MIXER_CTRL("PCM Playback Switch", HPL_MIXER, 1),
+	WM9712_HP_MIXER_CTRL("Mic Sidetone Switch", HPL_MIXER, 0),
 };
 
 /* Right Headphone Mixers */
 static const struct snd_kcontrol_new wm9712_hpr_mixer_controls[] = {
-	SOC_DAPM_SINGLE("PCBeep Bypass Switch", HPR_MIXER, 5, 1, 0),
-	SOC_DAPM_SINGLE("Aux Playback Switch", HPR_MIXER, 4, 1, 0),
-	SOC_DAPM_SINGLE("Phone Bypass Switch", HPR_MIXER, 3, 1, 0),
-	SOC_DAPM_SINGLE("Line Bypass Switch", HPR_MIXER, 2, 1, 0),
-	SOC_DAPM_SINGLE("PCM Playback Switch", HPR_MIXER, 1, 1, 0),
-	SOC_DAPM_SINGLE("Mic Sidetone Switch", HPR_MIXER, 0, 1, 0),
+	WM9712_HP_MIXER_CTRL("PCBeep Bypass Switch", HPR_MIXER, 5),
+	WM9712_HP_MIXER_CTRL("Aux Playback Switch", HPR_MIXER, 4),
+	WM9712_HP_MIXER_CTRL("Phone Bypass Switch", HPR_MIXER, 3),
+	WM9712_HP_MIXER_CTRL("Line Bypass Switch", HPR_MIXER, 2),
+	WM9712_HP_MIXER_CTRL("PCM Playback Switch", HPR_MIXER, 1),
+	WM9712_HP_MIXER_CTRL("Mic Sidetone Switch", HPR_MIXER, 0),
 };
 
 /* Speaker Mixer */
@@ -299,12 +335,10 @@ SND_SOC_DAPM_MUX("Right Mic Select Source", SND_SOC_NOPM, 0, 0,
 SND_SOC_DAPM_MUX("Differential Source", SND_SOC_NOPM, 0, 0,
 	&wm9712_diff_sel_controls),
 SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
-SND_SOC_DAPM_MIXER_E("Left HP Mixer", AC97_INT_PAGING, 9, 1,
-	&wm9712_hpl_mixer_controls[0], ARRAY_SIZE(wm9712_hpl_mixer_controls),
-	mixer_event, SND_SOC_DAPM_POST_REG),
-SND_SOC_DAPM_MIXER_E("Right HP Mixer", AC97_INT_PAGING, 8, 1,
-	&wm9712_hpr_mixer_controls[0], ARRAY_SIZE(wm9712_hpr_mixer_controls),
-	 mixer_event, SND_SOC_DAPM_POST_REG),
+SND_SOC_DAPM_MIXER("Left HP Mixer", AC97_INT_PAGING, 9, 1,
+	&wm9712_hpl_mixer_controls[0], ARRAY_SIZE(wm9712_hpl_mixer_controls)),
+SND_SOC_DAPM_MIXER("Right HP Mixer", AC97_INT_PAGING, 8, 1,
+	&wm9712_hpr_mixer_controls[0], ARRAY_SIZE(wm9712_hpr_mixer_controls)),
 SND_SOC_DAPM_MIXER("Phone Mixer", AC97_INT_PAGING, 6, 1,
 	&wm9712_phone_mixer_controls[0], ARRAY_SIZE(wm9712_phone_mixer_controls)),
 SND_SOC_DAPM_MIXER("Speaker Mixer", AC97_INT_PAGING, 7, 1,
@@ -471,8 +505,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 
-	if (reg < 0x7c)
-		soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9712_reg)))
 		cache[reg] = val;
@@ -684,6 +717,16 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 
 static int wm9712_probe(struct platform_device *pdev)
 {
+	struct wm9712_priv *wm9712;
+
+	wm9712 = devm_kzalloc(&pdev->dev, sizeof(*wm9712), GFP_KERNEL);
+	if (wm9712 == NULL)
+		return -ENOMEM;
+
+	mutex_init(&wm9712->lock);
+
+	platform_set_drvdata(pdev, wm9712);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
 }
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index ac13fc8..998e4c7 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -31,6 +31,8 @@
 
 struct wm9713_priv {
 	u32 pll_in; /* PLL input frequency */
+	unsigned int hp_mixer[2];
+	struct mutex lock;
 };
 
 static unsigned int ac97_read(struct snd_soc_codec *codec,
@@ -59,12 +61,10 @@ static const u16 wm9713_reg[] = {
 	0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0006,
 	0x0001, 0x0000, 0x574d, 0x4c13,
-	0x0000, 0x0000
 };
 
-/* virtual HP mixers regs */
-#define HPL_MIXER	0x80
-#define HPR_MIXER	0x82
+#define HPL_MIXER 0
+#define HPR_MIXER 1
 
 static const char *wm9713_mic_mixer[] = {"Stereo", "Mic 1", "Mic 2", "Mute"};
 static const char *wm9713_rec_mux[] = {"Stereo", "Left", "Right", "Mute"};
@@ -233,6 +233,14 @@ static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const unsigned int wm9713_mixer_mute_regs[] = {
+	AC97_PC_BEEP,
+	AC97_MASTER_TONE,
+	AC97_PHONE,
+	AC97_REC_SEL,
+	AC97_PCM,
+	AC97_AUX,
+};
 
 /* We have to create a fake left and right HP mixers because
  * the codec only has a single control that is shared by both channels.
@@ -240,73 +248,95 @@ static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
  * register map, thus we add a new (virtual) register to help determine the
  * audio route within the device.
  */
-static int mixer_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
+static int wm9713_hp_mixer_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
 {
-	u16 l, r, beep, tone, phone, rec, pcm, aux;
-
-	l = ac97_read(w->codec, HPL_MIXER);
-	r = ac97_read(w->codec, HPR_MIXER);
-	beep = ac97_read(w->codec, AC97_PC_BEEP);
-	tone = ac97_read(w->codec, AC97_MASTER_TONE);
-	phone = ac97_read(w->codec, AC97_PHONE);
-	rec = ac97_read(w->codec, AC97_REC_SEL);
-	pcm = ac97_read(w->codec, AC97_PCM);
-	aux = ac97_read(w->codec, AC97_AUX);
-
-	if (event & SND_SOC_DAPM_PRE_REG)
-		return 0;
-	if ((l & 0x1) || (r & 0x1))
-		ac97_write(w->codec, AC97_PC_BEEP, beep & 0x7fff);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val = ucontrol->value.enumerated.item[0];
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int mixer, mask, shift, old;
+	struct snd_soc_dapm_update update;
+	bool change;
+
+	mixer = mc->shift >> 8;
+	shift = mc->shift & 0xff;
+	mask = (1 << shift);
+
+	mutex_lock(&wm9713->lock);
+	old = wm9713->hp_mixer[mixer];
+	if (ucontrol->value.enumerated.item[0])
+		wm9713->hp_mixer[mixer] |= mask;
 	else
-		ac97_write(w->codec, AC97_PC_BEEP, beep | 0x8000);
+		wm9713->hp_mixer[mixer] &= ~mask;
+
+	change = old != wm9713->hp_mixer[mixer];
+	if (change) {
+		update.kcontrol = kcontrol;
+		update.reg = wm9713_mixer_mute_regs[shift];
+		update.mask = 0x8000;
+		if ((wm9713->hp_mixer[0] & mask) ||
+		    (wm9713->hp_mixer[1] & mask))
+			update.val = 0x0;
+		else
+			update.val = 0x8000;
+
+		snd_soc_dapm_mixer_update_power(dapm, kcontrol, val,
+			&update);
+	}
 
-	if ((l & 0x2) || (r & 0x2))
-		ac97_write(w->codec, AC97_MASTER_TONE, tone & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_MASTER_TONE, tone | 0x8000);
+	mutex_unlock(&wm9713->lock);
 
-	if ((l & 0x4) || (r & 0x4))
-		ac97_write(w->codec, AC97_PHONE, phone & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PHONE, phone | 0x8000);
+	return change;
+}
 
-	if ((l & 0x8) || (r & 0x8))
-		ac97_write(w->codec, AC97_REC_SEL, rec & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_REC_SEL, rec | 0x8000);
+static int wm9713_hp_mixer_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int mixer, shift;
 
-	if ((l & 0x10) || (r & 0x10))
-		ac97_write(w->codec, AC97_PCM, pcm & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PCM, pcm | 0x8000);
+	mixer = mc->shift >> 8;
+	shift = mc->shift & 0xff;
 
-	if ((l & 0x20) || (r & 0x20))
-		ac97_write(w->codec, AC97_AUX, aux & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_AUX, aux | 0x8000);
+	ucontrol->value.enumerated.item[0] =
+		(wm9713->hp_mixer[mixer] >> shift) & 1;
 
 	return 0;
 }
 
+#define WM9713_HP_MIXER_CTRL(xname, xmixer, xshift) { \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = wm9713_hp_mixer_get, .put = wm9713_hp_mixer_put, \
+	.private_value = SOC_DOUBLE_VALUE(SND_SOC_NOPM, \
+		xshift, xmixer, 1, 0, 0) \
+}
+
 /* Left Headphone Mixers */
 static const struct snd_kcontrol_new wm9713_hpl_mixer_controls[] = {
-SOC_DAPM_SINGLE("Beep Playback Switch", HPL_MIXER, 5, 1, 0),
-SOC_DAPM_SINGLE("Voice Playback Switch", HPL_MIXER, 4, 1, 0),
-SOC_DAPM_SINGLE("Aux Playback Switch", HPL_MIXER, 3, 1, 0),
-SOC_DAPM_SINGLE("PCM Playback Switch", HPL_MIXER, 2, 1, 0),
-SOC_DAPM_SINGLE("MonoIn Playback Switch", HPL_MIXER, 1, 1, 0),
-SOC_DAPM_SINGLE("Bypass Playback Switch", HPL_MIXER, 0, 1, 0),
+WM9713_HP_MIXER_CTRL("Beep Playback Switch", HPL_MIXER, 5),
+WM9713_HP_MIXER_CTRL("Voice Playback Switch", HPL_MIXER, 4),
+WM9713_HP_MIXER_CTRL("Aux Playback Switch", HPL_MIXER, 3),
+WM9713_HP_MIXER_CTRL("PCM Playback Switch", HPL_MIXER, 2),
+WM9713_HP_MIXER_CTRL("MonoIn Playback Switch", HPL_MIXER, 1),
+WM9713_HP_MIXER_CTRL("Bypass Playback Switch", HPL_MIXER, 0),
 };
 
 /* Right Headphone Mixers */
 static const struct snd_kcontrol_new wm9713_hpr_mixer_controls[] = {
-SOC_DAPM_SINGLE("Beep Playback Switch", HPR_MIXER, 5, 1, 0),
-SOC_DAPM_SINGLE("Voice Playback Switch", HPR_MIXER, 4, 1, 0),
-SOC_DAPM_SINGLE("Aux Playback Switch", HPR_MIXER, 3, 1, 0),
-SOC_DAPM_SINGLE("PCM Playback Switch", HPR_MIXER, 2, 1, 0),
-SOC_DAPM_SINGLE("MonoIn Playback Switch", HPR_MIXER, 1, 1, 0),
-SOC_DAPM_SINGLE("Bypass Playback Switch", HPR_MIXER, 0, 1, 0),
+WM9713_HP_MIXER_CTRL("Beep Playback Switch", HPR_MIXER, 5),
+WM9713_HP_MIXER_CTRL("Voice Playback Switch", HPR_MIXER, 4),
+WM9713_HP_MIXER_CTRL("Aux Playback Switch", HPR_MIXER, 3),
+WM9713_HP_MIXER_CTRL("PCM Playback Switch", HPR_MIXER, 2),
+WM9713_HP_MIXER_CTRL("MonoIn Playback Switch", HPR_MIXER, 1),
+WM9713_HP_MIXER_CTRL("Bypass Playback Switch", HPR_MIXER, 0),
 };
 
 /* headphone capture mux */
@@ -428,12 +458,10 @@ SND_SOC_DAPM_MUX("Mic A Source", SND_SOC_NOPM, 0, 0,
 	&wm9713_mic_sel_mux_controls),
 SND_SOC_DAPM_MUX("Mic B Source", SND_SOC_NOPM, 0, 0,
 	&wm9713_micb_sel_mux_controls),
-SND_SOC_DAPM_MIXER_E("Left HP Mixer", AC97_EXTENDED_MID, 3, 1,
-	&wm9713_hpl_mixer_controls[0], ARRAY_SIZE(wm9713_hpl_mixer_controls),
-	mixer_event, SND_SOC_DAPM_POST_REG),
-SND_SOC_DAPM_MIXER_E("Right HP Mixer", AC97_EXTENDED_MID, 2, 1,
-	&wm9713_hpr_mixer_controls[0], ARRAY_SIZE(wm9713_hpr_mixer_controls),
-	mixer_event, SND_SOC_DAPM_POST_REG),
+SND_SOC_DAPM_MIXER("Left HP Mixer", AC97_EXTENDED_MID, 3, 1,
+	&wm9713_hpl_mixer_controls[0], ARRAY_SIZE(wm9713_hpl_mixer_controls)),
+SND_SOC_DAPM_MIXER("Right HP Mixer", AC97_EXTENDED_MID, 2, 1,
+	&wm9713_hpr_mixer_controls[0], ARRAY_SIZE(wm9713_hpr_mixer_controls)),
 SND_SOC_DAPM_MIXER("Mono Mixer", AC97_EXTENDED_MID, 0, 1,
 	&wm9713_mono_mixer_controls[0], ARRAY_SIZE(wm9713_mono_mixer_controls)),
 SND_SOC_DAPM_MIXER("Speaker Mixer", AC97_EXTENDED_MID, 1, 1,
@@ -666,8 +694,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
 	u16 *cache = codec->reg_cache;
-	if (reg < 0x7c)
-		soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9713_reg)))
 		cache[reg] = val;
@@ -1251,6 +1278,8 @@ static int wm9713_probe(struct platform_device *pdev)
 	if (wm9713 == NULL)
 		return -ENOMEM;
 
+	mutex_init(&wm9713->lock);
+
 	platform_set_drvdata(pdev, wm9713);
 
 	return snd_soc_register_codec(&pdev->dev,
-- 
1.8.0
