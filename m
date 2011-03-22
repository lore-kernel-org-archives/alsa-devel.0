From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 1/8] ALSA: VIA HDA: Add new power management
	function
Date: Tue, 22 Mar 2011 14:28:16 +0800
Message-ID: <4D884180.9090402@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id C3F3F103800
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 07:28:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Add new power management function.

Use set_widgets_power_state() function to seperately control different
codecs' power management actions.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |  940 ++++++++++++++++++++++------------------------
 1 file changed, 456 insertions(+), 484 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -154,6 +154,9 @@
 	struct delayed_work vt1708_hp_work;
 	int vt1708_jack_detectect;
 	int vt1708_hp_present;
+
+	void (*set_widgets_power_state)(struct hda_codec *codec);
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	struct hda_loopback_check loopback;
 #endif
@@ -240,7 +243,6 @@
 };
 
 static void analog_low_current_mode(struct hda_codec *codec, int stream_idle);
-static void set_jack_power_state(struct hda_codec *codec);
 static int is_aa_path_mute(struct hda_codec *codec);
 
 static void vt1708_start_hp_work(struct via_spec *spec)
@@ -266,6 +268,12 @@
 	cancel_delayed_work_sync(&spec->vt1708_hp_work);
 }
 
+static void set_widgets_power_state(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	if (spec->set_widgets_power_state)
+		spec->set_widgets_power_state(codec);
+}
 
 static int analog_input_switch_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
@@ -273,7 +281,7 @@
 	int change = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 
-	set_jack_power_state(codec);
+	set_widgets_power_state(codec);
 	analog_low_current_mode(snd_kcontrol_chip(kcontrol), -1);
 	if (snd_hda_get_bool_hint(codec, "analog_loopback_hp_detect") == 1) {
 		if (is_aa_path_mute(codec))
@@ -597,482 +605,6 @@
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
 }
 
