From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] WM97xx AC97 codec controls
Date: Thu, 28 Jul 2005 20:26:30 +0100
Message-ID: <1122578790.5371.68.camel@localhost.localdomain>
References: <1121769565.6237.32.camel@cearnarfon>
	 <m28y02o6vm.fsf@vador.mandriva.com> <1121855229.14604.44.camel@cearnarfon>
	 <s5hd5p4lfyj.wl%tiwai@suse.de>
	 <1122565385.5371.55.camel@localhost.localdomain>
	 <s5hll3qdime.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3tjwsobxVTH/44vMcwNn"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll3qdime.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandriva.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-3tjwsobxVTH/44vMcwNn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-07-28 at 18:02 +0200, Takashi Iwai wrote:

> 
> - The standard control name for PCM volume is "PCM Playback Volume".
>   Ditto for Front, Rear, etc.  But I don't think it's necessary for
>   the controls like "Aux To Headphone" - the direction is not obvious
>   in such a case.
> 
>   Similarly, PCM switch should be "PCM Playback Switch".

Changed, we now have Playback. I can see where this can be confusing for
users. It's not something that has occurred to me in the past as my
users were other engineers. 

> 
>   Also, you don't have to be too nervous about "Switch" suffix.  It's
>   mandatory only if the volume control with same component exists, or
>   if its name is not obvious as a switch.

I think I've used it where's it's not obvious. There are a lot of signal
routing mutes on the wm97xx codecs and I think that "Switch" is probably
the best matching term. 

> 
> - PCM switch is supposed to be reversed from mute switch.  If it's 1,
>   PCM is turned ON.  Thus the last argument (invert) of AC97_SINGLE()
>   should be 0.
> 

It's the opposite in AC97. 1 = mute and 0 = on. Hence all of the mute
switches are inverted. Unless I misunderstood...

Changes:-
 
  o Enhanced current WM97xx support to provide additional controls and
use the kcontrol suffix naming convention.
  o Added AC97_HAS_NO_MIC, AC97_HAS_NO_TONE and AC97_HAS_NO_STD_PCM.
  o Cleaned up WM97xx related comments.
  o Removed some wm9713 double mono controls and replaced with stereo
controls.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam

--=-3tjwsobxVTH/44vMcwNn
Content-Disposition: attachment; filename=wm97xx-mixer.diff
Content-Type: text/x-patch; name=wm97xx-mixer.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -370,141 +370,387 @@ int patch_yamaha_ymf753(ac97_t * ac97)
  *  added support for WM9705,WM9708,WM9709,WM9710,WM9711,WM9712 and WM9717.
  */
 
-int patch_wolfson03(ac97_t * ac97)
+static const snd_kcontrol_new_t wm97xx_snd_ac97_controls[] = {
+AC97_DOUBLE("Front Playback Volume", AC97_WM97XX_FMIXER_VOL, 8, 0, 31, 1),
+AC97_SINGLE("Front Playback Switch", AC97_WM97XX_FMIXER_VOL, 15, 1, 1),
+};
+
+int patch_wolfson_wm9703_specific(ac97_t * ac97)
 {
 	/* This is known to work for the ViewSonic ViewPad 1000
-	   Randolph Bentson <bentson@holmsjoen.com> */
+	 * Randolph Bentson <bentson@holmsjoen.com>
+	 * WM9703/9707/9708/9717 
+	 */
+	int err, i;
+	
+	for (i = 0; i < ARRAY_SIZE(wm97xx_snd_ac97_controls); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm97xx_snd_ac97_controls[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97,  AC97_WM97XX_FMIXER_VOL, 0x0808);
+	return 0;
+}
 
-	// WM9703/9707/9708/9717
-	snd_ac97_write_cache(ac97, AC97_WM97XX_FMIXER_VOL, 0x0808);
-	snd_ac97_write_cache(ac97, AC97_GENERAL_PURPOSE, 0x8000);
+static struct snd_ac97_build_ops patch_wolfson_wm9703_ops = {
+	.build_specific = patch_wolfson_wm9703_specific,
+};
+
+int patch_wolfson03(ac97_t * ac97)
+{
+	ac97->build_ops = &patch_wolfson_wm9703_ops;
 	return 0;
 }
-  
-int patch_wolfson04(ac97_t * ac97)
+
+static const snd_kcontrol_new_t wm9704_snd_ac97_controls[] = {
+AC97_DOUBLE("Front Playback Volume", AC97_WM97XX_FMIXER_VOL, 8, 0, 31, 1),
+AC97_SINGLE("Front Playback Switch", AC97_WM97XX_FMIXER_VOL, 15, 1, 1),
+AC97_DOUBLE("Rear Playback Volume", AC97_WM9704_RMIXER_VOL, 8, 0, 31, 1),
+AC97_SINGLE("Rear Playback Switch", AC97_WM9704_RMIXER_VOL, 15, 1, 1),
+AC97_DOUBLE("Rear DAC Volume", AC97_WM9704_RPCM_VOL, 8, 0, 31, 1),
+AC97_DOUBLE("Surround Volume", AC97_SURROUND_MASTER, 8, 0, 31, 1),
+};
+
+int patch_wolfson_wm9704_specific(ac97_t * ac97)
 {
-	// WM9704M/9704Q
-	// set front and rear mixer volume
-	snd_ac97_write_cache(ac97, AC97_WM97XX_FMIXER_VOL, 0x0808);
-	snd_ac97_write_cache(ac97, AC97_WM9704_RMIXER_VOL, 0x0808);
-	
-	// patch for DVD noise
+	int err, i;
+	for (i = 0; i < ARRAY_SIZE(wm9704_snd_ac97_controls); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm9704_snd_ac97_controls[i], ac97))) < 0)
+			return err;
+	}
+	/* patch for DVD noise */
 	snd_ac97_write_cache(ac97, AC97_WM9704_TEST, 0x0200);
