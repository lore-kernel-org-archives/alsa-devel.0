From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Added mono mux mixer for some
 STAC92HD7XXX family codecs
Date: Mon, 21 Jan 2008 08:58:52 -0500
Message-ID: <4794A51C.6070709@embeddedalley.com>
References: <47911DCA.9070104@embeddedalley.com> <s5h4pdakva2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by alsa0.perex.cz (Postfix) with SMTP id E886524527
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 14:58:54 +0100 (CET)
In-Reply-To: <s5h4pdakva2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 18 Jan 2008 16:44:42 -0500,
> Matthew Ranostay wrote:
>> Some 92HD7XXX family codecs have a mono mux, added support for selecting the input path to the mono out.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> Could you fix the coding-style issues reported by checkpatch.pl?
Ok, fixed the 80-character lines it complained about, although I left the 'declaration in if statement' since
the code block below it does the same style.
> 
>> +static struct hda_input_mux stac92hd71bxx_mono_mux = {
>> +	/* count set later */
> 
> This is a bit dangerous.  In theory, we may have several hd-audio
> instances, e.g. an on-board and a graphic card.  The local common
> variable may conflict between two instances.  Rather copy the whole
> input_mux to spec, and modify locally.
> 
Thanks Takashi for spotting this.
Ok I can't believe I didn't notice this.
> 
> thanks,
> 
> Takashi
> 


Some 92HD7XXX family codecs have a mono mux, added support for selecting the input path to the mono out.
Creates a dynamic mixer based on connection count of the mono-out nid.

Signed-off-by: Matthew Ranostay <mranostay@embededdalley.com>
---
diff -r a035d5e4801c pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Jan 18 15:32:32 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Sun Jan 20 15:19:33 2008 -0500
@@ -131,6 +131,8 @@ struct sigmatel_spec {
 	hda_nid_t *pwr_nids;
 
 	/* playback */
+	struct hda_input_mux *mono_mux;
+	unsigned int cur_mmux;
 	struct hda_multi_out multiout;
 	hda_nid_t dac_nids[5];
 
@@ -144,6 +146,7 @@ struct sigmatel_spec {
 	hda_nid_t *dmux_nids;
 	unsigned int num_dmuxes;
 	hda_nid_t dig_in_nid;
+	hda_nid_t mono_nid;
 
 	/* pin widgets */
 	hda_nid_t *pin_nids;
@@ -174,6 +177,7 @@ struct sigmatel_spec {
 	struct snd_kcontrol_new *kctl_alloc;
 	struct hda_input_mux private_dimux;
 	struct hda_input_mux private_imux;
+	struct hda_input_mux private_mono_mux;
 
 	/* virtual master */
 	unsigned int vmaster_tlv[4];
@@ -399,6 +403,34 @@ static int stac92xx_mux_enum_put(struct 
 
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx], &spec->cur_mux[adc_idx]);
+}
+
+static int stac92xx_mono_mux_enum_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->mono_mux, uinfo);
+}
+
+static int stac92xx_mono_mux_enum_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_mmux;
+	return 0;
+}
+
+static int stac92xx_mono_mux_enum_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	return snd_hda_input_mux_put(codec, spec->mono_mux, ucontrol,
+				     spec->mono_nid, &spec->cur_mmux);
 }
 
 #define stac92xx_aloopback_info snd_ctl_boolean_mono_info
@@ -603,6 +635,16 @@ static struct hda_verb stac9205_core_ini
 	{}
 };
 
+#define STAC_MONO_MUX \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = "Mono Mux", \
+		.count = 1, \
+		.info = stac92xx_mono_mux_enum_info, \
+		.get = stac92xx_mono_mux_enum_get, \
+		.put = stac92xx_mono_mux_enum_put, \
+	}
+
 #define STAC_INPUT_SOURCE(cnt) \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -714,6 +756,7 @@ static struct snd_kcontrol_new stac92hd7
 
 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),
+	STAC_MONO_MUX,
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -733,6 +776,7 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
+	STAC_MONO_MUX,
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -1180,7 +1224,7 @@ static struct snd_pci_quirk stac92hd73xx
 
 static unsigned int ref92hd71bxx_pin_configs[10] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
-	0x0181302e, 0x01114010, 0x01a19020, 0x90a000f0,
+	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
 	0x90a000f0, 0x01452050,
 };
 
@@ -2318,6 +2362,35 @@ static int stac92xx_auto_create_hp_ctls(
 	return 0;
 }
 
+/* labels for mono mux outputs */
+static const char *stac92xx_mono_labels[3] = {
+	"DAC0", "DAC1", "Mixer"
+};
+
+/* create mono mux for mono out on capable codecs */
+static int stac92xx_auto_create_mono_output_ctls(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	struct hda_input_mux *mono_mux = &spec->private_mono_mux;
+	int i, num_cons;
+	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
+
+	num_cons = snd_hda_get_connections(codec,
+				spec->mono_nid,
+				con_lst,
+				HDA_MAX_NUM_INPUTS);
+	if (!num_cons)
+		return -EINVAL;
+
+	for (i = 0; i < num_cons; i++) {
+		mono_mux->items[mono_mux->num_items].label =
+					stac92xx_mono_labels[i];
+		mono_mux->items[mono_mux->num_items].index = i;
+		mono_mux->num_items++;
+	}
+	return 0;
+}
+
 /* labels for dmic mux inputs */
 static const char *stac92xx_dmic_labels[5] = {
 	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
@@ -2532,6 +2605,10 @@ static int stac92xx_parse_auto_config(st
 	if (err < 0)
 		return err;
 
+	if (spec->mono_nid > 0)
+		if ((err = stac92xx_auto_create_mono_output_ctls(codec)) < 0)
+			return err;
+
 	if (spec->num_dmics > 0)
 		if ((err = stac92xx_auto_create_dmic_input_ctls(codec,
 						&spec->autocfg)) < 0)
@@ -2552,6 +2629,7 @@ static int stac92xx_parse_auto_config(st
 	spec->input_mux = &spec->private_imux;
 	if (!spec->dinput_mux)
 		spec->dinput_mux = &spec->private_dimux;
+	spec->mono_mux = &spec->private_mono_mux;
 
 	return 1;
 }
@@ -3237,6 +3315,7 @@ again:
 
 	spec->gpio_mask = spec->gpio_data = 0x00000001; /* GPIO0 High = EAPD */
 
+	spec->mono_nid = 0x15;
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
 	spec->dmic_nids = stac92hd71bxx_dmic_nids;
