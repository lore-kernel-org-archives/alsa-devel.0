From: Matt <matt@embeddedalley.com>
Subject: Re: [PATCH] SigmaTel HDA SPDIF and input mux updates
Date: Mon, 13 Jun 2005 19:31:14 -0700
Message-ID: <20050613193114.A8743@cox.net>
References: <20050612074151.A29512@cox.net> <s5hk6kye6k7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hk6kye6k7.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 13, 2005 at 03:21:12PM +0200
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 13, 2005 at 03:21:12PM +0200, Takashi Iwai wrote:
> At Sun, 12 Jun 2005 07:41:51 -0700,
> Matt wrote:
> > 
> > +	if (input) {
> > +		if (!type)
> > +			type = "Input";
> > +		label = spec->input_labels[spec->input_mux.num_items];
> > +		strcpy(label, type);
> > +		spec->input_mux.items[spec->input_mux.num_items].label = label;
> > +		spec->input_mux.num_items++;
> 
> You didn't set index value - does this work?

Gah, no, it's brown paper bag time.  I sent an intermediate patch. I
should really not make local patch names similar.

Here's the working version that I tested. :)

Signed-off-by: Matt <matt@embeddedalley.com>

Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.1
diff -u -r1.1 patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	13 Apr 2005 13:45:31 -0000	1.1
+++ alsa-kernel/pci/hda/patch_sigmatel.c	12 Jun 2005 15:03:55 -0000
@@ -42,9 +42,11 @@
 
 	/* capture */
 	hda_nid_t *adc_nids;
-	hda_nid_t *mux_nids;
 	unsigned int num_adcs;
+	hda_nid_t *mux_nids;
+	unsigned int num_muxes;
 	hda_nid_t capture_nid;
+	hda_nid_t dig_in_nid;
 
 	/* power management*/
 	hda_nid_t *pstate_nids;
@@ -62,7 +64,8 @@
 	snd_kcontrol_new_t *mixer;
 
 	/* capture source */
-	const struct hda_input_mux *input_mux;
+	struct hda_input_mux input_mux;
+	char input_labels[HDA_MAX_NUM_INPUTS][16];
 	unsigned int cur_mux[2];
 
 	/* channel mode */
@@ -105,8 +108,8 @@
         0x02, 0x03, 0x04, 0x05,
 };
 
-static hda_nid_t stac922x_pstate_nids[7] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+static hda_nid_t stac922x_pstate_nids[8] = {
+	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x11,
 };
 
 static hda_nid_t stac922x_pin_nids[10] = {
@@ -118,7 +121,7 @@
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
-	return snd_hda_input_mux_info(spec->input_mux, uinfo);
+	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
 }
 
 static int stac92xx_mux_enum_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
@@ -137,7 +140,7 @@
 	struct sigmatel_spec *spec = codec->spec;
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 
-	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+	return snd_hda_input_mux_put(codec, &spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx], &spec->cur_mux[adc_idx]);
 }
 
@@ -192,30 +195,6 @@
 	{ } /* end */
 };
 
-static struct hda_input_mux stac9200_input_mux = {
-	.num_items = 5,
-	.items = {
-		{ "Port B", 0x0 },
-		{ "Port C", 0x1 },
-		{ "Port D", 0x2 },
-		{ "Port A", 0x3 },
-		{ "CD", 0x4 },
-	}
-};
-
-static struct hda_input_mux stac922x_input_mux = {
-	.num_items = 7,
-	.items = {
-		{ "Port E", 0x0 },
-		{ "CD", 0x1 },
-		{ "Port F", 0x2 },
-		{ "Port B", 0x3 },
-		{ "Port C", 0x4 },
-		{ "Port D", 0x5 },
-		{ "Port A", 0x6 },
-	}
-};
-
 static int stac92xx_build_controls(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -224,19 +203,28 @@
 	err = snd_hda_add_new_ctls(codec, spec->mixer);
 	if (err < 0)
 		return err;
-
-	return 0;
+	if (spec->multiout.dig_out_nid) {
+		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+		if (err < 0)
+			return err;
+	}
+	if (spec->dig_in_nid) {
+		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
+		if (err < 0)
+			return err;
+	}
+	return 0;	
 }
 
 #ifdef STAC_TEST
 static unsigned int stac9200_pin_configs[8] = {
-	0x40000100, 0x40000100, 0x0221401f, 0x01114010,
+	0x01c47010, 0x01447010, 0x0221401f, 0x01114010,
 	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
 };
 
 static unsigned int stac922x_pin_configs[14] = {
 	0x40000100, 0x40000100, 0x40000100, 0x01114010,
-	0x01813122, 0x40000100, 0x40000100, 0x40000100,
+	0x01813122, 0x40000100, 0x01447010, 0x01c47010,
 	0x40000100, 0x40000100,
 };
 
@@ -299,29 +287,89 @@
 	return 0;
 }
 