- 
-	// init vol
-	snd_ac97_write_cache(ac97, AC97_WM9704_RPCM_VOL, 0x0808);
- 
-	// set rear surround volume
-	snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
 	return 0;
 }
-  
+
+static struct snd_ac97_build_ops patch_wolfson_wm9704_ops = {
+	.build_specific = patch_wolfson_wm9704_specific,
+};
+
+int patch_wolfson04(ac97_t * ac97)
+{
+	/* WM9704M/9704Q */
+	ac97->build_ops = &patch_wolfson_wm9704_ops;
+	return 0;
+}
+
+int patch_wolfson_wm9705_specific(ac97_t * ac97)
+{
+	int err, i;
+	for (i = 0; i < ARRAY_SIZE(wm97xx_snd_ac97_controls); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm97xx_snd_ac97_controls[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97,  0x72, 0x0808);
+	return 0;
+}
+
+static struct snd_ac97_build_ops patch_wolfson_wm9705_ops = {
+	.build_specific = patch_wolfson_wm9705_specific,
+};
+
 int patch_wolfson05(ac97_t * ac97)
 {
-	// WM9705, WM9710
-	// set front mixer volume
-	snd_ac97_write_cache(ac97, AC97_WM97XX_FMIXER_VOL, 0x0808);
+	/* WM9705, WM9710 */
+	ac97->build_ops = &patch_wolfson_wm9705_ops;
 	return 0;
 }
 
+static const char* wm9711_alc_select[] = {"None", "Left", "Right", "Stereo"};
+static const char* wm9711_alc_mix[] = {"Stereo", "Right", "Left", "None"};
+static const char* wm9711_out3_src[] = {"Left", "VREF", "Left + Right", "Mono"};
+static const char* wm9711_out3_lrsrc[] = {"Master Mix", "Headphone Mix"};
+static const char* wm9711_rec_adc[] = {"Stereo", "Left", "Right", "Mute"};
+static const char* wm9711_base[] = {"Linear Control", "Adaptive Boost"};
+static const char* wm9711_rec_gain[] = {"+1.5dB Steps", "+0.75dB Steps"};
+static const char* wm9711_mic[] = {"Mic 1", "Differential", "Mic 2", "Stereo"};
+static const char* wm9711_rec_sel[] = 
+	{"Mic 1", "NC", "NC", "Master Mix", "Line", "Headphone Mix", "Phone Mix", "Phone"};
+static const char* wm9711_ng_type[] = {"Constant Gain", "Mute"};
+
+static const struct ac97_enum wm9711_enum[] = {
+AC97_ENUM_SINGLE(AC97_PCI_SVID, 14, 4, wm9711_alc_select),
+AC97_ENUM_SINGLE(AC97_VIDEO, 10, 4, wm9711_alc_mix),
+AC97_ENUM_SINGLE(AC97_AUX, 9, 4, wm9711_out3_src),
+AC97_ENUM_SINGLE(AC97_AUX, 8, 2, wm9711_out3_lrsrc),
+AC97_ENUM_SINGLE(AC97_REC_SEL, 12, 4, wm9711_rec_adc),
+AC97_ENUM_SINGLE(AC97_MASTER_TONE, 15, 2, wm9711_base),
+AC97_ENUM_DOUBLE(AC97_REC_GAIN, 14, 6, 2, wm9711_rec_gain),
+AC97_ENUM_SINGLE(AC97_MIC, 5, 4, wm9711_mic),
+AC97_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 8, wm9711_rec_sel),
+AC97_ENUM_SINGLE(AC97_PCI_SVID, 5, 2, wm9711_ng_type),
+};
+
+static const snd_kcontrol_new_t wm9711_snd_ac97_controls[] = {
+AC97_SINGLE("ALC Target Volume", AC97_CODEC_CLASS_REV, 12, 15, 0),
+AC97_SINGLE("ALC Hold Time", AC97_CODEC_CLASS_REV, 8, 15, 0),
+AC97_SINGLE("ALC Decay Time", AC97_CODEC_CLASS_REV, 4, 15, 0),
+AC97_SINGLE("ALC Attack Time", AC97_CODEC_CLASS_REV, 0, 15, 0),
+AC97_ENUM("ALC Function", wm9711_enum[0]),
+AC97_SINGLE("ALC Max Volume", AC97_PCI_SVID, 11, 7, 1),
+AC97_SINGLE("ALC ZC Timeout", AC97_PCI_SVID, 9, 3, 1),
+AC97_SINGLE("ALC ZC Switch", AC97_PCI_SVID, 8, 1, 0),
+AC97_SINGLE("ALC NG Switch", AC97_PCI_SVID, 7, 1, 0),
+AC97_ENUM("ALC NG Type", wm9711_enum[9]),
+AC97_SINGLE("ALC NG Threshold", AC97_PCI_SVID, 0, 31, 1),
+
+AC97_SINGLE("Side Tone Switch", AC97_VIDEO, 15, 1, 1),
+AC97_SINGLE("Side Tone Volume", AC97_VIDEO, 12, 7, 1),
+AC97_ENUM("ALC Headphone Mux", wm9711_enum[1]),
+AC97_SINGLE("ALC Headphone Volume", AC97_VIDEO, 7, 7, 1),
+
+AC97_SINGLE("Out3 Switch", AC97_AUX, 15, 1, 1),
+AC97_SINGLE("Out3 ZC Switch", AC97_AUX, 7, 1, 1),
+AC97_ENUM("Out3 Mux", wm9711_enum[2]),
+AC97_ENUM("Out3 LR Mux", wm9711_enum[3]),
+AC97_SINGLE("Out3 Volume", AC97_AUX, 0, 31, 1),
+
+AC97_SINGLE("Beep to Headphone Switch", AC97_PC_BEEP, 15, 1, 1),
+AC97_SINGLE("Beep to Headphone Volume", AC97_PC_BEEP, 12, 7, 1),
+AC97_SINGLE("Beep to Side Tone Switch", AC97_PC_BEEP, 11, 1, 1),
+AC97_SINGLE("Beep to Side Tone Volume", AC97_PC_BEEP, 8, 7, 1),
+AC97_SINGLE("Beep to Phone Switch", AC97_PC_BEEP, 7, 1, 1),
+AC97_SINGLE("Beep to Phone Volume", AC97_PC_BEEP, 4, 7, 1),
+
+AC97_SINGLE("Aux to Headphone Switch", AC97_CD, 15, 1, 1),
+AC97_SINGLE("Aux to Headphone Volume", AC97_CD, 12, 7, 1),
+AC97_SINGLE("Aux to Side Tone Switch", AC97_CD, 11, 1, 1),
+AC97_SINGLE("Aux to Side Tone Volume", AC97_CD, 8, 7, 1),
+AC97_SINGLE("Aux to Phone Switch", AC97_CD, 7, 1, 1),
+AC97_SINGLE("Aux to Phone Volume", AC97_CD, 4, 7, 1),
+
+AC97_SINGLE("Phone to Headphone Switch", AC97_PHONE, 15, 1, 1),
+AC97_SINGLE("Phone to Master Switch", AC97_PHONE, 14, 1, 1),
+
+AC97_SINGLE("Line to Headphone Switch", AC97_LINE, 15, 1, 1),
+AC97_SINGLE("Line to Master Switch", AC97_LINE, 14, 1, 1),
+AC97_SINGLE("Line to Phone Switch", AC97_LINE, 13, 1, 1),
+
+AC97_SINGLE("PCM Playback to Headphone Switch", AC97_PCM, 15, 1, 1),
+AC97_SINGLE("PCM Playback to Master Switch", AC97_PCM, 14, 1, 1),
+AC97_SINGLE("PCM Playback to Phone Switch", AC97_PCM, 13, 1, 1),
+
+AC97_SINGLE("Capture 20dB Boost Switch", AC97_REC_SEL, 14, 1, 0),
+AC97_ENUM("Capture to Phone Mux", wm9711_enum[4]),
+AC97_SINGLE("Capture to Phone 20dB Boost Switch", AC97_REC_SEL, 11, 1, 1),
+AC97_ENUM("Capture Select", wm9711_enum[8]),
+
+AC97_SINGLE("3D Upper Cut-off Switch", AC97_3D_CONTROL, 5, 1, 1),
+AC97_SINGLE("3D Lower Cut-off Switch", AC97_3D_CONTROL, 4, 1, 1),
+
+AC97_ENUM("Bass Control", wm9711_enum[5]),
+AC97_SINGLE("Bass Cut-off Switch", AC97_MASTER_TONE, 12, 1, 1),
+AC97_SINGLE("Tone Cut-off Switch", AC97_MASTER_TONE, 4, 1, 1),
+AC97_SINGLE("Playback Attenuate (-6dB) Switch", AC97_MASTER_TONE, 6, 1, 0),
+
+AC97_SINGLE("ADC Switch", AC97_REC_GAIN, 15, 1, 1),
+AC97_ENUM("Capture Volume Steps", wm9711_enum[6]),
+AC97_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 15, 1),
+AC97_SINGLE("Capture ZC Switch", AC97_REC_GAIN, 7, 1, 0),
+
+AC97_SINGLE("Mic 1 to Phone Switch", AC97_MIC, 14, 1, 1),
+AC97_SINGLE("Mic 2 to Phone Switch", AC97_MIC, 13, 1, 1),
+AC97_ENUM("Mic Select Source", wm9711_enum[7]),
+AC97_SINGLE("Mic 1 Volume", AC97_MIC, 8, 32, 1),
+AC97_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 7, 1, 0),
+
+AC97_SINGLE("Master ZC Switch", AC97_MASTER, 7, 1, 0),
+AC97_SINGLE("Headphone ZC Switch", AC97_HEADPHONE, 7, 1, 0),
+AC97_SINGLE("Mono ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
+};
+
+int patch_wolfson_wm9711_specific(ac97_t * ac97)
+{
+	int err, i;
+	
+	for (i = 0; i < ARRAY_SIZE(wm9711_snd_ac97_controls); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm9711_snd_ac97_controls[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97,  AC97_CODEC_CLASS_REV, 0x0808);
+	snd_ac97_write_cache(ac97,  AC97_PCI_SVID, 0x0808);
+	snd_ac97_write_cache(ac97,  AC97_VIDEO, 0x0808);
+	snd_ac97_write_cache(ac97,  AC97_AUX, 0x0808);
+	snd_ac97_write_cache(ac97,  AC97_PC_BEEP, 0x0808);
+	snd_ac97_write_cache(ac97,  AC97_CD, 0x0000);
+	return 0;
+}
+
+static struct snd_ac97_build_ops patch_wolfson_wm9711_ops = {
+	.build_specific = patch_wolfson_wm9711_specific,
+};
+
 int patch_wolfson11(ac97_t * ac97)
 {
-	// WM9711, WM9712
-	// set out3 volume
-	snd_ac97_write_cache(ac97, AC97_WM9711_OUT3VOL, 0x0808);
+	/* WM9711, WM9712 */
+	ac97->build_ops = &patch_wolfson_wm9711_ops;
+
+	ac97->flags |= AC97_HAS_NO_REC_GAIN | AC97_STEREO_MUTES | AC97_HAS_NO_MIC |
+		AC97_HAS_NO_PC_BEEP | AC97_HAS_NO_VIDEO | AC97_HAS_NO_CD;
+	
 	return 0;
 }
 
-static const char* wm9713_mic_mixer[] = {"Stereo", "Mic1", "Mic2", "Mute"};
+static const char* wm9713_mic_mixer[] = {"Stereo", "Mic 1", "Mic 2", "Mute"};
 static const char* wm9713_rec_mux[] = {"Stereo", "Left", "Right", "Mute"};
-static const char* wm9713_rec_src_l[] = {"Mic1", "Mic2", "Line L", "Mono In", "HP Mix L", "Spk Mix", "Mono Mix", "Zh"};
-static const char* wm9713_rec_src_r[] = {"Mic1", "Mic2", "Line R", "Mono In", "HP Mix R", "Spk Mix", "Mono Mix", "Zh"};
+static const char* wm9713_rec_src[] = 
+	{"Mic 1", "Mic 2", "Line", "Mono In", "Headphone Mix", "Master Mix", 
+	"Mono Mix", "Zh"};
+static const char* wm9713_rec_gain[] = {"+1.5dB Steps", "+0.75dB Steps"};
+static const char* wm9713_alc_select[] = {"None", "Left", "Right", "Stereo"};
+static const char* wm9713_mono_pga[] = {"Vmid", "Zh", "Mono Mix", "Inv 1"};
+static const char* wm9713_spk_pga[] = 
+	{"Vmid", "Zh", "Headphone Mix", "Master Mix", "Inv", "NC", "NC", "NC"};
+static const char* wm9713_hp_pga[] = {"Vmid", "Zh", "Headphone Mix", "NC"};
+static const char* wm9713_out3_pga[] = {"Vmid", "Zh", "Inv 1", "NC"};
+static const char* wm9713_out4_pga[] = {"Vmid", "Zh", "Inv 2", "NC"};
+static const char* wm9713_dac_inv[] = 
+	{"Off", "Mono Mix", "Master Mix", "Headphone Mix L", "Headphone Mix R", 
+	"Headphone Mix Mono", "NC", "Vmid"};
+static const char* wm9713_base[] = {"Linear Control", "Adaptive Boost"};
+static const char* wm9713_ng_type[] = {"Constant Gain", "Mute"};
 
 static const struct ac97_enum wm9713_enum[] = {
 AC97_ENUM_SINGLE(AC97_LINE, 3, 4, wm9713_mic_mixer),
 AC97_ENUM_SINGLE(AC97_VIDEO, 14, 4, wm9713_rec_mux),
 AC97_ENUM_SINGLE(AC97_VIDEO, 9, 4, wm9713_rec_mux),
-AC97_ENUM_SINGLE(AC97_VIDEO, 3, 8, wm9713_rec_src_l),
-AC97_ENUM_SINGLE(AC97_VIDEO, 0, 8, wm9713_rec_src_r),
+AC97_ENUM_DOUBLE(AC97_VIDEO, 3, 0, 8, wm9713_rec_src),
+AC97_ENUM_DOUBLE(AC97_CD, 14, 6, 2, wm9713_rec_gain),
+AC97_ENUM_SINGLE(AC97_PCI_SVID, 14, 4, wm9713_alc_select),
+AC97_ENUM_SINGLE(AC97_REC_GAIN, 14, 4, wm9713_mono_pga),
+AC97_ENUM_DOUBLE(AC97_REC_GAIN, 11, 8, 8, wm9713_spk_pga),
+AC97_ENUM_DOUBLE(AC97_REC_GAIN, 6, 4, 4, wm9713_hp_pga),
+AC97_ENUM_SINGLE(AC97_REC_GAIN, 2, 4, wm9713_out3_pga),
+AC97_ENUM_SINGLE(AC97_REC_GAIN, 0, 4, wm9713_out4_pga),
+AC97_ENUM_DOUBLE(AC97_REC_GAIN_MIC, 13, 10, 8, wm9713_dac_inv),
+AC97_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 15, 2, wm9713_base),
+AC97_ENUM_SINGLE(AC97_PCI_SVID, 5, 2, wm9713_ng_type),
 };
 
