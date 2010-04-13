From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - via - fix master mute and automute
	with VT1812/VT2002P
Date: Tue, 13 Apr 2010 15:38:53 -0300
Message-ID: <201004131538.53860.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9oLxLBN8bhCZjfo"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E7DE103879
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 20:39:00 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_9oLxLBN8bhCZjfo
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On VIA VT1812/VT2002P, the "Master Front Playback Switch" doesn't mute
first line-out. This is an issue, for example I saw a laptop with VT1812
and only one line-out (main speaker) that doesn't mute main speaker,
because the master switch doesn't act on first line-out, and first
line-out nid in array is assigned to speaker as expected by autoconfig
code.

But there is one more issue also: main switches and automute code deal
with mute on same Amp-Outs, which can cause conflicts, thus if you mute
"Master Front Playback Switch" and remove headphone for example, it will
not respect the mixer setting. To solve it, we can change the pin type
instead of muting Amp-Out, which is done here.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_via.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

Hi, I'm attaching the codec file of the laptop with the issue, this is kernel log
relevant info:
autoconfig: line_outs=1 (0x24/0x0/0x0/0x0/0x0)
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=1 (0x33/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: mic=0x29, fmic=0x2b, line=0x0, fline=0x0, cd=0x0, aux=0x0

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 9ddc373..d6e6f40 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -295,8 +295,6 @@ static int analog_input_switch_put(struct snd_kcontrol *kcontrol,
 			.put = analog_input_switch_put,			\
 			.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0) }
 
-static void via_hp_bind_automute(struct hda_codec *codec);
-
 static int bind_pin_switch_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
@@ -343,13 +341,10 @@ static int bind_pin_switch_put(struct snd_kcontrol *kcontrol,
 			snd_hda_codec_amp_stereo(
 				codec, spec->autocfg.speaker_pins[i],
 				HDA_OUTPUT, 0, HDA_AMP_MUTE, 0);
-		/* unmute */
-		via_hp_bind_automute(codec);
-
 	} else {
 		if (lmute) {
 			/* Mute all left channels */
-			for (i = 1; i < spec->autocfg.line_outs; i++)
+			for (i = 0; i < spec->autocfg.line_outs; i++)
 				snd_hda_codec_amp_update(
 					codec,
 					spec->autocfg.line_out_pins[i],
@@ -364,7 +359,7 @@ static int bind_pin_switch_put(struct snd_kcontrol *kcontrol,
 		}
 		if (rmute) {
 			/* mute all right channels */
-			for (i = 1; i < spec->autocfg.line_outs; i++)
+			for (i = 0; i < spec->autocfg.line_outs; i++)
 				snd_hda_codec_amp_update(
 					codec,
 					spec->autocfg.line_out_pins[i],
@@ -2129,18 +2124,18 @@ static void via_hp_bind_automute(struct hda_codec *codec)
 	if (!spec->hp_independent_mode) {
 		/* Mute Line-Outs */
 		for (i = 0; i < spec->autocfg.line_outs; i++)
-			snd_hda_codec_amp_stereo(
-				codec, spec->autocfg.line_out_pins[i],
-				HDA_OUTPUT, 0,
-				HDA_AMP_MUTE, hp_present ? HDA_AMP_MUTE : 0);
+			snd_hda_codec_write(codec,
+					    spec->autocfg.line_out_pins[i],
+					    0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+					    hp_present ? 0 : PIN_OUT);
 		if (hp_present)
 			present = hp_present;
 	}
 	/* Speakers */
 	for (i = 0; i < spec->autocfg.speaker_outs; i++)
-		snd_hda_codec_amp_stereo(
-			codec, spec->autocfg.speaker_pins[i], HDA_OUTPUT, 0,
-			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+		snd_hda_codec_write(codec, spec->autocfg.speaker_pins[i], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    present ? 0 : PIN_OUT);
 }
 
 
-- 
1.7.0.4


--Boundary-00=_9oLxLBN8bhCZjfo
Content-Type: text/plain;
  charset="UTF-8";
  name="codec_via.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="codec_via.txt"

Codec: VIA VT1812
Address: 0
Function Id: 0x1
Vendor Id: 0x11060448
Subsystem Id: 0x15584120
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x08 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Master Front Playback Volume", index=0, device=0
  Device: name="VT1812 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x09 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x21 0x21]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
  Control: name="Capture Switch", index=0, device=0
  Device: name="VT1812 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1e 0x1e]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x1e
Node 0x11 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=1, device=0
  Control: name="Capture Switch", index=1, device=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1e 0x1e]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x34 0x21
Node 0x15 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x35 0x21
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x38 0x21
Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x39 0x21
Node 0x1a [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x3a 0x21
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x3c 0x21
Node 0x1d [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x3d 0x21
Node 0x1e [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 7
     0x2b* 0x2a 0x29 0x28 0x25 0x21 0x30
Node 0x1f [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 7
     0x2b* 0x2a 0x29 0x28 0x25 0x21 0x30
Node 0x20 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
  Control: name="Mic Playback Switch", index=0, device=0
  Control: name="Front Mic Playback Volume", index=0, device=0
  Control: name="Front Mic Playback Switch", index=0, device=0
  Control: name="Stereo Mixer Playback Volume", index=0, device=0
  Control: name="Stereo Mixer Playback Switch", index=0, device=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x9e 0x9e] [0x80 0x80] [0x9e 0x9e] [0x80 0x80] [0x80 0x80]
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 5
     0x2b 0x2a 0x29 0x28 0x25
Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
  Amp-Out caps: ofs=0x0a, nsteps=0x12, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x23 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x24 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x14
Node 0x25 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x422140f0: [N/A] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
  Connection: 1
     0x15
Node 0x26 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x27 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Master Front Playback Switch", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x410140f0: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=24, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
  Connection: 1
     0x18
Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Mic Boost Capture Volume", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x90a701f0: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x19
Node 0x2a [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x418130f8: [N/A] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0xf, Sequence = 0x8
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
  Connection: 1
     0x1a
Node 0x2b [Pin Complex] wcaps 0x400481: Stereo
  Control: name="Mic Boost Capture Volume", index=0, device=0
  Pincap 0x00002324: IN Detect
    Vref caps: HIZ 50 100
  Pin Default 0x01a190f0: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
Node 0x2c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x2d [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x474411f0: [N/A] SPDIF Out at Ext Rear Panel
    Conn = RCA, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0e
Node 0x2e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x2f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x30 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x50a601f0: [N/A] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x31 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x501701f0: [N/A] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
  Connection: 1
     0x3e
Node 0x32 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x33 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=24, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D3, actual=D3
  Connection: 1
     0x1d
Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x08* 0x09
Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x08* 0x09
Node 0x36 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x37 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x38 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x08* 0x09
Node 0x39 [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x08* 0x09
Node 0x3a [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x08* 0x09
Node 0x3b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x3c [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x08* 0x09
Node 0x3d [Audio Selector] wcaps 0x300501: Stereo
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x08* 0x09
Node 0x3e [Audio Mixer] wcaps 0x200500: Mono
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1c

--Boundary-00=_9oLxLBN8bhCZjfo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_9oLxLBN8bhCZjfo--
