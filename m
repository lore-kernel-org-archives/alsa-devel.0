From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/14] ASoC: wm9712/wm9713: Use shared controls
Date: Thu, 30 Oct 2014 21:01:11 +0100
Message-ID: <1414699271-22797-15-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F82626545F
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:23 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm9712/wm9713 has separate mixers for the left and the right channel,
but the inputs to the mixers are enabled/disabled by the same control.
Currently this is implemented by the driver by registering two virtual
controls for each physical control, one for the left mixer and one for the
right mixer.

This patch converts the driver to use the shared control feature of the ASoC
core which allows to use the same control for multiple mixers. This allows
the removal of the virtual controls and their virtual registers.

Note: This changes the exposed controls, instead of having one "Left HP
Mixer ..." and one "Right HP Mixer ..." control for each input there will
only be a single "HP Mixer ..." control.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9712.c | 119 ++++++++++-----------------------------------
 sound/soc/codecs/wm9713.c | 121 +++++++++-------------------------------------
 2 files changed, 49 insertions(+), 191 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index f3aab6e..4ef44bf 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -48,13 +48,8 @@ static const u16 wm9712_reg[] = {
 	0x0000, 0x0000, 0x0000, 0x0000, /* 6e */
 	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
 	0x0001, 0x0000, 0x574d, 0x4c12, /* 7e */
-	0x0000, 0x0000 /* virtual hp mixers */
 };
 
-/* virtual HP mixers regs */
-#define HPL_MIXER	0x80
-#define HPR_MIXER	0x82
-
 static const char *wm9712_alc_select[] = {"None", "Left", "Right", "Stereo"};
 static const char *wm9712_alc_mux[] = {"Stereo", "Left", "Right", "None"};
 static const char *wm9712_out3_src[] = {"Left", "VREF", "Left + Right",
@@ -157,75 +152,14 @@ SOC_SINGLE_TLV("Mic 2 Volume", AC97_MIC, 0, 31, 1, main_tlv),
 SOC_SINGLE_TLV("Mic Boost Volume", AC97_MIC, 7, 1, 0, boost_tlv),
 };
 