-static const snd_kcontrol_new_t wm13_snd_ac97_controls_line_in[] = {
+static const snd_kcontrol_new_t wm13_snd_ac97_controls[] = {
 AC97_DOUBLE("Line In Volume", AC97_PC_BEEP, 8, 0, 31, 1),
-AC97_SINGLE("Line In to Headphone Mute", AC97_PC_BEEP, 15, 1, 1),
-AC97_SINGLE("Line In to Speaker Mute", AC97_PC_BEEP, 14, 1, 1),
-AC97_SINGLE("Line In to Mono Mute", AC97_PC_BEEP, 13, 1, 1),
-};
-
-static const snd_kcontrol_new_t wm13_snd_ac97_controls_dac[] = {
-AC97_DOUBLE("DAC Volume", AC97_PHONE, 8, 0, 31, 1),
-AC97_SINGLE("DAC to Headphone Mute", AC97_PHONE, 15, 1, 1),
-AC97_SINGLE("DAC to Speaker Mute", AC97_PHONE, 14, 1, 1),
-AC97_SINGLE("DAC to Mono Mute", AC97_PHONE, 13, 1, 1),
-};
-
-static const snd_kcontrol_new_t wm13_snd_ac97_controls_mic[] = {
-AC97_SINGLE("MICA Volume", AC97_MIC, 8, 31, 1),
-AC97_SINGLE("MICB Volume", AC97_MIC, 0, 31, 1),
-AC97_SINGLE("MICA to Mono Mute", AC97_LINE, 7, 1, 1),
-AC97_SINGLE("MICB to Mono Mute", AC97_LINE, 6, 1, 1),
-AC97_SINGLE("MIC Boost (+20dB)", AC97_LINE, 5, 1, 1),
-AC97_ENUM("MIC Headphone Routing", wm9713_enum[0]),
-AC97_SINGLE("MIC Headphone Mixer Volume", AC97_LINE, 0, 7, 1)
-};
-
-static const snd_kcontrol_new_t wm13_snd_ac97_controls_adc[] = {
-AC97_SINGLE("ADC Mute", AC97_CD, 15, 1, 1),
-AC97_DOUBLE("Gain Step Size (1.5dB/0.75dB)", AC97_CD, 14, 6, 1, 1),
-AC97_DOUBLE("ADC Volume",AC97_CD, 8, 0, 15, 0),
-AC97_SINGLE("ADC Zero Cross", AC97_CD, 7, 1, 1),
-};
-
-static const snd_kcontrol_new_t wm13_snd_ac97_controls_recsel[] = {
-AC97_ENUM("Record to Headphone Path", wm9713_enum[1]),
-AC97_SINGLE("Record to Headphone Volume", AC97_VIDEO, 11, 7, 0),
-AC97_ENUM("Record to Mono Path", wm9713_enum[2]),
-AC97_SINGLE("Record to Mono Boost (+20dB)", AC97_VIDEO, 8, 1, 0),
-AC97_SINGLE("Record ADC Boost (+20dB)", AC97_VIDEO, 6, 1, 0),
-AC97_ENUM("Record Select Left", wm9713_enum[3]),
-AC97_ENUM("Record Select Right", wm9713_enum[4]),
+AC97_SINGLE("Line In to Headphone Switch", AC97_PC_BEEP, 15, 1, 1),
+AC97_SINGLE("Line In to Master Switch", AC97_PC_BEEP, 14, 1, 1),
+AC97_SINGLE("Line In to Mono Switch", AC97_PC_BEEP, 13, 1, 1),
+
+AC97_DOUBLE("PCM Playback Volume", AC97_PHONE, 8, 0, 31, 1),
+AC97_SINGLE("PCM Playback to Headphone Switch", AC97_PHONE, 15, 1, 1),
+AC97_SINGLE("PCM Playback to Master Switch", AC97_PHONE, 14, 1, 1),
+AC97_SINGLE("PCM Playback to Mono Switch", AC97_PHONE, 13, 1, 1),
+
+AC97_SINGLE("Mic 1 Volume", AC97_MIC, 8, 31, 1),
+AC97_SINGLE("Mic 2 Volume", AC97_MIC, 0, 31, 1),
+AC97_SINGLE("Mic 1 to Mono Switch", AC97_LINE, 7, 1, 1),
+AC97_SINGLE("Mic 2 to Mono Switch", AC97_LINE, 6, 1, 1),
+AC97_SINGLE("Mic Boost (+20dB) Switch", AC97_LINE, 5, 1, 0),
+AC97_ENUM("Mic to Headphone Mux", wm9713_enum[0]),
+AC97_SINGLE("Mic Headphone Mixer Volume", AC97_LINE, 0, 7, 1),
+
+AC97_SINGLE("Capture Switch", AC97_CD, 15, 1, 1),
+AC97_ENUM("Capture Volume Steps", wm9713_enum[4]),
+AC97_DOUBLE("Capture Volume", AC97_CD, 8, 0, 15, 0),
+AC97_SINGLE("Capture ZC Switch", AC97_CD, 7, 1, 0),
+
+AC97_ENUM("Capture to Headphone Mux", wm9713_enum[1]),
+AC97_SINGLE("Capture to Headphone Volume", AC97_VIDEO, 11, 7, 1),
+AC97_ENUM("Capture to Mono Mux", wm9713_enum[2]),
+AC97_SINGLE("Capture to Mono Boost (+20dB) Switch", AC97_VIDEO, 8, 1, 0),
+AC97_SINGLE("Capture ADC Boost (+20dB) Switch", AC97_VIDEO, 6, 1, 0),
+AC97_ENUM("Capture Select", wm9713_enum[3]),
+
+AC97_SINGLE("ALC Target Volume", AC97_CODEC_CLASS_REV, 12, 15, 0),
+AC97_SINGLE("ALC Hold Time", AC97_CODEC_CLASS_REV, 8, 15, 0),
+AC97_SINGLE("ALC Decay Time ", AC97_CODEC_CLASS_REV, 4, 15, 0),
+AC97_SINGLE("ALC Attack Time", AC97_CODEC_CLASS_REV, 0, 15, 0),
+AC97_ENUM("ALC Function", wm9713_enum[5]),
+AC97_SINGLE("ALC Max Volume", AC97_PCI_SVID, 11, 7, 0),
+AC97_SINGLE("ALC ZC Timeout", AC97_PCI_SVID, 9, 3, 0),
+AC97_SINGLE("ALC ZC Switch", AC97_PCI_SVID, 8, 1, 0),
+AC97_SINGLE("ALC NG Switch", AC97_PCI_SVID, 7, 1, 0),
+AC97_ENUM("ALC NG Type", wm9713_enum[13]),
+AC97_SINGLE("ALC NG Threshold", AC97_PCI_SVID, 0, 31, 0),
+
+AC97_DOUBLE("Master ZC Switch", AC97_MASTER, 14, 6, 1, 0),
+AC97_DOUBLE("Headphone ZC Switch", AC97_HEADPHONE, 14, 6, 1, 0),
+AC97_DOUBLE("Out3/4 ZC Switch", AC97_MASTER_MONO, 14, 6, 1, 0),
+AC97_SINGLE("Master Right Switch", AC97_MASTER, 7, 1, 1),
+AC97_SINGLE("Headphone Right Switch", AC97_HEADPHONE, 7, 1, 1),
+AC97_SINGLE("Out3/4 Right Switch", AC97_MASTER_MONO, 7, 1, 1),
+
+AC97_SINGLE("Mono In to Headphone Switch", AC97_MASTER_TONE, 15, 1, 1),
+AC97_SINGLE("Mono In to Master Switch", AC97_MASTER_TONE, 14, 1, 1),
+AC97_SINGLE("Mono In Volume", AC97_MASTER_TONE, 8, 31, 1),
+AC97_SINGLE("Mono Switch", AC97_MASTER_TONE, 7, 1, 1),
+AC97_SINGLE("Mono ZC Switch", AC97_MASTER_TONE, 6, 1, 0),
+AC97_SINGLE("Mono Volume", AC97_MASTER_TONE, 0, 31, 1),
+
+AC97_SINGLE("PC Beep to Headphone Switch", AC97_AUX, 15, 1, 1),
+AC97_SINGLE("PC Beep to Headphone Volume", AC97_AUX, 12, 7, 1),
+AC97_SINGLE("PC Beep to Master Switch", AC97_AUX, 11, 1, 1),
+AC97_SINGLE("PC Beep to Master Volume", AC97_AUX, 8, 7, 1),
+AC97_SINGLE("PC Beep to Mono Switch", AC97_AUX, 7, 1, 1),
+AC97_SINGLE("PC Beep to Mono Volume", AC97_AUX, 4, 7, 1),
+
+AC97_SINGLE("Voice to Headphone Switch", AC97_PCM, 15, 1, 1),
+AC97_SINGLE("Voice to Headphone Volume", AC97_PCM, 12, 7, 1),
+AC97_SINGLE("Voice to Master Switch", AC97_PCM, 11, 1, 1),
+AC97_SINGLE("Voice to Master Volume", AC97_PCM, 8, 7, 1),
+AC97_SINGLE("Voice to Mono Switch", AC97_PCM, 7, 1, 1),
+AC97_SINGLE("Voice to Mono Volume", AC97_PCM, 4, 7, 1),
+
+AC97_SINGLE("Aux to Headphone Switch", AC97_REC_SEL, 15, 1, 1),
+AC97_SINGLE("Aux to Headphone Volume", AC97_REC_SEL, 12, 7, 1),
+AC97_SINGLE("Aux to Master Switch", AC97_REC_SEL, 11, 1, 1),
+AC97_SINGLE("Aux to Master Volume", AC97_REC_SEL, 8, 7, 1),
+AC97_SINGLE("Aux to Mono Switch", AC97_REC_SEL, 7, 1, 1),
+AC97_SINGLE("Aux to Mono Volume", AC97_REC_SEL, 4, 7, 1),
+
+AC97_ENUM("Mono Input Mux", wm9713_enum[6]),
+AC97_ENUM("Master Input Mux", wm9713_enum[7]),
+AC97_ENUM("Headphone Input Mux", wm9713_enum[8]),
+AC97_ENUM("Out 3 Input Mux", wm9713_enum[9]),
+AC97_ENUM("Out 4 Input Mux", wm9713_enum[10]),
+
+AC97_ENUM("Bass Control", wm9713_enum[12]),
+AC97_SINGLE("Bass Cut-off Switch", AC97_GENERAL_PURPOSE, 12, 1, 1),
+AC97_SINGLE("Tone Cut-off Switch", AC97_GENERAL_PURPOSE, 4, 1, 1),
+AC97_SINGLE("Playback Attenuate (-6dB) Switch", AC97_GENERAL_PURPOSE, 6, 1, 0),
+AC97_SINGLE("Bass Volume", AC97_GENERAL_PURPOSE, 8, 15, 1),
+AC97_SINGLE("Tone Volume", AC97_GENERAL_PURPOSE, 0, 15, 1),
+};
+
+static const snd_kcontrol_new_t wm13_snd_ac97_controls_3d[] = {
+AC97_ENUM("Inv Input Mux", wm9713_enum[11]),
+AC97_SINGLE("3D Upper Cut-off Switch", AC97_REC_GAIN_MIC, 5, 1, 0),
+AC97_SINGLE("3D Lower Cut-off Switch", AC97_REC_GAIN_MIC, 4, 1, 0),
+AC97_SINGLE("3D Depth", AC97_REC_GAIN_MIC, 0, 15, 1),
 };
 
-static int patch_wolfson_wm9713_specific(ac97_t * ac97)
+static int patch_wolfson_wm9713_3d (ac97_t * ac97)
 {
 	int err, i;
-	
-	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_line_in); i++) {
-		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_line_in[i], ac97))) < 0)
+    
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_3d); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_3d[i], ac97))) < 0)
 			return err;
 	}
