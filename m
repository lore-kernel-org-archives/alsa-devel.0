From: Vincent Petry <PVince81@yahoo.fr>
Subject: Re: [Bulk] Re: [PATCH] Added Realtek ALC888
 model	entry for the Acer Aspire 4930G laptop
Date: Tue, 18 Nov 2008 21:55:41 +0800
Message-ID: <4922C95D.8080201@yahoo.fr>
References: <4922A549.3070808@yahoo.fr>
	<s5h8wrhfehv.wl%tiwai@suse.de>	<4922BF91.2030704@yahoo.fr>
	<s5hvduldve6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n15b.bullet.mail.mud.yahoo.com (n15b.bullet.mail.mud.yahoo.com
	[68.142.207.236]) by alsa0.perex.cz (Postfix) with SMTP id 0C67524567
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 14:55:39 +0100 (CET)
In-Reply-To: <s5hvduldve6.wl%tiwai@suse.de>
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

Hello Takashi,

I have inverted both ADCs as you suggested, and it works fine. See patch
below.

Before doing this I had noise issues (distortion) with the front mic on
its right channel. Now after the inversion there is no more noise, but
my voice is only recorded on the right channel, the left channel volume
seems to be much lower. We can consider this as a separate bug, I will
investigate it later.

For the documentation, should I submit a separate patch?

Thanks.

Vincent

diff -Nur alsa-kernel//pci/hda/patch_realtek.c
alsa-kernel-new//pci/hda/patch_realtek.c
--- alsa-kernel//pci/hda/patch_realtek.c	2008-11-18 19:39:33.000000000 +0800
+++ alsa-kernel-new//pci/hda/patch_realtek.c	2008-11-18
21:38:42.000000000 +0800
@@ -216,6 +216,7 @@
 	ALC883_TARGA_2ch_DIG,
 	ALC883_ACER,
 	ALC883_ACER_ASPIRE,
+	ALC888_ACER_ASPIRE_4930G,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,
 	ALC883_LAPTOP_EAPD,
@@ -1155,6 +1156,90 @@
 }

 /*
+ * ALC888 Acer Aspire 4930G model
+ */
+
+static struct hda_verb alc888_acer_aspire_4930g_verbs[] =3D {
+/* Front Mic: set to PIN_IN (empty by default) */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+/* Unselect Front Mic by default in input mixer 3 */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0xb)},
+/* enable unsolicited event fpr HP jack */
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+/* Connect Internal HP to front */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+/* Connect HP out to front */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ }
+};
+
+static struct hda_input_mux alc888_acer_aspire_4930g_capture_source[2] =3D=
 {
+	/* Front mic only available on one ADC */
+	{
+		.num_items =3D 4,
+		.items =3D {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+			{ "Front Mic", 0xb },
+		},
+	},
+	{
+		.num_items =3D 3,
+		.items =3D {
+			{ "Mic", 0x0 },
+			{ "Line", 0x2 },
+			{ "CD", 0x4 },
+		},
+	}
+};
+
+static struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] =3D {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0,
+		HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
+	{ } /* end */
+};
+
+static void alc888_acer_aspire_4930g_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+	present =3D snd_hda_codec_read(codec, 0x15, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	/* Toggle the internal HP PIN (regular muting doesn't work) */
+	snd_hda_codec_write(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+					(present ? 0x0 : PIN_OUT));
+}
+
+static void alc888_acer_aspire_4930g_unsol_event(struct hda_codec *codec,
+		unsigned int res)
+{
+	if (res >> 26 =3D=3D ALC880_HP_EVENT)
+		alc888_acer_aspire_4930g_automute(codec);
+}
+
+/*
  * ALC880 3-stack model
  *
  * DAC: Front =3D 0x02 (0x0c), Surr =3D 0x05 (0x0f), CLFE =3D 0x04 (0x0e)
@@ -6887,8 +6972,15 @@
 	0x08,
 };

+static hda_nid_t alc883_adc_nids_rev[2] =3D {
+	/* ADC2-1 */
+	0x09, 0x08
+};
+
 static hda_nid_t alc883_capsrc_nids[2] =3D { 0x23, 0x22 };