-/* We have to create a fake left and right HP mixers because
- * the codec only has a single control that is shared by both channels.
- * This makes it impossible to determine the audio path.
- */
-static int mixer_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int event)
-{
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
-	else
-		ac97_write(w->codec, AC97_VIDEO, mic | 0x8000);
-
-	if (l & 0x2 || r & 0x2)
-		ac97_write(w->codec, AC97_PCM, pcm & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PCM, pcm | 0x8000);
-
-	if (l & 0x4 || r & 0x4)
-		ac97_write(w->codec, AC97_LINE, line & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_LINE, line | 0x8000);
-
-	if (l & 0x8 || r & 0x8)
-		ac97_write(w->codec, AC97_PHONE, phone & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PHONE, phone | 0x8000);
-
-	if (l & 0x10 || r & 0x10)
-		ac97_write(w->codec, AC97_CD, aux & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_CD, aux | 0x8000);
-
-	if (l & 0x20 || r & 0x20)
-		ac97_write(w->codec, AC97_PC_BEEP, beep & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PC_BEEP, beep | 0x8000);
-
-	return 0;
-}
-
-/* Left Headphone Mixers */
-static const struct snd_kcontrol_new wm9712_hpl_mixer_controls[] = {
-	SOC_DAPM_SINGLE("PCBeep Bypass Switch", HPL_MIXER, 5, 1, 0),
-	SOC_DAPM_SINGLE("Aux Playback Switch", HPL_MIXER, 4, 1, 0),
-	SOC_DAPM_SINGLE("Phone Bypass Switch", HPL_MIXER, 3, 1, 0),
-	SOC_DAPM_SINGLE("Line Bypass Switch", HPL_MIXER, 2, 1, 0),
-	SOC_DAPM_SINGLE("PCM Playback Switch", HPL_MIXER, 1, 1, 0),
-	SOC_DAPM_SINGLE("Mic Sidetone Switch", HPL_MIXER, 0, 1, 0),
-};
-
-/* Right Headphone Mixers */
-static const struct snd_kcontrol_new wm9712_hpr_mixer_controls[] = {
-	SOC_DAPM_SINGLE("PCBeep Bypass Switch", HPR_MIXER, 5, 1, 0),
-	SOC_DAPM_SINGLE("Aux Playback Switch", HPR_MIXER, 4, 1, 0),
-	SOC_DAPM_SINGLE("Phone Bypass Switch", HPR_MIXER, 3, 1, 0),
-	SOC_DAPM_SINGLE("Line Bypass Switch", HPR_MIXER, 2, 1, 0),
-	SOC_DAPM_SINGLE("PCM Playback Switch", HPR_MIXER, 1, 1, 0),
-	SOC_DAPM_SINGLE("Mic Sidetone Switch", HPR_MIXER, 0, 1, 0),
+/* Headphone Mixers */
+static const struct snd_kcontrol_new wm9712_hp_mixer_controls[] = {
+	SOC_DAPM_SINGLE("HP Mixer PCBeep Bypass Switch", AC97_PC_BEEP, 15, 1, 1),
+	SOC_DAPM_SINGLE("HP Mixer Aux Playback Switch", AC97_CD, 15, 1, 1),
+	SOC_DAPM_SINGLE("HP Mixer Phone Bypass Switch", AC97_PHONE, 15, 1, 1),
+	SOC_DAPM_SINGLE("HP Mixer Line Bypass Switch", AC97_LINE, 15, 1, 1),
+	SOC_DAPM_SINGLE("HP Mixer PCM Playback Switch", AC97_PCM, 15, 1, 1),
+	SOC_DAPM_SINGLE("HP Mixer Mic Sidetone Switch", AC97_VIDEO, 15, 1, 1),
 };
 
 /* Speaker Mixer */
@@ -299,12 +233,10 @@ SND_SOC_DAPM_MUX("Right Mic Select Source", SND_SOC_NOPM, 0, 0,
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
+	wm9712_hp_mixer_controls, ARRAY_SIZE(wm9712_hp_mixer_controls)),
+SND_SOC_DAPM_MIXER("Right HP Mixer", AC97_INT_PAGING, 8, 1,
+	wm9712_hp_mixer_controls, ARRAY_SIZE(wm9712_hp_mixer_controls)),
 SND_SOC_DAPM_MIXER("Phone Mixer", AC97_INT_PAGING, 6, 1,
 	&wm9712_phone_mixer_controls[0], ARRAY_SIZE(wm9712_phone_mixer_controls)),
 SND_SOC_DAPM_MIXER("Speaker Mixer", AC97_INT_PAGING, 7, 1,
@@ -344,21 +276,21 @@ static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 	{"AC97 Mixer", NULL, "Right DAC"},
 
 	/* Left HP mixer */
-	{"Left HP Mixer", "PCBeep Bypass Switch", "PCBEEP"},
-	{"Left HP Mixer", "Aux Playback Switch",  "Aux DAC"},
-	{"Left HP Mixer", "Phone Bypass Switch",  "Phone PGA"},
-	{"Left HP Mixer", "Line Bypass Switch",   "Line PGA"},
-	{"Left HP Mixer", "PCM Playback Switch",  "Left DAC"},
-	{"Left HP Mixer", "Mic Sidetone Switch",  "Mic PGA"},
+	{"Left HP Mixer", "HP Mixer PCBeep Bypass Switch", "PCBEEP"},
+	{"Left HP Mixer", "HP Mixer Aux Playback Switch",  "Aux DAC"},
+	{"Left HP Mixer", "HP Mixer Phone Bypass Switch",  "Phone PGA"},
+	{"Left HP Mixer", "HP Mixer Line Bypass Switch",   "Line PGA"},
+	{"Left HP Mixer", "HP Mixer PCM Playback Switch",  "Left DAC"},
+	{"Left HP Mixer", "HP Mixer Mic Sidetone Switch",  "Mic PGA"},
 	{"Left HP Mixer", NULL,  "ALC Sidetone Mux"},
 
 	/* Right HP mixer */
-	{"Right HP Mixer", "PCBeep Bypass Switch", "PCBEEP"},
-	{"Right HP Mixer", "Aux Playback Switch",  "Aux DAC"},
-	{"Right HP Mixer", "Phone Bypass Switch",  "Phone PGA"},
-	{"Right HP Mixer", "Line Bypass Switch",   "Line PGA"},
-	{"Right HP Mixer", "PCM Playback Switch",  "Right DAC"},
-	{"Right HP Mixer", "Mic Sidetone Switch",  "Mic PGA"},
+	{"Right HP Mixer", "HP Mixer PCBeep Bypass Switch", "PCBEEP"},
+	{"Right HP Mixer", "HP Mixer Aux Playback Switch",  "Aux DAC"},
+	{"Right HP Mixer", "HP Mixer Phone Bypass Switch",  "Phone PGA"},
+	{"Right HP Mixer", "HP Mixer Line Bypass Switch",   "Line PGA"},
+	{"Right HP Mixer", "HP Mixer PCM Playback Switch",  "Right DAC"},
+	{"Right HP Mixer", "HP Mixer Mic Sidetone Switch",  "Mic PGA"},
 	{"Right HP Mixer", NULL,  "ALC Sidetone Mux"},
 
 	/* speaker mixer */
@@ -471,8 +403,7 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	u16 *cache = codec->reg_cache;
 
-	if (reg < 0x7c)
-		soc_ac97_ops->write(codec->ac97, reg, val);
+	soc_ac97_ops->write(codec->ac97, reg, val);
 	reg = reg >> 1;
 	if (reg < (ARRAY_SIZE(wm9712_reg)))
 		cache[reg] = val;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index ac13fc8..cb2bf6c 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -59,13 +59,8 @@ static const u16 wm9713_reg[] = {
 	0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0006,
 	0x0001, 0x0000, 0x574d, 0x4c13,
-	0x0000, 0x0000
 };
 
-/* virtual HP mixers regs */
-#define HPL_MIXER	0x80
-#define HPR_MIXER	0x82
-
 static const char *wm9713_mic_mixer[] = {"Stereo", "Mic 1", "Mic 2", "Mute"};
 static const char *wm9713_rec_mux[] = {"Stereo", "Left", "Right", "Mute"};
 static const char *wm9713_rec_src[] =
@@ -233,80 +228,14 @@ static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-
-/* We have to create a fake left and right HP mixers because
- * the codec only has a single control that is shared by both channels.
- * This makes it impossible to determine the audio path using the current
- * register map, thus we add a new (virtual) register to help determine the
- * audio route within the device.
- */
-static int mixer_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
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
-	else
-		ac97_write(w->codec, AC97_PC_BEEP, beep | 0x8000);
-
-	if ((l & 0x2) || (r & 0x2))
-		ac97_write(w->codec, AC97_MASTER_TONE, tone & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_MASTER_TONE, tone | 0x8000);
-
-	if ((l & 0x4) || (r & 0x4))
-		ac97_write(w->codec, AC97_PHONE, phone & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PHONE, phone | 0x8000);
-
-	if ((l & 0x8) || (r & 0x8))
-		ac97_write(w->codec, AC97_REC_SEL, rec & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_REC_SEL, rec | 0x8000);
-
-	if ((l & 0x10) || (r & 0x10))
-		ac97_write(w->codec, AC97_PCM, pcm & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_PCM, pcm | 0x8000);
-
-	if ((l & 0x20) || (r & 0x20))
-		ac97_write(w->codec, AC97_AUX, aux & 0x7fff);
-	else
-		ac97_write(w->codec, AC97_AUX, aux | 0x8000);
-
-	return 0;
-}
-
-/* Left Headphone Mixers */
-static const struct snd_kcontrol_new wm9713_hpl_mixer_controls[] = {
-SOC_DAPM_SINGLE("Beep Playback Switch", HPL_MIXER, 5, 1, 0),
-SOC_DAPM_SINGLE("Voice Playback Switch", HPL_MIXER, 4, 1, 0),
-SOC_DAPM_SINGLE("Aux Playback Switch", HPL_MIXER, 3, 1, 0),
-SOC_DAPM_SINGLE("PCM Playback Switch", HPL_MIXER, 2, 1, 0),
-SOC_DAPM_SINGLE("MonoIn Playback Switch", HPL_MIXER, 1, 1, 0),
-SOC_DAPM_SINGLE("Bypass Playback Switch", HPL_MIXER, 0, 1, 0),
-};
-
-/* Right Headphone Mixers */
-static const struct snd_kcontrol_new wm9713_hpr_mixer_controls[] = {
-SOC_DAPM_SINGLE("Beep Playback Switch", HPR_MIXER, 5, 1, 0),
-SOC_DAPM_SINGLE("Voice Playback Switch", HPR_MIXER, 4, 1, 0),
-SOC_DAPM_SINGLE("Aux Playback Switch", HPR_MIXER, 3, 1, 0),
-SOC_DAPM_SINGLE("PCM Playback Switch", HPR_MIXER, 2, 1, 0),
-SOC_DAPM_SINGLE("MonoIn Playback Switch", HPR_MIXER, 1, 1, 0),
-SOC_DAPM_SINGLE("Bypass Playback Switch", HPR_MIXER, 0, 1, 0),
+/* Headphone Mixers */
+static const struct snd_kcontrol_new wm9713_hp_mixer_controls[] = {
+SOC_DAPM_SINGLE("HP Mixer Beep Playback Switch", AC97_AUX, 15, 1, 1),
+SOC_DAPM_SINGLE("HP Mixer Voice Playback Switch", AC97_PCM, 15, 1, 1),
+SOC_DAPM_SINGLE("HP Mixer Aux Playback Switch", AC97_REC_SEL, 15, 1, 1),
+SOC_DAPM_SINGLE("HP Mixer PCM Playback Switch", AC97_PHONE, 15, 1, 1),
+SOC_DAPM_SINGLE("HP Mixer MonoIn Playback Switch", AC97_MASTER_TONE, 15, 1, 1),
+SOC_DAPM_SINGLE("HP Mixer Bypass Playback Switch", AC97_PC_BEEP, 15, 1, 1),
 };
 
 /* headphone capture mux */
@@ -428,12 +357,10 @@ SND_SOC_DAPM_MUX("Mic A Source", SND_SOC_NOPM, 0, 0,
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
+	wm9713_hp_mixer_controls, ARRAY_SIZE(wm9713_hp_mixer_controls)),
+SND_SOC_DAPM_MIXER("Right HP Mixer", AC97_EXTENDED_MID, 2, 1,
+	wm9713_hp_mixer_controls, ARRAY_SIZE(wm9713_hp_mixer_controls)),
 SND_SOC_DAPM_MIXER("Mono Mixer", AC97_EXTENDED_MID, 0, 1,
 	&wm9713_mono_mixer_controls[0], ARRAY_SIZE(wm9713_mono_mixer_controls)),
 SND_SOC_DAPM_MIXER("Speaker Mixer", AC97_EXTENDED_MID, 1, 1,
@@ -488,21 +415,21 @@ SND_SOC_DAPM_VMID("VMID"),
 
 static const struct snd_soc_dapm_route wm9713_audio_map[] = {
 	/* left HP mixer */
-	{"Left HP Mixer", "Beep Playback Switch",    "PCBEEP"},
-	{"Left HP Mixer", "Voice Playback Switch",   "Voice DAC"},
-	{"Left HP Mixer", "Aux Playback Switch",     "Aux DAC"},
-	{"Left HP Mixer", "Bypass Playback Switch",  "Left Line In"},
-	{"Left HP Mixer", "PCM Playback Switch",     "Left DAC"},
-	{"Left HP Mixer", "MonoIn Playback Switch",  "Mono In"},
+	{"Left HP Mixer", "HP Mixer Beep Playback Switch",    "PCBEEP"},
+	{"Left HP Mixer", "HP Mixer Voice Playback Switch",   "Voice DAC"},
+	{"Left HP Mixer", "HP Mixer Aux Playback Switch",     "Aux DAC"},
+	{"Left HP Mixer", "HP Mixer Bypass Playback Switch",  "Left Line In"},
+	{"Left HP Mixer", "HP Mixer PCM Playback Switch",     "Left DAC"},
+	{"Left HP Mixer", "HP Mixer MonoIn Playback Switch",  "Mono In"},
 	{"Left HP Mixer", NULL,  "Capture Headphone Mux"},
 
 	/* right HP mixer */
-	{"Right HP Mixer", "Beep Playback Switch",    "PCBEEP"},
-	{"Right HP Mixer", "Voice Playback Switch",   "Voice DAC"},
-	{"Right HP Mixer", "Aux Playback Switch",     "Aux DAC"},
-	{"Right HP Mixer", "Bypass Playback Switch",  "Right Line In"},
-	{"Right HP Mixer", "PCM Playback Switch",     "Right DAC"},
-	{"Right HP Mixer", "MonoIn Playback Switch",  "Mono In"},
+	{"Right HP Mixer", "HP Mixer Beep Playback Switch",    "PCBEEP"},
+	{"Right HP Mixer", "HP Mixer Voice Playback Switch",   "Voice DAC"},
+	{"Right HP Mixer", "HP Mixer Aux Playback Switch",     "Aux DAC"},
+	{"Right HP Mixer", "HP Mixer Bypass Playback Switch",  "Right Line In"},
+	{"Right HP Mixer", "HP Mixer PCM Playback Switch",     "Right DAC"},
+	{"Right HP Mixer", "HP Mixer MonoIn Playback Switch",  "Mono In"},
 	{"Right HP Mixer", NULL,  "Capture Headphone Mux"},
 
 	/* virtual mixer - mixes left & right channels for spk and mono */
-- 
1.8.0