-	snd_ac97_write_cache(ac97, AC97_PC_BEEP, 0x0808);
+	return 0;
+}
+
+static int patch_wolfson_wm9713_specific(ac97_t * ac97)
+{
+	int err, i;
 	
-	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_dac); i++) {
-		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_dac[i], ac97))) < 0)
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls[i], ac97))) < 0)
 			return err;
 	}
+	snd_ac97_write_cache(ac97, AC97_PC_BEEP, 0x0808);
 	snd_ac97_write_cache(ac97, AC97_PHONE, 0x0808);
-	
-	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_mic); i++) {
-		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_mic[i], ac97))) < 0)
-			return err;
-	}
 	snd_ac97_write_cache(ac97, AC97_MIC, 0x0808);
 	snd_ac97_write_cache(ac97, AC97_LINE, 0x00da);
-	
-	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_adc); i++) {
-		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_adc[i], ac97))) < 0)
-			return err;
-	}
 	snd_ac97_write_cache(ac97, AC97_CD, 0x0808);
-	
-	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_recsel); i++) {
-		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_recsel[i], ac97))) < 0)
-			return err;
-	}
 	snd_ac97_write_cache(ac97, AC97_VIDEO, 0xd612);
 	snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x1ba0);
-	
 	return 0;
 }
 
