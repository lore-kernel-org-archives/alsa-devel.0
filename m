From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Add support for 92HD73xxx codecs
Date: Fri, 13 Jun 2008 10:16:45 -0400
Message-ID: <4852814D.1070004@embeddedalley.com>
References: <485176C3.80402@embeddedalley.com> <s5hhcbxho0d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 771EF244D3
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:16:56 +0200 (CEST)
In-Reply-To: <s5hhcbxho0d.wl%tiwai@suse.de>
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
> At Thu, 12 Jun 2008 15:19:31 -0400,
> Matthew Ranostay wrote:
>> @@ -2633,7 +2639,7 @@ static int stac92xx_auto_create_dmic_input_ctls(struct
>> hda_codec *codec,
>>  					      0,
>>  					      AC_VERB_GET_CONFIG_DEFAULT,
>>  					      0);
>> -		if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE)
>> +		if (def_conf && (def_conf == AC_JACK_PORT_NONE))
>>  			continue;
> 
> I guess the line def_conf = get_defcfg_connect(def_conf) is missing.
> But, still I don't see why to change to that.
> 
Ok I meant this for the power management block(see below).
Any port that has a jack should be included (settings 0 and 3) in the
power management by nid.

> 
>> @@ -3614,12 +3621,39 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
> (snip)
>> +	if (codec->vendor_id != 0x111d7608)
>> +		snd_hda_sequence_write(codec, stac92hd71bxx_enable_portf);
>> +	else {
>> +		/* skip the VSW on port f */
>> +		spec->num_pins--;
>> +		stac92xx_set_config_reg(codec, 0xf, 0x40f000f0);
>> +	}
> 
> These sequence wouldn't be executed in the resume.
> snd_hda_sequence_write() should be replaced with *_cache().
> stac92xx_set_config_reg() is a bit problem...
> 
Ok I totally forgot about suspend/resume issues.
I'm not sure if the method I have below is acceptable to ALSA
coding standards, but I'm sure you'll let me know :).

> 
> thanks,
> 
> Takashi
> 

Added support for new 92HD75xxx family of codecs.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>


diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index a4f44a0..4d19112 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -636,21 +636,28 @@ static struct hda_verb stac92hd71bxx_core_init[] = {
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 };

+#define HD_DISABLE_PORTF 3
 static struct hda_verb stac92hd71bxx_analog_core_init[] = {
+	/* start of config #1 */
+
+	/* connect port 0f to audio mixer */
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
+	/* unmute right and left channels for node 0x0f */
+	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	/* start of config #2 */
+
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* connect headphone jack to dac1 */
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
-	/* connect ports 0d and 0f to audio mixer */
+	/* connect port 0d to audio mixer */
 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x2},
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
-	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
 	/* unmute dac0 input in audio mixer */
 	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
-	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
+	/* unmute right and left channels for nodes 0x0a, 0xd */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
 };

@@ -1317,13 +1324,13 @@ static unsigned int ref92hd71bxx_pin_configs[10] = {
 	0x90a000f0, 0x01452050,
 };

-static unsigned int dell_m4_1_pin_configs[13] = {
+static unsigned int dell_m4_1_pin_configs[10] = {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
 	0x40f000f0, 0x4f0000f0,
 };

-static unsigned int dell_m4_2_pin_configs[13] = {
+static unsigned int dell_m4_2_pin_configs[10] = {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
 	0x40f000f0, 0x044413b0,
@@ -3103,13 +3110,16 @@ static int stac92xx_init(struct hda_codec *codec)
 					0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 		int def_conf = snd_hda_codec_read(codec, spec->pwr_nids[i],
 					0, AC_VERB_GET_CONFIG_DEFAULT, 0);
+		def_conf = get_defcfg_connect(def_conf);
 		/* outputs are only ports capable of power management
 		 * any attempts on powering down a input port cause the
 		 * referenced VREF to act quirky.
 		 */
 		if (pinctl & AC_PINCTL_IN_EN)
 			continue;
-		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED)
+		/* skip any ports that don't have jacks since presence
+ 		 * detection is useless */
+		if (def_conf && def_conf != AC_JACK_PORT_FIXED)
 			continue;
 		enable_pin_detect(codec, spec->pwr_nids[i], event | i);
 		codec->patch_ops.unsol_event(codec, (event | i) << 26);
@@ -3614,6 +3624,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)

 	codec->spec = spec;
 	spec->num_pins = ARRAY_SIZE(stac92hd71bxx_pin_nids);
+	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pin_nids = stac92hd71bxx_pin_nids;
 	spec->board_config = snd_hda_check_board_config(codec,
 							STAC_92HD71BXX_MODELS,
@@ -3642,6 +3653,19 @@ again:
 		spec->mixer = stac92hd71bxx_mixer;
 		spec->init = stac92hd71bxx_core_init;
 		break;
+	case 0x111d7608: /* 5 Port with Analog Mixer */
+		/* no output amps */
+		spec->num_pwrs = 0;
+		spec->mixer = stac92hd71bxx_analog_mixer;
+
+		/* disable VSW */
+		spec->init = &stac92hd71bxx_analog_core_init[HD_DISABLE_PORTF];
+		stac92xx_set_config_reg(codec, 0xf, 0x40f000f0);
+		break;
+	case 0x111d7603: /* 6 Port with Analog Mixer */
+		/* no output amps */
+		spec->num_pwrs = 0;
+		/* fallthru */
 	default:
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
@@ -3660,15 +3684,13 @@ again:
 	spec->adc_nids = stac92hd71bxx_adc_nids;
 	spec->dmic_nids = stac92hd71bxx_dmic_nids;
 	spec->dmux_nids = stac92hd71bxx_dmux_nids;
+	spec->pwr_nids = stac92hd71bxx_pwr_nids;

 	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
 	spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);

-	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
-	spec->pwr_nids = stac92hd71bxx_pwr_nids;
-
 	spec->multiout.num_dacs = 1;
 	spec->multiout.hp_nid = 0x11;
 	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
@@ -4306,10 +4328,11 @@ struct hda_codec_preset snd_hda_preset_sigmatel[] = {
  	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
  	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
  	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
+	{ .id = 0x111d7603, .name = "92HD75B3X5", .patch = patch_stac92hd71bxx},
+	{ .id = 0x111d7608, .name = "92HD75B2X5", .patch = patch_stac92hd71bxx},
 	{ .id = 0x111d7674, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7675, .name = "92HD73C1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7676, .name = "92HD73E1X5", .patch = patch_stac92hd73xx },
-	{ .id = 0x111d7608, .name = "92HD71BXX", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b0, .name = "92HD71B8X", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b1, .name = "92HD71B8X", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b2, .name = "92HD71B7X", .patch = patch_stac92hd71bxx },