-static void set_jack_power_state(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	int imux_is_smixer;
-	unsigned int parm;
-
-	if (spec->codec_type == VT1702) {
-		imux_is_smixer = snd_hda_codec_read(
-			codec, 0x13, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
-		/* inputs */
-		/* PW 1/2/5 (14h/15h/18h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x14, &parm);
-		set_pin_power_state(codec, 0x15, &parm);
-		set_pin_power_state(codec, 0x18, &parm);
-		if (imux_is_smixer)
-			parm = AC_PWRST_D0; /* SW0 = stereo mixer (idx 3) */
-		/* SW0 (13h), AIW 0/1/2 (12h/1fh/20h) */
-		snd_hda_codec_write(codec, 0x13, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x12, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* outputs */
-		/* PW 3/4 (16h/17h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x16, &parm);
-		set_pin_power_state(codec, 0x17, &parm);
-		/* MW0 (1ah), AOW 0/1 (10h/1dh) */
-		snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE,
-				    imux_is_smixer ? AC_PWRST_D0 : parm);
-		snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-	} else if (spec->codec_type == VT1708B_8CH
-		   || spec->codec_type == VT1708B_4CH
-		   || spec->codec_type == VT1708S) {
-		/* SW0 (17h) = stereo mixer */
-		int is_8ch = spec->codec_type != VT1708B_4CH;
-		imux_is_smixer = snd_hda_codec_read(
-			codec, 0x17, 0, AC_VERB_GET_CONNECT_SEL, 0x00)
-			== ((spec->codec_type == VT1708S)  ? 5 : 0);
-		/* inputs */
-		/* PW 1/2/5 (1ah/1bh/1eh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x1a, &parm);
-		set_pin_power_state(codec, 0x1b, &parm);
-		set_pin_power_state(codec, 0x1e, &parm);
-		if (imux_is_smixer)
-			parm = AC_PWRST_D0;
-		/* SW0 (17h), AIW 0/1 (13h/14h) */
-		snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x13, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* outputs */
-		/* PW0 (19h), SW1 (18h), AOW1 (11h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x19, &parm);
-		if (spec->smart51_enabled)
-			parm = AC_PWRST_D0;
-		snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* PW6 (22h), SW2 (26h), AOW2 (24h) */
-		if (is_8ch) {
-			parm = AC_PWRST_D3;
-			set_pin_power_state(codec, 0x22, &parm);
-			if (spec->smart51_enabled)
-				parm = AC_PWRST_D0;
-			snd_hda_codec_write(codec, 0x26, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-			snd_hda_codec_write(codec, 0x24, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-		}
-
-		/* PW 3/4/7 (1ch/1dh/23h) */
-		parm = AC_PWRST_D3;
-		/* force to D0 for internal Speaker */
-		set_pin_power_state(codec, 0x1c, &parm);
-		set_pin_power_state(codec, 0x1d, &parm);
-		if (is_8ch)
-			set_pin_power_state(codec, 0x23, &parm);
-		/* MW0 (16h), Sw3 (27h), AOW 0/3 (10h/25h) */
-		snd_hda_codec_write(codec, 0x16, 0, AC_VERB_SET_POWER_STATE,
-				    imux_is_smixer ? AC_PWRST_D0 : parm);
-		snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		if (is_8ch) {
-			snd_hda_codec_write(codec, 0x25, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-			snd_hda_codec_write(codec, 0x27, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-		}
-	}  else if (spec->codec_type == VT1718S) {
-		/* MUX6 (1eh) = stereo mixer */
-		imux_is_smixer = snd_hda_codec_read(
-			codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 5;
-		/* inputs */
-		/* PW 5/6/7 (29h/2ah/2bh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x29, &parm);
-		set_pin_power_state(codec, 0x2a, &parm);
-		set_pin_power_state(codec, 0x2b, &parm);
-		if (imux_is_smixer)
-			parm = AC_PWRST_D0;
-		/* MUX6/7 (1eh/1fh), AIW 0/1 (10h/11h) */
-		snd_hda_codec_write(codec, 0x1e, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* outputs */
-		/* PW3 (27h), MW2 (1ah), AOW3 (bh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x27, &parm);
-		snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0xb, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* PW2 (26h), AOW2 (ah) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x26, &parm);
-		snd_hda_codec_write(codec, 0xa, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* PW0/1 (24h/25h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x24, &parm);
-		set_pin_power_state(codec, 0x25, &parm);
-		if (!spec->hp_independent_mode) /* check for redirected HP */
-			set_pin_power_state(codec, 0x28, &parm);
-		snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x9, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
-		snd_hda_codec_write(codec, 0x21, 0, AC_VERB_SET_POWER_STATE,
-				    imux_is_smixer ? AC_PWRST_D0 : parm);
-		if (spec->hp_independent_mode) {
-			/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) */
-			parm = AC_PWRST_D3;
-			set_pin_power_state(codec, 0x28, &parm);
-			snd_hda_codec_write(codec, 0x1b, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-			snd_hda_codec_write(codec, 0x34, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-			snd_hda_codec_write(codec, 0xc, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-		}
-	} else if (spec->codec_type == VT1716S) {
-		unsigned int mono_out, present;
-		/* SW0 (17h) = stereo mixer */
-		imux_is_smixer = snd_hda_codec_read(
-			codec, 0x17, 0, AC_VERB_GET_CONNECT_SEL, 0x00) ==  5;
-		/* inputs */
-		/* PW 1/2/5 (1ah/1bh/1eh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x1a, &parm);
-		set_pin_power_state(codec, 0x1b, &parm);
-		set_pin_power_state(codec, 0x1e, &parm);
-		if (imux_is_smixer)
-			parm = AC_PWRST_D0;
-		/* SW0 (17h), AIW0(13h) */
-		snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x13, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x1e, &parm);
-		/* PW11 (22h) */
-		if (spec->dmic_enabled)
-			set_pin_power_state(codec, 0x22, &parm);
-		else
-			snd_hda_codec_write(
-				codec, 0x22, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-
-		/* SW2(26h), AIW1(14h) */
-		snd_hda_codec_write(codec, 0x26, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* outputs */
-		/* PW0 (19h), SW1 (18h), AOW1 (11h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x19, &parm);
-		/* Smart 5.1 PW2(1bh) */
-		if (spec->smart51_enabled)
-			set_pin_power_state(codec, 0x1b, &parm);
-		snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* PW7 (23h), SW3 (27h), AOW3 (25h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x23, &parm);
-		/* Smart 5.1 PW1(1ah) */
-		if (spec->smart51_enabled)
-			set_pin_power_state(codec, 0x1a, &parm);
-		snd_hda_codec_write(codec, 0x27, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* Smart 5.1 PW5(1eh) */
-		if (spec->smart51_enabled)
-			set_pin_power_state(codec, 0x1e, &parm);
-		snd_hda_codec_write(codec, 0x25, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* Mono out */
-		/* SW4(28h)->MW1(29h)-> PW12 (2ah)*/
-		present = snd_hda_jack_detect(codec, 0x1c);
-		if (present)
-			mono_out = 0;
-		else {
-			present = snd_hda_jack_detect(codec, 0x1d);
-			if (!spec->hp_independent_mode && present)
-				mono_out = 0;
-			else
-				mono_out = 1;
-		}
-		parm = mono_out ? AC_PWRST_D0 : AC_PWRST_D3;
-		snd_hda_codec_write(codec, 0x28, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x29, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-		snd_hda_codec_write(codec, 0x2a, 0, AC_VERB_SET_POWER_STATE,
-				    parm);
-
-		/* PW 3/4 (1ch/1dh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x1c, &parm);
-		set_pin_power_state(codec, 0x1d, &parm);
-		/* HP Independent Mode, power on AOW3 */
-		if (spec->hp_independent_mode)
-			snd_hda_codec_write(codec, 0x25, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-
-		/* force to D0 for internal Speaker */
-		/* MW0 (16h), AOW0 (10h) */
-		snd_hda_codec_write(codec, 0x16, 0, AC_VERB_SET_POWER_STATE,
-				    imux_is_smixer ? AC_PWRST_D0 : parm);
-		snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE,
-				    mono_out ? AC_PWRST_D0 : parm);
-	} else if (spec->codec_type == VT2002P) {
-		unsigned int present;
-		/* MUX9 (1eh) = stereo mixer */
-		imux_is_smixer = snd_hda_codec_read(
-			codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
-		/* inputs */
-		/* PW 5/6/7 (29h/2ah/2bh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x29, &parm);
-		set_pin_power_state(codec, 0x2a, &parm);
-		set_pin_power_state(codec, 0x2b, &parm);
-		if (imux_is_smixer)
-			parm = AC_PWRST_D0;
-		/* MUX9/10 (1eh/1fh), AIW 0/1 (10h/11h) */
-		snd_hda_codec_write(codec, 0x1e, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x1f, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x10, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x11, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-
-		/* outputs */
-		/* AOW0 (8h)*/
-		snd_hda_codec_write(codec, 0x8, 0,
-				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-
-		/* PW4 (26h), MW4 (1ch), MUX4(37h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x26, &parm);
-		snd_hda_codec_write(codec, 0x1c, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x37,
-				    0, AC_VERB_SET_POWER_STATE, parm);
-
-		/* PW1 (25h), MW1 (19h), MUX1(35h), AOW1 (9h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x25, &parm);
-		snd_hda_codec_write(codec, 0x19, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x35, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		if (spec->hp_independent_mode)	{
-			snd_hda_codec_write(codec, 0x9, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-		}
-
-		/* Class-D */
-		/* PW0 (24h), MW0(18h), MUX0(34h) */
-		present = snd_hda_jack_detect(codec, 0x25);
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x24, &parm);
-		if (present) {
-			snd_hda_codec_write(
-				codec, 0x18, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-			snd_hda_codec_write(
-				codec, 0x34, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-		} else {
-			snd_hda_codec_write(
-				codec, 0x18, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-			snd_hda_codec_write(
-				codec, 0x34, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-		}
-
-		/* Mono Out */
-		/* PW15 (31h), MW8(17h), MUX8(3bh) */
-		present = snd_hda_jack_detect(codec, 0x26);
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x31, &parm);
-		if (present) {
-			snd_hda_codec_write(
-				codec, 0x17, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-			snd_hda_codec_write(
-				codec, 0x3b, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-		} else {
-			snd_hda_codec_write(
-				codec, 0x17, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-			snd_hda_codec_write(
-				codec, 0x3b, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-		}
-
-		/* MW9 (21h) */
-		if (imux_is_smixer || !is_aa_path_mute(codec))
-			snd_hda_codec_write(
-				codec, 0x21, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-		else
-			snd_hda_codec_write(
-				codec, 0x21, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-	} else if (spec->codec_type == VT1812) {
-		unsigned int present;
-		/* MUX10 (1eh) = stereo mixer */
-		imux_is_smixer = snd_hda_codec_read(
-			codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 5;
-		/* inputs */
-		/* PW 5/6/7 (29h/2ah/2bh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x29, &parm);
-		set_pin_power_state(codec, 0x2a, &parm);
-		set_pin_power_state(codec, 0x2b, &parm);
-		if (imux_is_smixer)
-			parm = AC_PWRST_D0;
-		/* MUX10/11 (1eh/1fh), AIW 0/1 (10h/11h) */
-		snd_hda_codec_write(codec, 0x1e, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x1f, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x10, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x11, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-
-		/* outputs */
-		/* AOW0 (8h)*/
-		snd_hda_codec_write(codec, 0x8, 0,
-				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-
-		/* PW4 (28h), MW4 (18h), MUX4(38h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x28, &parm);
-		snd_hda_codec_write(codec, 0x18, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x38, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-
-		/* PW1 (25h), MW1 (15h), MUX1(35h), AOW1 (9h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x25, &parm);
-		snd_hda_codec_write(codec, 0x15, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x35, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		if (spec->hp_independent_mode)	{
-			snd_hda_codec_write(codec, 0x9, 0,
-					    AC_VERB_SET_POWER_STATE, parm);
-		}
-
-		/* Internal Speaker */
-		/* PW0 (24h), MW0(14h), MUX0(34h) */
-		present = snd_hda_jack_detect(codec, 0x25);
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x24, &parm);
-		if (present) {
-			snd_hda_codec_write(codec, 0x14, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-			snd_hda_codec_write(codec, 0x34, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-		} else {
-			snd_hda_codec_write(codec, 0x14, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D0);
-			snd_hda_codec_write(codec, 0x34, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D0);
-		}
-		/* Mono Out */
-		/* PW13 (31h), MW13(1ch), MUX13(3ch), MW14(3eh) */
-		present = snd_hda_jack_detect(codec, 0x28);
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x31, &parm);
-		if (present) {
-			snd_hda_codec_write(codec, 0x1c, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-			snd_hda_codec_write(codec, 0x3c, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-			snd_hda_codec_write(codec, 0x3e, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-		} else {
-			snd_hda_codec_write(codec, 0x1c, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D0);
-			snd_hda_codec_write(codec, 0x3c, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D0);
-			snd_hda_codec_write(codec, 0x3e, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D0);
-		}
-
-		/* PW15 (33h), MW15 (1dh), MUX15(3dh) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x33, &parm);
-		snd_hda_codec_write(codec, 0x1d, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-		snd_hda_codec_write(codec, 0x3d, 0,
-				    AC_VERB_SET_POWER_STATE, parm);
-
-		/* MW9 (21h) */
-		if (imux_is_smixer || !is_aa_path_mute(codec))
-			snd_hda_codec_write(
-				codec, 0x21, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-		else
-			snd_hda_codec_write(
-				codec, 0x21, 0,
-				AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
-	}
-}
-
 /*
  * input MUX handling
  */
@@ -1110,7 +642,7 @@
 		snd_hda_codec_write(codec, spec->mux_nids[adc_idx], 0,
 				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
 	/* update jack power state */
-	set_jack_power_state(codec);
+	set_widgets_power_state(codec);
 
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx],
@@ -1417,7 +949,7 @@
 		}
 	}
 	spec->smart51_enabled = *ucontrol->value.integer.value;
-	set_jack_power_state(codec);
+	set_widgets_power_state(codec);
 	return 1;
 }
 
@@ -1941,7 +1473,7 @@
 	}
 
 	/* init power states */
-	set_jack_power_state(codec);
+	set_widgets_power_state(codec);
 	analog_low_current_mode(codec, 1);
 
 	via_free_kctls(codec); /* no longer needed */
@@ -2169,7 +1701,7 @@
 	if (res & VIA_GPIO_EVENT)
 		via_gpio_control(codec);
 	if (res & VIA_JACK_EVENT)
-		set_jack_power_state(codec);
+		set_widgets_power_state(codec);
 	if (res & VIA_MONO_EVENT)
 		via_mono_automute(codec);
 	if (res & VIA_SPEAKER_EVENT)
@@ -3613,6 +3145,75 @@
 	{ } /* end */
 };
 #endif
+
+static void set_widgets_power_state_vt1708B(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int imux_is_smixer;
+	unsigned int parm;
+	int is_8ch = 0;
+	if ((spec->codec_type != VT1708B_4CH) &&
+	    (codec->vendor_id != 0x11064397))
+		is_8ch = 1;
+
+	/* SW0 (17h) = stereo mixer */
+	imux_is_smixer =
+	(snd_hda_codec_read(codec, 0x17, 0, AC_VERB_GET_CONNECT_SEL, 0x00)
+	 == ((spec->codec_type == VT1708S) ? 5 : 0));
+	/* inputs */
+	/* PW 1/2/5 (1ah/1bh/1eh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x1a, &parm);
+	set_pin_power_state(codec, 0x1b, &parm);
+	set_pin_power_state(codec, 0x1e, &parm);
+	if (imux_is_smixer)
+		parm = AC_PWRST_D0;
+	/* SW0 (17h), AIW 0/1 (13h/14h) */
+	snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x13, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* outputs */
+	/* PW0 (19h), SW1 (18h), AOW1 (11h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x19, &parm);
+	if (spec->smart51_enabled)
+		set_pin_power_state(codec, 0x1b, &parm);
+	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW6 (22h), SW2 (26h), AOW2 (24h) */
+	if (is_8ch) {
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x22, &parm);
+		if (spec->smart51_enabled)
+			set_pin_power_state(codec, 0x1a, &parm);
+		snd_hda_codec_write(codec, 0x26, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x24, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	}
+
+	/* PW 3/4/7 (1ch/1dh/23h) */
+	parm = AC_PWRST_D3;
+	/* force to D0 for internal Speaker */
+	set_pin_power_state(codec, 0x1c, &parm);
+	set_pin_power_state(codec, 0x1d, &parm);
+	if (is_8ch)
+		set_pin_power_state(codec, 0x23, &parm);
+
+	/* MW0 (16h), Sw3 (27h), AOW 0/3 (10h/25h) */
+	snd_hda_codec_write(codec, 0x16, 0, AC_VERB_SET_POWER_STATE,
+			    imux_is_smixer ? AC_PWRST_D0 : parm);
+	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm);
+	if (is_8ch) {
+		snd_hda_codec_write(codec, 0x25, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x27, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	}
+}
+
 static int patch_vt1708S(struct hda_codec *codec);
 static int patch_vt1708B_8ch(struct hda_codec *codec)
 {
@@ -3663,6 +3264,8 @@
 	spec->loopback.amplist = vt1708B_loopbacks;
 #endif
 
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
+
 	return 0;
 }
 
@@ -3713,6 +3316,8 @@
 	spec->loopback.amplist = vt1708B_loopbacks;
 #endif
 
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
+
 	return 0;
 }
 
@@ -4147,6 +3752,7 @@
 		spec->stream_name_analog = "VT1708BCE Analog";
 		spec->stream_name_digital = "VT1708BCE Digital";
 	}
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
 	return 0;
 }
 
@@ -4404,6 +4010,37 @@
 };
 #endif
 
+static void set_widgets_power_state_vt1702(struct hda_codec *codec)
+{
+	int imux_is_smixer =
+	snd_hda_codec_read(codec, 0x13, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
+	unsigned int parm;
+	/* inputs */
+	/* PW 1/2/5 (14h/15h/18h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x14, &parm);
+	set_pin_power_state(codec, 0x15, &parm);
+	set_pin_power_state(codec, 0x18, &parm);
+	if (imux_is_smixer)
+		parm = AC_PWRST_D0; /* SW0 (13h) = stereo mixer (idx 3) */
+	/* SW0 (13h), AIW 0/1/2 (12h/1fh/20h) */
+	snd_hda_codec_write(codec, 0x13, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x12, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* outputs */
+	/* PW 3/4 (16h/17h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x17, &parm);
+	set_pin_power_state(codec, 0x16, &parm);
+	/* MW0 (1ah), AOW 0/1 (10h/1dh) */
+	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE,
+			    imux_is_smixer ? AC_PWRST_D0 : parm);
+	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_POWER_STATE, parm);
+}
+
 static int patch_vt1702(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -4450,6 +4087,7 @@
 	spec->loopback.amplist = vt1702_loopbacks;
 #endif
 
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1702;
 	return 0;
 }
 
@@ -4791,6 +4429,73 @@
 };
 #endif
 
+static void set_widgets_power_state_vt1718S(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int imux_is_smixer =
+	snd_hda_codec_read(codec, 0x13, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
+	unsigned int parm;
+	/* MUX6 (1eh) = stereo mixer */
+	imux_is_smixer =
+	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 5;
+	/* inputs */
+	/* PW 5/6/7 (29h/2ah/2bh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x29, &parm);
+	set_pin_power_state(codec, 0x2a, &parm);
+	set_pin_power_state(codec, 0x2b, &parm);
+	if (imux_is_smixer)
+		parm = AC_PWRST_D0;
+	/* MUX6/7 (1eh/1fh), AIW 0/1 (10h/11h) */
+	snd_hda_codec_write(codec, 0x1e, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* outputs */
+	/* PW3 (27h), MW2 (1ah), AOW3 (bh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x27, &parm);
+	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0xb, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW2 (26h), AOW2 (ah) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x26, &parm);
+	if (spec->smart51_enabled)
+		set_pin_power_state(codec, 0x2b, &parm);
+	snd_hda_codec_write(codec, 0xa, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW0 (24h), AOW0 (8h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x24, &parm);
+	if (!spec->hp_independent_mode) /* check for redirected HP */
+		set_pin_power_state(codec, 0x28, &parm);
+	snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE, parm);
+	/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
+	snd_hda_codec_write(codec, 0x21, 0, AC_VERB_SET_POWER_STATE,
+			    imux_is_smixer ? AC_PWRST_D0 : parm);
+
+	/* PW1 (25h), AOW1 (9h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x25, &parm);
+	if (spec->smart51_enabled)
+		set_pin_power_state(codec, 0x2a, &parm);
+	snd_hda_codec_write(codec, 0x9, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	if (spec->hp_independent_mode) {
+		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x28, &parm);
+		snd_hda_codec_write(codec, 0x1b, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x34, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0xc, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	}
+}
+
 static int patch_vt1718S(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -4852,6 +4557,8 @@
 	spec->loopback.amplist = vt1718S_loopbacks;
 #endif
 
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1718S;
+
 	return 0;
 }
 
@@ -4891,8 +4598,7 @@
 	snd_hda_codec_write(codec, 0x26, 0,
 					       AC_VERB_SET_CONNECT_SEL, index);
 	spec->dmic_enabled = index;
-	set_jack_power_state(codec);
-
+	set_widgets_power_state(codec);
 	return 1;
 }
 
@@ -5251,6 +4957,99 @@
 };
 #endif
 
+static void set_widgets_power_state_vt1716S(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int imux_is_smixer;
+	unsigned int parm;
+	unsigned int mono_out, present;
+	/* SW0 (17h) = stereo mixer */
+	imux_is_smixer =
+	(snd_hda_codec_read(codec, 0x17, 0,
+			    AC_VERB_GET_CONNECT_SEL, 0x00) ==  5);
+	/* inputs */
+	/* PW 1/2/5 (1ah/1bh/1eh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x1a, &parm);
+	set_pin_power_state(codec, 0x1b, &parm);
+	set_pin_power_state(codec, 0x1e, &parm);
+	if (imux_is_smixer)
+		parm = AC_PWRST_D0;
+	/* SW0 (17h), AIW0(13h) */
+	snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x13, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x1e, &parm);
+	/* PW11 (22h) */
+	if (spec->dmic_enabled)
+		set_pin_power_state(codec, 0x22, &parm);
+	else
+		snd_hda_codec_write(codec, 0x22, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+
+	/* SW2(26h), AIW1(14h) */
+	snd_hda_codec_write(codec, 0x26, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* outputs */
+	/* PW0 (19h), SW1 (18h), AOW1 (11h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x19, &parm);
+	/* Smart 5.1 PW2(1bh) */
+	if (spec->smart51_enabled)
+		set_pin_power_state(codec, 0x1b, &parm);
+	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW7 (23h), SW3 (27h), AOW3 (25h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x23, &parm);
+	/* Smart 5.1 PW1(1ah) */
+	if (spec->smart51_enabled)
+		set_pin_power_state(codec, 0x1a, &parm);
+	snd_hda_codec_write(codec, 0x27, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* Smart 5.1 PW5(1eh) */
+	if (spec->smart51_enabled)
+		set_pin_power_state(codec, 0x1e, &parm);
+	snd_hda_codec_write(codec, 0x25, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* Mono out */
+	/* SW4(28h)->MW1(29h)-> PW12 (2ah)*/
+	present = snd_hda_jack_detect(codec, 0x1c);
+
+	if (present)
+		mono_out = 0;
+	else {
+		present = snd_hda_jack_detect(codec, 0x1d);
+		if (!spec->hp_independent_mode && present)
+			mono_out = 0;
+		else
+			mono_out = 1;
+	}
+	parm = mono_out ? AC_PWRST_D0 : AC_PWRST_D3;
+	snd_hda_codec_write(codec, 0x28, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x29, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x2a, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW 3/4 (1ch/1dh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x1c, &parm);
+	set_pin_power_state(codec, 0x1d, &parm);
+	/* HP Independent Mode, power on AOW3 */
+	if (spec->hp_independent_mode)
+		snd_hda_codec_write(codec, 0x25, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+
+	/* force to D0 for internal Speaker */
+	/* MW0 (16h), AOW0 (10h) */
+	snd_hda_codec_write(codec, 0x16, 0, AC_VERB_SET_POWER_STATE,
+			    imux_is_smixer ? AC_PWRST_D0 : parm);
+	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE,
+			    mono_out ? AC_PWRST_D0 : parm);
+}
+
 static int patch_vt1716S(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -5305,6 +5104,7 @@
 	spec->loopback.amplist = vt1716S_loopbacks;
 #endif
 
+	spec->set_widgets_power_state = set_widgets_power_state_vt1716S;
 	return 0;
 }
 
@@ -5575,6 +5375,85 @@
 };
 #endif
 
+static void set_widgets_power_state_vt2002P(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int imux_is_smixer;
+	unsigned int parm;
+	unsigned int present;
+	/* MUX9 (1eh) = stereo mixer */
+	imux_is_smixer =
+	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
+	/* inputs */
+	/* PW 5/6/7 (29h/2ah/2bh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x29, &parm);
+	set_pin_power_state(codec, 0x2a, &parm);
+	set_pin_power_state(codec, 0x2b, &parm);
+	parm = AC_PWRST_D0;
+	/* MUX9/10 (1eh/1fh), AIW 0/1 (10h/11h) */
+	snd_hda_codec_write(codec, 0x1e, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* outputs */
+	/* AOW0 (8h)*/
+	snd_hda_codec_write(codec, 0x8, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW4 (26h), MW4 (1ch), MUX4(37h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x26, &parm);
+	snd_hda_codec_write(codec, 0x1c, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x37, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW1 (25h), MW1 (19h), MUX1(35h), AOW1 (9h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x25, &parm);
+	snd_hda_codec_write(codec, 0x19, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x35, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+
+	if (spec->hp_independent_mode)
+		snd_hda_codec_write(codec, 0x9, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
+	/* Class-D */
+	/* PW0 (24h), MW0(18h/14h), MUX0(34h) */
+	present = snd_hda_jack_detect(codec, 0x25);
+
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x24, &parm);
+	parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
+
+	snd_hda_codec_write(codec, 0x18, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x34, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* Mono Out */
+	present = snd_hda_jack_detect(codec, 0x26);
+
+	parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
+
+	/* PW15 (31h), MW8(17h), MUX8(3bh) */
+	snd_hda_codec_write(codec, 0x31, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x17, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x3b, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+
+	/* MW9 (21h) */
+	if (imux_is_smixer || !is_aa_path_mute(codec))
+		snd_hda_codec_write(codec, 0x21, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	else
+		snd_hda_codec_write(codec, 0x21, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+}
 
 /* patch for vt2002P */
 static int patch_vt2002P(struct hda_codec *codec)
@@ -5626,6 +5505,7 @@
 	spec->loopback.amplist = vt2002P_loopbacks;
 #endif
 
+	spec->set_widgets_power_state =  set_widgets_power_state_vt2002P;
 	return 0;
 }
 
@@ -5897,6 +5777,97 @@
 };
 #endif
 
+static void set_widgets_power_state_vt1812(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int imux_is_smixer =
+	snd_hda_codec_read(codec, 0x13, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
+	unsigned int parm;
+	unsigned int present;
+	/* MUX10 (1eh) = stereo mixer */
+	imux_is_smixer =
+	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 5;
+	/* inputs */
+	/* PW 5/6/7 (29h/2ah/2bh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x29, &parm);
+	set_pin_power_state(codec, 0x2a, &parm);
+	set_pin_power_state(codec, 0x2b, &parm);
+	parm = AC_PWRST_D0;
+	/* MUX10/11 (1eh/1fh), AIW 0/1 (10h/11h) */
+	snd_hda_codec_write(codec, 0x1e, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x10, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* outputs */
+	/* AOW0 (8h)*/
+	snd_hda_codec_write(codec, 0x8, 0,
+			    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
+	/* PW4 (28h), MW4 (18h), MUX4(38h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x28, &parm);
+	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x38, 0, AC_VERB_SET_POWER_STATE, parm);
+
+	/* PW1 (25h), MW1 (15h), MUX1(35h), AOW1 (9h) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x25, &parm);
+	snd_hda_codec_write(codec, 0x15, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x35, 0, AC_VERB_SET_POWER_STATE, parm);
+	if (spec->hp_independent_mode)
+		snd_hda_codec_write(codec, 0x9, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
+	/* Internal Speaker */
+	/* PW0 (24h), MW0(14h), MUX0(34h) */
+	present = snd_hda_jack_detect(codec, 0x25);
+
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x24, &parm);
+	if (present) {
+		snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		snd_hda_codec_write(codec, 0x34, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	} else {
+		snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		snd_hda_codec_write(codec, 0x34, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	}
+
+
+	/* Mono Out */
+	/* PW13 (31h), MW13(1ch), MUX13(3ch), MW14(3eh) */
+	present = snd_hda_jack_detect(codec, 0x28);
+
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x31, &parm);
+	if (present) {
+		snd_hda_codec_write(codec, 0x1c, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		snd_hda_codec_write(codec, 0x3c, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		snd_hda_codec_write(codec, 0x3e, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	} else {
+		snd_hda_codec_write(codec, 0x1c, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		snd_hda_codec_write(codec, 0x3c, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		snd_hda_codec_write(codec, 0x3e, 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	}
+
+	/* PW15 (33h), MW15 (1dh), MUX15(3dh) */
+	parm = AC_PWRST_D3;
+	set_pin_power_state(codec, 0x33, &parm);
+	snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_POWER_STATE, parm);
+	snd_hda_codec_write(codec, 0x3d, 0, AC_VERB_SET_POWER_STATE, parm);
+
+}
 
 /* patch for vt1812 */
 static int patch_vt1812(struct hda_codec *codec)
@@ -5950,6 +5921,7 @@
 	spec->loopback.amplist = vt1812_loopbacks;
 #endif
 
+	spec->set_widgets_power_state =  set_widgets_power_state_vt1812;
 	return 0;
 }