+static hda_nid_t alc883_capsrc_nids_rev[2] =3D { 0x22, 0x23 };
+
 /* input MUX */
 /* FIXME: should be a matrix-type input source selection */

@@ -8180,6 +8272,7 @@
 	[ALC883_TARGA_2ch_DIG]	=3D "targa-2ch-dig",
 	[ALC883_ACER]		=3D "acer",
 	[ALC883_ACER_ASPIRE]	=3D "acer-aspire",
+	[ALC888_ACER_ASPIRE_4930G]	=3D "acer-aspire-4930g",
 	[ALC883_MEDION]		=3D "medion",
 	[ALC883_MEDION_MD2]	=3D "medion-md2",
 	[ALC883_LAPTOP_EAPD]	=3D "laptop-eapd",
@@ -8205,6 +8298,8 @@
 	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0121, "Acer Aspire 5920G", ALC883_ACER_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x013e, "Acer Aspire 4930G",
+		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER), /* default Acer */
 	SND_PCI_QUIRK(0x1028, 0x020d, "Dell Inspiron 530", ALC888_6ST_DELL),
 	SND_PCI_QUIRK(0x103c, 0x2a3d, "HP Pavillion", ALC883_6ST_DIG),
@@ -8376,6 +8471,26 @@
 		.unsol_event =3D alc883_acer_aspire_unsol_event,
 		.init_hook =3D alc883_acer_aspire_automute,
 	},
+	[ALC888_ACER_ASPIRE_4930G] =3D {
+		.mixers =3D { alc888_acer_aspire_4930g_mixer,
+				alc883_chmode_mixer },
+		.init_verbs =3D { alc883_init_verbs, alc880_gpio1_init_verbs,
+				alc888_acer_aspire_4930g_verbs },
+		.num_dacs =3D ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids =3D alc883_dac_nids,
+		.num_adc_nids =3D ARRAY_SIZE(alc883_adc_nids_rev),
+		.adc_nids =3D alc883_adc_nids_rev,
+		.capsrc_nids =3D alc883_capsrc_nids_rev,
+		.dig_out_nid =3D ALC883_DIGOUT_NID,
+		.num_channel_mode =3D ARRAY_SIZE(alc883_3ST_6ch_modes),
+		.channel_mode =3D alc883_3ST_6ch_modes,
+		.need_dac_fix =3D 1,
+		.num_mux_defs =3D
+			ARRAY_SIZE(alc888_acer_aspire_4930g_capture_source),
+		.input_mux =3D alc888_acer_aspire_4930g_capture_source,
+		.unsol_event =3D alc888_acer_aspire_4930g_unsol_event,
+		.init_hook =3D alc888_acer_aspire_4930g_automute,
+	},
 	[ALC883_MEDION] =3D {
 		.mixers =3D { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },

Signed-off-by: Vincent Petry <PVince81@yahoo.fr>


Takashi Iwai a =E9crit :
> At Tue, 18 Nov 2008 21:13:53 +0800,
> Vincent Petry wrote:
>> Hello Takashi,
>>
>> I have updated the patch to make it work with your changes and tested
>> it. I also updated the code style.
> =

> Thanks for a quick fix!
> =

>> +static struct hda_input_mux alc888_acer_aspire_4930g_capture_source[2] =
=3D {
>> +	{
>> +		.num_items =3D 3,
>> +		.items =3D {
>> +			{ "Mic", 0x0 },
>> +			{ "Line", 0x2 },
>> +			{ "CD", 0x4 },
>> +		},
>> +	},
>> +	/* Front mic only available on second ADC */
> =

> Well... I think we should stick with the single ADC (only using 2nd
> ADC) if the front mic isn't available with the 1st ADC.
> The first ADC is used as the primary stream, and people would wonder
> when they can't record from the front/internal mic.
> =

> Or, you can exchange the first and second ADCs so that the second ADC
> is used for the primary purpose and the less-functional ADC can be
> still used parallel as an alternative stream (via hw:0,2).
> =

> Also, don't forget to add your new model to
> Documentation/*/ALSA-Configuration.txt.
> =

> Otherwise the patch looks good.
> Could you fix the above and repost?
> =

> =

> thanks,
> =

> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
