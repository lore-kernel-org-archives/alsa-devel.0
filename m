From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Mon, 12 Jul 2010 08:57:59 +0200
Message-ID: <4C3ABCF7.3050108@ladisch.de>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
	<4C35713E.1090709@ladisch.de> <op.vfi2hgary9cctd@localhost>
	<op.vfko2mysy9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 940C6103809
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 08:58:04 +0200 (CEST)
In-Reply-To: <op.vfko2mysy9cctd@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Viliam Kubis <viliam.kubis@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Viliam Kubis wrote:
> I have tried the patch ..., but the surround does not work.

Okay, next try:

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -552,24 +552,30 @@ static void via_auto_init_hp_out(struct
 	}
 }
 
+static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin);
+
 static void via_auto_init_analog_input(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
+	unsigned int ctl;
 	int i;
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
 		hda_nid_t nid = spec->autocfg.input_pins[i];
+		if (!nid)
+			continue;
 
+		if (spec->smart51_enabled && is_smart51_pins(spec, nid))
+			ctl = PIN_OUT;
+		else if (i <= AUTO_PIN_FRONT_MIC)
+			ctl = PIN_VREF50;
+		else
+			ctl = PIN_IN;
 		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    (i <= AUTO_PIN_FRONT_MIC ?
-				     PIN_VREF50 : PIN_IN));
-
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
 	}
 }
 
-static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin);
-
 static void set_pin_power_state(struct hda_codec *codec, hda_nid_t nid,
 				unsigned int *affected_parm)
 {
@@ -658,6 +664,8 @@ static void set_jack_power_state(struct
 		/* PW0 (19h), SW1 (18h), AOW1 (11h) */
 		parm = AC_PWRST_D3;
 		set_pin_power_state(codec, 0x19, &parm);
+		if (spec->smart51_enabled)
+			parm = AC_PWRST_D0;
 		snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_POWER_STATE,
 				    parm);
 		snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_POWER_STATE,
@@ -667,6 +675,8 @@ static void set_jack_power_state(struct
 		if (is_8ch) {
 			parm = AC_PWRST_D3;
 			set_pin_power_state(codec, 0x22, &parm);
+			if (spec->smart51_enabled)
+				parm = AC_PWRST_D0;
 			snd_hda_codec_write(codec, 0x26, 0,
 					    AC_VERB_SET_POWER_STATE, parm);
 			snd_hda_codec_write(codec, 0x24, 0,
@@ -3915,6 +3925,13 @@ static int vt1708S_auto_fill_dac_nids(st
 		}
 	}
 
+	/* for Smart 5.1, line/mic inputs double as output pins */
+	if (cfg->line_outs == 1) {
+		spec->multiout.num_dacs = 3;
+		spec->multiout.dac_nids[AUTO_SEQ_SURROUND] = 0x11;
+		spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x24;
+	}
+
 	return 0;
 }
 
@@ -3932,7 +3949,8 @@ static int vt1708S_auto_create_multi_out
 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
 		nid = cfg->line_out_pins[i];
 
-		if (!nid)
+		/* for Smart 5.1, there are always at least six channels */
+		if (!nid && i > AUTO_SEQ_CENLFE)
 			continue;
 
 		nid_vol = nid_vols[i];