+/*
+ * retrieve the default device type from the default config value
+ */
+#define get_defcfg_type(cfg) ((cfg & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT)
+#define get_defcfg_location(cfg) ((cfg & AC_DEFCFG_LOCATION) >> AC_DEFCFG_LOCATION_SHIFT)
+
 static int stac92xx_config_pin(struct hda_codec *codec, hda_nid_t nid, unsigned int pin_cfg)
 {
-	switch((pin_cfg & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT) {
+	struct sigmatel_spec *spec = codec->spec;
+	u32 location = get_defcfg_location(pin_cfg);
+	char *label;
+	const char *type = NULL;
+	int ainput = 0;
+
+	switch(get_defcfg_type(pin_cfg)) {
 		case AC_JACK_HP_OUT:
 			/* Enable HP amp */
 			stac92xx_set_pinctl(codec, nid, AC_PINCTL_HP_EN);
 			/* Fall through */
+		case AC_JACK_SPDIF_OUT:
 		case AC_JACK_LINE_OUT:
 		case AC_JACK_SPEAKER:
 			/* Enable output */
 			stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
 			break;
+		case AC_JACK_SPDIF_IN:
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
+			break;
 		case AC_JACK_MIC_IN:
+			if ((location & 0x0f) == AC_JACK_LOC_FRONT)
+				type = "Front Mic";
+			else
+				type = "Mic";
+			ainput = 1;
 			/* Set vref */
 			stac92xx_set_vref(codec, nid);
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
+			break;
 		case AC_JACK_CD:
+			type = "CD";
+			ainput = 1;
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
+			break;
 		case AC_JACK_LINE_IN:
+			if ((location & 0x0f) == AC_JACK_LOC_FRONT)
+				type = "Front Line";
+			else
+				type = "Line";
+			ainput = 1;
+			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
+			break;
 		case AC_JACK_AUX:
-			/* Enable input */
+			if ((location & 0x0f) == AC_JACK_LOC_FRONT)
+				type = "Front Aux";
+			else
+				type = "Aux";
+			ainput = 1;
 			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
 			break;
 	}
 
+	if (ainput) {
+		hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
+		int i, j, num_cons, index = -1;
+		if (!type)
+			type = "Input";
+		label = spec->input_labels[spec->input_mux.num_items];
+		strcpy(label, type);
+		spec->input_mux.items[spec->input_mux.num_items].label = label;
+		for (i=0; i<spec->num_muxes; i++) {
+			num_cons = snd_hda_get_connections(codec, spec->mux_nids[i], con_lst, HDA_MAX_NUM_INPUTS);
+			for (j=0; j<num_cons; j++)
+				if (con_lst[j] == nid) {
+					index = j;
+					break;
+				}
+			if (index >= 0)
+				break;
+		}
+		spec->input_mux.items[spec->input_mux.num_items].index = index;
+		spec->input_mux.num_items++;
+	}
+
 	return 0;
 }
 
@@ -402,6 +450,26 @@
 }
 
 /*
+ * Digital playback callbacks
+ */
+static int stac92xx_dig_playback_pcm_open(struct hda_pcm_stream *hinfo,
+					  struct hda_codec *codec,
+					  snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
+}
+
+static int stac92xx_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
+					   struct hda_codec *codec,
+					   snd_pcm_substream_t *substream)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
+}
+
+
+/*
  * Analog capture callbacks
  */
 static int stac92xx_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -427,6 +495,24 @@
 	return 0;
 }
 
+static struct hda_pcm_stream stac92xx_pcm_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in stac92xx_build_pcms */
+	.ops = {
+		.open = stac92xx_dig_playback_pcm_open,
+		.close = stac92xx_dig_playback_pcm_close
+	},
+};
+
+static struct hda_pcm_stream stac92xx_pcm_digital_capture = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in stac92xx_build_pcms */
+};
+
 static struct hda_pcm_stream stac92xx_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
@@ -464,6 +550,20 @@
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = stac92xx_pcm_analog_capture;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->capture_nid;
 
+	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
+		codec->num_pcms++;
+		info++;
+		info->name = "STAC92xx Digital";
+		if (spec->multiout.dig_out_nid) {
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK] = stac92xx_pcm_digital_playback;
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dig_out_nid;
+		}
+		if (spec->dig_in_nid) {
+			info->stream[SNDRV_PCM_STREAM_CAPTURE] = stac92xx_pcm_digital_capture;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in_nid;
+		}
+	}
+
 	return 0;
 }
 
@@ -492,9 +592,12 @@
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = 1;
 	spec->multiout.dac_nids = stac9200_dac_nids;
+	spec->multiout.dig_out_nid = 0x05;
+	spec->dig_in_nid = 0x04;
 	spec->adc_nids = stac9200_adc_nids;
 	spec->mux_nids = stac9200_mux_nids;
-	spec->input_mux = &stac9200_input_mux;
+	spec->num_muxes = 1;
+	spec->input_mux.num_items = 0;
 	spec->pstate_nids = stac9200_pstate_nids;
 	spec->num_pstates = 3;
 	spec->pin_nids = stac9200_pin_nids;
@@ -525,11 +628,14 @@
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = 4;
 	spec->multiout.dac_nids = stac922x_dac_nids;
+	spec->multiout.dig_out_nid = 0x08;
+	spec->dig_in_nid = 0x09;
 	spec->adc_nids = stac922x_adc_nids;
 	spec->mux_nids = stac922x_mux_nids;
-	spec->input_mux = &stac922x_input_mux;
+	spec->num_muxes = 2;
+	spec->input_mux.num_items = 0;
 	spec->pstate_nids = stac922x_pstate_nids;
-	spec->num_pstates = 7;
+	spec->num_pstates = 8;
 	spec->pin_nids = stac922x_pin_nids;
 #ifdef STAC_TEST
 	spec->pin_configs = stac922x_pin_configs;


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
