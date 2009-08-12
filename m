From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - fix noise issue when recording
	from digital mic with alc268
Date: Tue, 11 Aug 2009 22:33:09 -0300
Message-ID: <200908112233.10032.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WvhgKpOYYIxLBcC"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id A40E91037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 03:33:16 +0200 (CEST)
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

--Boundary-00=_WvhgKpOYYIxLBcC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

With auto config model of alc268 realtek codec, it allows to select any
of possible available digital microphone inputs when only one is
available. For example, when only digital mic in nid 0x12 is available,
on second input source it will allow you to select unavailable digital
mic in nid 0x13. The problem is that selecting unavailable digital mic
creates a source of noise when recording (I'm not sure if this happens
on all machines with alc268 and only one digital mic input, but testing
on a quanta uw1 netbook a lot of noise is introduced in recording from
digital mic 0x12/first input source, when you select the unavailable
digital mic 0x13 for capture source 0x24 in the second input source in
mixer).

Then to avoid noise when recording from digital mic with auto model in
this case, prevent a digital mic input source to be selected if
microphone is not available.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |   62 +++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 26 deletions(-)

I'm attaching the codec info too here of the machine with the problem.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ac3207e..7ff2934 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12232,32 +12232,40 @@ static int alc268_auto_create_analog_input_ctls(struct alc_spec *spec,
 						const struct auto_pin_cfg *cfg)
 {
 	struct hda_input_mux *imux = &spec->private_imux[0];
-	int i, idx1;
-
-	for (i = 0; i < AUTO_PIN_LAST; i++) {
-		switch(cfg->input_pins[i]) {
-		case 0x18:
-			idx1 = 0;	/* Mic 1 */
-			break;
-		case 0x19:
-			idx1 = 1;	/* Mic 2 */
-			break;
-		case 0x1a:
-			idx1 = 2;	/* Line In */
-			break;
-		case 0x1c:
-			idx1 = 3;	/* CD */
-			break;
-		case 0x12:
-		case 0x13:
-			idx1 = 6;	/* digital mics */
-			break;
-		default:
-			continue;
+	int i, idx1, dmic_nid;
+
+	dmic_nid = 0x12;
+	while (dmic_nid <= 0x13) {
+		for (i = 0; i < AUTO_PIN_LAST; i++) {
+			switch (cfg->input_pins[i]) {
+			case 0x18:
+				idx1 = 0;	/* Mic 1 */
+				break;
+			case 0x19:
+				idx1 = 1;	/* Mic 2 */
+				break;
+			case 0x1a:
+				idx1 = 2;	/* Line In */
+				break;
+			case 0x1c:
+				idx1 = 3;	/* CD */
+				break;
+			case 0x12:
+			case 0x13:
+				if (cfg->input_pins[i] != dmic_nid)
+					continue;
+				idx1 = 6;	/* digital mics */
+				break;
+			default:
+				continue;
+			}
+			imux->items[imux->num_items].label =
+				auto_pin_cfg_labels[i];
+			imux->items[imux->num_items].index = idx1;
+			imux->num_items++;
 		}
-		imux->items[imux->num_items].label = auto_pin_cfg_labels[i];
-		imux->items[imux->num_items].index = idx1;
-		imux->num_items++;
+		imux++;
+		dmic_nid++;
 	}
 	return 0;
 }
@@ -12355,7 +12363,7 @@ static int alc268_parse_auto_config(struct hda_codec *codec)
 		add_mixer(spec, alc268_beep_mixer);
 
 	add_verb(spec, alc268_volume_init_verbs);
-	spec->num_mux_defs = 1;
+	spec->num_mux_defs = 2;
 	spec->input_mux = &spec->private_imux[0];
 
 	err = alc_auto_add_mic_boost(codec);
@@ -12665,6 +12673,8 @@ static int patch_alc268(struct hda_codec *codec)
 		for (i = 0; i < spec->num_adc_nids; i++)
 			snd_hda_codec_write_cache(codec, alc268_capsrc_nids[i],
 				0, AC_VERB_SET_CONNECT_SEL,
+				i < spec->num_mux_defs ?
+				spec->input_mux[i].items[0].index :
 				spec->input_mux->items[0].index);
 	}
 
-- 
1.6.4


--Boundary-00=_WvhgKpOYYIxLBcC
Content-Type: text/plain;
  charset="UTF-8";
  name="quanta-uw1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="quanta-uw1"

Codec: Realtek ALC268
Address: 0
Vendor Id: 0x10ec0268
Subsystem Id: 0x152d1777
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x33 0x33]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x100111: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x100111: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00]
  Connection: 1
     0x02
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x1d
Node 0x10 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x80 0x80]
  Connection: 3
     0x03 0x1d 0x02
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x99a30920: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0f
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0321401f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=04, enabled=1
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x01 0x01]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x03a19830: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4015812d: [N/A] Speaker at Ext N/A
    Conn = Optical, Color = Purple
    DefAssociation = 0x2, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=10
  Processing Coefficient: 0x00
  Coefficient Index: 0x09
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x0a, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x18 0x18]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x12
Node 0x24 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x0a, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x18 0x18]
  Connection: 7
     0x18 0x19 0x1a 0x1c 0x14 0x15 0x13*

--Boundary-00=_WvhgKpOYYIxLBcC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_WvhgKpOYYIxLBcC--