@@ -525,6 +771,7 @@ static void patch_wolfson_wm9713_resume 
 
 static struct snd_ac97_build_ops patch_wolfson_wm9713_ops = {
 	.build_specific = patch_wolfson_wm9713_specific,
+	.build_3d = patch_wolfson_wm9713_3d,
 #ifdef CONFIG_PM	
 	.suspend = patch_wolfson_wm9713_suspend,
 	.resume = patch_wolfson_wm9713_resume
@@ -533,10 +780,12 @@ static struct snd_ac97_build_ops patch_w
 
 int patch_wolfson13(ac97_t * ac97)
 {
+	/* WM9713, WM9714 */
 	ac97->build_ops = &patch_wolfson_wm9713_ops;
 
 	ac97->flags |= AC97_HAS_NO_REC_GAIN | AC97_STEREO_MUTES | AC97_HAS_NO_PHONE |
-		AC97_HAS_NO_PC_BEEP | AC97_HAS_NO_VIDEO | AC97_HAS_NO_CD;
+		AC97_HAS_NO_PC_BEEP | AC97_HAS_NO_VIDEO | AC97_HAS_NO_CD | AC97_HAS_NO_TONE |
+		AC97_HAS_NO_STD_PCM;
 
 	snd_ac97_write_cache(ac97, AC97_EXTENDED_MID, 0xda00);
 	snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0x3810);
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1300,16 +1307,18 @@ static int snd_ac97_mixer_build(ac97_t *
 	}
 	
 	/* build master tone controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_MASTER_TONE)) {
-		for (idx = 0; idx < 2; idx++) {
-			if ((err = snd_ctl_add(card, kctl = snd_ac97_cnew(&snd_ac97_controls_tone[idx], ac97))) < 0)
-				return err;
-			if (ac97->id == AC97_ID_YMF753) {
-				kctl->private_value &= ~(0xff << 16);
-				kctl->private_value |= 7 << 16;
+	if (!(ac97->flags & AC97_HAS_NO_TONE)) {
+		if (snd_ac97_try_volume_mix(ac97, AC97_MASTER_TONE)) {
+			for (idx = 0; idx < 2; idx++) {
+				if ((err = snd_ctl_add(card, kctl = snd_ac97_cnew(&snd_ac97_controls_tone[idx], ac97))) < 0)
+					return err;
+				if (ac97->id == AC97_ID_YMF753) {
+					kctl->private_value &= ~(0xff << 16);
+					kctl->private_value |= 7 << 16;
+				}
 			}
+			snd_ac97_write_cache(ac97, AC97_MASTER_TONE, 0x0f0f);
 		}
-		snd_ac97_write_cache(ac97, AC97_MASTER_TONE, 0x0f0f);
 	}
 	
 	/* build PC Speaker controls */
@@ -1332,11 +1342,13 @@ static int snd_ac97_mixer_build(ac97_t *
 	}
 	
 	/* build MIC controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_MIC)) {
-		if ((err = snd_ac97_cmix_new(card, "Mic Playback", AC97_MIC, ac97)) < 0)
-			return err;
-		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_mic_boost, ac97))) < 0)
-			return err;
+	if (!(ac97->flags & AC97_HAS_NO_MIC)) {
+		if (snd_ac97_try_volume_mix(ac97, AC97_MIC)) {
+			if ((err = snd_ac97_cmix_new(card, "Mic Playback", AC97_MIC, ac97)) < 0)
+				return err;
+			if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_mic_boost, ac97))) < 0)
+				return err;
+		}
 	}
 
 	/* build Line controls */
@@ -1395,12 +1407,14 @@ static int snd_ac97_mixer_build(ac97_t *
 		}
 		snd_ac97_write_cache(ac97, AC97_PCM, init_val);
 	} else {
-		if (ac97->flags & AC97_HAS_NO_PCM_VOL)
-			err = snd_ac97_cmute_new(card, "PCM Playback Switch", AC97_PCM, ac97);
-		else
-			err = snd_ac97_cmix_new(card, "PCM Playback", AC97_PCM, ac97);
-		if (err < 0)
-			return err;
+		if (!(ac97->flags & AC97_HAS_NO_STD_PCM)) {
+			if (ac97->flags & AC97_HAS_NO_PCM_VOL)
+				err = snd_ac97_cmute_new(card, "PCM Playback Switch", AC97_PCM, ac97);
+			else
+				err = snd_ac97_cmix_new(card, "PCM Playback", AC97_PCM, ac97);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	/* build Capture controls */
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -374,6 +375,9 @@
 #define AC97_HAS_NO_PC_BEEP	(1<<12) /* no PC Beep volume */
 #define AC97_HAS_NO_VIDEO	(1<<13) /* no Video volume */
 #define AC97_HAS_NO_CD		(1<<14) /* no CD volume */
+#define AC97_HAS_NO_MIC	(1<<15) /* no MIC volume */
+#define AC97_HAS_NO_TONE	(1<<16) /* no Tone volume */
+#define AC97_HAS_NO_STD_PCM	(1<<17)	/* no standard AC97 PCM volume and mute */
 
 /* rates indexes */
 #define AC97_RATES_FRONT_DAC	0

--=-3tjwsobxVTH/44vMcwNn--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
