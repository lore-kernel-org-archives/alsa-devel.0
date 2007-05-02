From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: [PATCH] multi-channel playback and capture fixes for
	stac92xx codecs
Date: Wed, 02 May 2007 16:52:23 -0700
Message-ID: <46392437.7040807@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080105090401090404060604"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.biz.mail.mud.yahoo.com (smtp107.biz.mail.mud.yahoo.com
	[68.142.200.255]) by alsa0.perex.cz (Postfix) with SMTP id C1D7C2448E
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 01:52:25 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080105090401090404060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have picked up where Matt Porter left off on stac92xx HDA codec devel. 
I've been working with the 9200, 9221, 9202, 9250, and 9205 codecs, and 
I found some problems with muti-channel playback on 922x and 9205. Also 
a problem with input mux selection for codecs with more than one 
configured input pin. I've tested the attached patch on all the above 
listed codecs.

Steve

--------------080105090401090404060604
Content-Type: text/x-patch;
 name="stac92xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac92xx.patch"

searching for changes
changeset:   5026:3bb67e1503c4
tag:         tip
user:        stevel@embeddedalley.com
date:        Wed May 02 15:51:36 2007 -0700
summary:     bug fixes for stac92xx HDA codecs.

* fixed surround playback on stac922x. Pin direction control bits were
  not being set correctly in stac92xx_set_pinctl(). Specifically it
  would refuse to set the port as an output if the port was already
  configured as an input. Last hunk (#8).

* fixed an input mux bug on 92xx codecs. When there is more than one
  possible input calculated for the muxes, the actual mux widget never
  gets set from its reset default, which is index 0, in the stac9221
  case that is port E. So alsamixer/amixer/gnome-mixer report the Mic
  as being the selected input source, but in fact is something else
  (line-in port E in stac9221 case). Another problem with this is that
  if you actually try to set the mux input to "Mic", nothing happens
  because *cur_val == idx (see snd_hda_input_mux_put). You have to
  actually toggle input source to line-in then back to mic to actually
  set the mux widget. Hunk #7.

* fixed some typos in patch_sigmatel.c. Hunk #6.

* fix to stac92xx_add_dyn_out_pins() that fixes surround playback on
  codecs with less that 4 DACs (stac9205 for example). It reads the widget
  caps cache created by hda_codec to count the total number of analog DACs
  found. It then uses that to determine whether there will be enough
  independent DACs available for line/mic switch controls. Hunk #1, #2,
  and #3.

* improvements to stac92xx_auto_fill_dac_nids() to make it more general.
  This fixes surround playback on some codecs in combination with the
  fix to stac92xx_add_dyn_out_pins() above. It reads the full connection
  list now, instead of just the first entry, and then locates an analog
  DAC in the list. If one is found and it's free, assign it to that line-out.
  If no free DAC is found for the line-out, return -ENODEV. It also makes
  sure to actually select the chosen DAC if more than one DAC is input to
  the pin. Hunks #4, #5.

diff -r 4e09f3b9fd66 -r 3bb67e1503c4 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed May 02 12:09:48 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Wed May 02 15:51:36 2007 -0700
@@ -1070,11 +1070,23 @@ static int stac92xx_add_dyn_out_pins(str
 static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
-
+	unsigned int wcaps, wtype;
+	int i, num_dacs=0;
+	
+	/* use the wcaps cache to count all DACs available for line-outs */
+	for (i=0; i < codec->num_nodes; i++) {
+		wcaps = codec->wcaps[i];
+		wtype = (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
+		if (wtype == AC_WID_AUD_OUT && !(wcaps & AC_WCAP_DIGITAL))
+			num_dacs++;
+	}
+
+	snd_printdd("%s: total dac count=%d\n", __func__, num_dacs);
+	
 	switch (cfg->line_outs) {
 	case 3:
 		/* add line-in as side */
-		if (cfg->input_pins[AUTO_PIN_LINE]) {
+		if (cfg->input_pins[AUTO_PIN_LINE] && num_dacs > 3) {
 			cfg->line_out_pins[3] = cfg->input_pins[AUTO_PIN_LINE];
 			spec->line_switch = 1;
 			cfg->line_outs++;
@@ -1082,12 +1094,12 @@ static int stac92xx_add_dyn_out_pins(str
 		break;
 	case 2:
 		/* add line-in as clfe and mic as side */
-		if (cfg->input_pins[AUTO_PIN_LINE]) {
+		if (cfg->input_pins[AUTO_PIN_LINE] && num_dacs > 2) {
 			cfg->line_out_pins[2] = cfg->input_pins[AUTO_PIN_LINE];
 			spec->line_switch = 1;
 			cfg->line_outs++;
 		}
-		if (cfg->input_pins[AUTO_PIN_MIC]) {
+		if (cfg->input_pins[AUTO_PIN_MIC] && num_dacs > 3) {
 			cfg->line_out_pins[3] = cfg->input_pins[AUTO_PIN_MIC];
 			spec->mic_switch = 1;
 			cfg->line_outs++;
@@ -1095,12 +1107,12 @@ static int stac92xx_add_dyn_out_pins(str
 		break;
 	case 1:
 		/* add line-in as surr and mic as clfe */
-		if (cfg->input_pins[AUTO_PIN_LINE]) {
+		if (cfg->input_pins[AUTO_PIN_LINE] && num_dacs > 1) {
 			cfg->line_out_pins[1] = cfg->input_pins[AUTO_PIN_LINE];
 			spec->line_switch = 1;
 			cfg->line_outs++;
 		}
-		if (cfg->input_pins[AUTO_PIN_MIC]) {
+		if (cfg->input_pins[AUTO_PIN_MIC] && num_dacs > 2) {
 			cfg->line_out_pins[2] = cfg->input_pins[AUTO_PIN_MIC];
 			spec->mic_switch = 1;
 			cfg->line_outs++;
@@ -1111,33 +1123,76 @@ static int stac92xx_add_dyn_out_pins(str
 	return 0;
 }
 
+
+static int is_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
+{
+	int i;
+	
+	for (i = 0; i < spec->multiout.num_dacs; i++) {
+		if (spec->multiout.dac_nids[i] == nid)
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
- * XXX The line_out pin widget connection list may not be set to the
- * desired DAC nid. This is the case on 927x where ports A and B can
- * be routed to several DACs.
- *
- * This requires an analysis of the line-out/hp pin configuration
- * to provide a best fit for pin/DAC configurations that are routable.
- * For now, 927x DAC4 is not supported and 927x DAC1 output to ports
- * A and B is not supported.
+ * Fill in the dac_nids table from the parsed pin configuration
+ * This function only works when every pin in line_out_pins[]
+ * contains atleast one DAC in its connection list. Some 92xx
+ * codecs are not connected directly to a DAC, such as the 9200
+ * and 9202/925x. For those, dac_nids[] must be hard-coded.
  */
-/* fill in the dac_nids table from the parsed pin configuration */
 static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec,
 				       const struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	hda_nid_t nid;
-	int i;
-
-	/* check the pins hardwired to audio widget */
+	int i, j, conn_len = 0; 
+	hda_nid_t nid, conn[HDA_MAX_CONNECTIONS];
+	unsigned int wcaps, wtype;
+	
 	for (i = 0; i < cfg->line_outs; i++) {
 		nid = cfg->line_out_pins[i];
-		spec->multiout.dac_nids[i] = snd_hda_codec_read(codec, nid, 0,
-					AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
-	}
-
-	spec->multiout.num_dacs = cfg->line_outs;
-
+		conn_len = snd_hda_get_connections(codec, nid, conn,
+						   HDA_MAX_CONNECTIONS);
+		for (j = 0; j < conn_len; j++) {
+			wcaps = snd_hda_param_read(codec, conn[j],
+						   AC_PAR_AUDIO_WIDGET_CAP);
+			wtype = (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
+
+			if (wtype != AC_WID_AUD_OUT ||
+			    (wcaps & AC_WCAP_DIGITAL))
+				continue;
+			/* conn[j] is a DAC routed to this line-out */
+			if (!is_in_dac_nids(spec, conn[j]))
+				break;
+		}
+
+		if (j == conn_len) {
+			/* error out, no available DAC found */
+			snd_printk(KERN_ERR
+				   "%s: No available DAC for pin 0x%x\n",
+				   __func__, nid);
+			return -ENODEV;
+		}
+
+		spec->multiout.dac_nids[i] = conn[j];
+		spec->multiout.num_dacs++;
+		if (conn_len > 1) {
+			/* select this DAC in the pin's input mux */
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_CONNECT_SEL, j);
+
+		}
+	}
+
+	snd_printd("dac_nids=%d (0x%x/0x%x/0x%x/0x%x/0x%x)\n",
+		   spec->multiout.num_dacs,
+		   spec->multiout.dac_nids[0],
+		   spec->multiout.dac_nids[1],
+		   spec->multiout.dac_nids[2],
+		   spec->multiout.dac_nids[3],
+		   spec->multiout.dac_nids[4]);
 	return 0;
 }
 
@@ -1204,12 +1259,8 @@ static int stac92xx_auto_create_multi_ou
 
 static int check_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
 {
-	int i;
-
-	for (i = 0; i < spec->multiout.num_dacs; i++) {
-		if (spec->multiout.dac_nids[i] == nid)
-			return 1;
-	}
+	if (is_in_dac_nids(spec, nid))
+		return 1;
 	if (spec->multiout.hp_nid == nid)
 		return 1;
 	return 0;
@@ -1251,10 +1302,8 @@ static int stac92xx_auto_create_hp_ctls(
 		add_spec_dacs(spec, nid);
 	}
 	for (i = 0; i < cfg->speaker_outs; i++) {
-		nid = snd_hda_codec_read(codec, cfg->speaker_pins[0], 0,
+		nid = snd_hda_codec_read(codec, cfg->speaker_pins[i], 0,
 					 AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
-		if (check_in_dac_nids(spec, nid))
-			nid = 0;
 		if (check_in_dac_nids(spec, nid))
 			nid = 0;
 		if (! nid)
@@ -1370,7 +1419,7 @@ static int stac92xx_auto_create_analog_i
 		imux->num_items++;
 	}
 
-	if (imux->num_items == 1) {
+	if (imux->num_items) {
 		/*
 		 * Set the current input for the muxes.
 		 * The STAC9221 has two input muxes with identical source
@@ -1690,8 +1739,12 @@ static void stac92xx_set_pinctl(struct h
 {
 	unsigned int pin_ctl = snd_hda_codec_read(codec, nid,
 			0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0x00);
-	if (flag == AC_PINCTL_OUT_EN && (pin_ctl & AC_PINCTL_IN_EN))
-		return;
+
+	/* if setting pin direction bits, clear the current
+	   direction bits first */
+	if (flag & (AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN))
+		pin_ctl &= ~(AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN);
+	
 	snd_hda_codec_write(codec, nid, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL,
 			pin_ctl | flag);


--------------080105090401090404060604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080105090401090404060604--
