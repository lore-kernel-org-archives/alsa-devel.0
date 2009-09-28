From: Miguel de Barros <miguel.de.barros@bluewin.ch>
Subject: Re: [PATCH 1/1] ALSA: hda - Analog Devices AD1984A add
 HP Touchsmart model
Date: Mon, 28 Sep 2009 21:13:26 +0200
Message-ID: <1254165207.3585.10.camel@arnold>
References: <1254083698.3586.10.camel@arnold> <s5heipr4fs7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-J56U1/hvhPtbcxv8DR5c"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail15.bluewin.ch (mail15.bluewin.ch [195.186.18.63])
	by alsa0.perex.cz (Postfix) with ESMTP id EEF82103831
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 21:13:30 +0200 (CEST)
In-Reply-To: <s5heipr4fs7.wl%tiwai@suse.de>
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


--=-J56U1/hvhPtbcxv8DR5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your feedback,

here is a new version of the patch taking into account your comments. I
fully agree the mix source is not really useful.

I've put in the commit comment some info on what is included in the
patch. Tell me if more information is needed...

Miguel


Le lundi 28 septembre 2009 =C3=A0 10:47 +0200, Takashi Iwai a =C3=A9crit =
:
> At Sun, 27 Sep 2009 22:34:58 +0200,
> Miguel de Barros wrote:
> >=20
> > Hello,
> >=20
> > I would like to submit this patch,=20
> >=20
> > it will fix the bug I've submited :
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4614
> >=20
> >=20
> > Thanks,
> > 	Miguel de Barros
> > [2 0001-ALSA-hda-Analog-Devices-AD1984A-add-HP-Touchsmart.patch <text=
/x-patch; UTF-8 (7bit)>]
> > >From 8a106650b4f18c956ae40bf863fb3423b66d605f Mon Sep 17 00:00:00 20=
01
> > From: Miguel de Barros <miguel.de.barros@bluewin.ch>
> > Date: Sun, 27 Sep 2009 22:11:21 +0200
> > Subject: [PATCH 1/1] ALSA: hda - Analog Devices AD1984A add HP Touchs=
mart model
> >          modified:   Documentation/HD-Audio-Models.txt
> >          modified:   pci/hda/patch_analog.c
> >=20
> >=20
> > Signed-off-by: Miguel de Barros <miguel.de.barros@bluewin.ch>
>=20
> Thanks for the patch.
>=20
> Could you add a bit more description what you change and/or fix with
> this patch?  The reference to bug tracking can be also in the
> changelog text.
> OTOH, the list of modified files is superfluous since we can track
> them via git more easily.
>=20
>=20
> > +static struct hda_input_mux ad1984a_touchsmart_capture_source =3D {
> > +	.num_items =3D 3,
> > +	.items =3D {
> > +		{ "Mix", 0x3 }, /* Mixer */
> > +		{ "Mic", 0x4 }, /* port-E */
> > +		{ "Internal Mic", 0x5 }, /* Digital Mic */
> > +	},
> > +};
> > +
> > +/* switch to external mic if plugged */
> > +static void ad1984a_touchsmart_automic(struct hda_codec *codec)
> > +{
> > +	if (snd_hda_codec_read(codec, 0x1c, 0,
> > +				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000) {
> > +		snd_hda_codec_write(codec, 0x0c, 0,
> > +				     AC_VERB_SET_CONNECT_SEL, 0x4);
> > +	} else {
> > +		snd_hda_codec_write(codec, 0x0c, 0,
> > +				     AC_VERB_SET_CONNECT_SEL, 0x5);
> > +	}
> > +}
>=20
> The auto-mic feature is actually conflicting with the capture_source
> setup.  That is, even if you choose "Internal Mic" manually as the
> capture source, it's changed (even without notification) to the mic
> jack when plugged in.
>=20
> So, either use only the auto-mic and get rid of the manual "capture
> source" (I prefer), or disable auto-mic.  We can remove "Mix" item
> in the first case just for simplicity.
>=20
>=20
> Could you fix and repot?
>=20
> thanks,
>=20
> Takashi

--=-J56U1/hvhPtbcxv8DR5c
Content-Disposition: attachment; filename="0001-ALSA-hda-Analog-Devices-AD1984A-add-HP-Touchsmart.patch"
Content-Type: text/x-patch; name="0001-ALSA-hda-Analog-Devices-AD1984A-add-HP-Touchsmart.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 4a8a44b8afa93ca068c694d5bbff4e616760ccb1 Mon Sep 17 00:00:00 2001
From: Miguel de Barros <miguel.de.barros@bluewin.ch>
Date: Sun, 27 Sep 2009 22:11:21 +0200
Subject: [PATCH 1/1] ALSA: hda - Analog Devices AD1984A add HP Touchsmart model

Reference: ALSA bug #0004614
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4614

port-A (0x11)      - front hp-out
port-D (0x12)      - rear line out
port-E (0x1c)      - front mic-in
port-F (0x16)      - Internal speakers
digital-mic (0x17) - Internal mic

init verbs, mixers, jack sensing and PCI_QUIRK to support this hardware

Signed-off-by: Miguel de Barros <miguel.de.barros@bluewin.ch>

diff --git a/Documentation/HD-Audio-Models.txt b/Documentation/HD-Audio-Models.txt
index abffd41..9e850ed 100644
--- a/Documentation/HD-Audio-Models.txt
+++ b/Documentation/HD-Audio-Models.txt
@@ -208,6 +208,7 @@ AD1884A / AD1883 / AD1984A / AD1984B
   laptop	laptop with HP jack sensing
   mobile	mobile devices with HP jack sensing
   thinkpad	Lenovo Thinkpad X300
+  touchsmart	HP Touchsmart
 
 AD1884
 ======
diff --git a/pci/hda/patch_analog.c b/pci/hda/patch_analog.c
index 215e72a..2d603f6 100644
--- a/pci/hda/patch_analog.c
+++ b/pci/hda/patch_analog.c
@@ -4032,6 +4032,127 @@ static int ad1984a_thinkpad_init(struct hda_codec *codec)
 }
 
 /*
+ * HP Touchsmart
+ * port-A (0x11)      - front hp-out
+ * port-B (0x14)      - unused
+ * port-C (0x15)      - unused
+ * port-D (0x12)      - rear line out
+ * port-E (0x1c)      - front mic-in
+ * port-F (0x16)      - Internal speakers
+ * digital-mic (0x17) - Internal mic
+ */
+
+static struct hda_verb ad1984a_touchsmart_verbs[] = {
+	/* DACs; unmute as default */
+	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, 0x27}, /* 0dB */
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, 0x27}, /* 0dB */
+	/* Port-A (HP) mixer - route only from analog mixer */
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	/* Port-A pin */
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Port-A (HP) pin - always unmuted */
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Port-E (int speaker) mixer - route only from analog mixer */
+	{0x25, AC_VERB_SET_AMP_GAIN_MUTE, 0x03},
+	/* Port-E pin */
+	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	/* Port-F (int speaker) mixer - route only from analog mixer */
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	/* Port-F pin */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Analog mixer; mute as default */
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
+	/* Analog Mix output amp */
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* capture sources */
+	/* {0x0c, AC_VERB_SET_CONNECT_SEL, 0x0}, */ /* set via unsol */
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x0},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* unsolicited event for pin-sense */
+	{0x11, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1884A_HP_EVENT},
+	{0x1c, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1884A_MIC_EVENT},
+	/* allow to touch GPIO1 (for mute control) */
+	{0x01, AC_VERB_SET_GPIO_MASK, 0x02},
+	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x02},
+	{0x01, AC_VERB_SET_GPIO_DATA, 0x02}, /* first muted */
+	/* internal mic - dmic */
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	/* set magic COEFs for dmic */
+	{0x01, AC_VERB_SET_COEF_INDEX, 0x13f7},
+	{0x01, AC_VERB_SET_PROC_COEF, 0x08},
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new ad1984a_touchsmart_mixers[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0x21, 0x0, HDA_OUTPUT),
+/*	HDA_CODEC_MUTE("Master Playback Switch", 0x21, 0x0, HDA_OUTPUT),*/
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = snd_hda_mixer_amp_switch_info,
+		.get = snd_hda_mixer_amp_switch_get,
+		.put = ad1884a_mobile_master_sw_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x21, 3, 0, HDA_OUTPUT),
+	},
+	HDA_CODEC_VOLUME("PCM Playback Volume", 0x20, 0x5, HDA_INPUT),
+	HDA_CODEC_MUTE("PCM Playback Switch", 0x20, 0x5, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x25, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x17, 0x0, HDA_INPUT),
+	{ } /* end */
+};
+
+/* switch to external mic if plugged */
+static void ad1984a_touchsmart_automic(struct hda_codec *codec)
+{
+	if (snd_hda_codec_read(codec, 0x1c, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000) {
+		snd_hda_codec_write(codec, 0x0c, 0,
+				     AC_VERB_SET_CONNECT_SEL, 0x4);
+	} else {
+		snd_hda_codec_write(codec, 0x0c, 0,
+				     AC_VERB_SET_CONNECT_SEL, 0x5);
+	}
+}
+
+
+/* unsolicited event for HP jack sensing */
+static void ad1984a_touchsmart_unsol_event(struct hda_codec *codec,
+	unsigned int res)
+{
+	switch (res >> 26) {
+	case AD1884A_HP_EVENT:
+		ad1884a_hp_automute(codec);
+		break;
+	case AD1884A_MIC_EVENT:
+		ad1984a_touchsmart_automic(codec);
+		break;
+	}
+}
+
+/* initialize jack-sensing, too */
+static int ad1984a_touchsmart_init(struct hda_codec *codec)
+{
+	ad198x_init(codec);
+	ad1884a_hp_automute(codec);
+	ad1984a_touchsmart_automic(codec);
+	return 0;
+}
+
+
+/*
  */
 
 enum {
@@ -4039,6 +4160,7 @@ enum {
 	AD1884A_LAPTOP,
 	AD1884A_MOBILE,
 	AD1884A_THINKPAD,
+	AD1984A_TOUCHSMART,
 	AD1884A_MODELS
 };
 
@@ -4047,6 +4169,7 @@ static const char *ad1884a_models[AD1884A_MODELS] = {
 	[AD1884A_LAPTOP]	= "laptop",
 	[AD1884A_MOBILE]	= "mobile",
 	[AD1884A_THINKPAD]	= "thinkpad",
+	[AD1984A_TOUCHSMART]	= "touchsmart",
 };
 
 static struct snd_pci_quirk ad1884a_cfg_tbl[] = {
@@ -4059,6 +4182,7 @@ static struct snd_pci_quirk ad1884a_cfg_tbl[] = {
 	SND_PCI_QUIRK_MASK(0x103c, 0xff00, 0x3600, "HP laptop", AD1884A_LAPTOP),
 	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x7010, "HP laptop", AD1884A_MOBILE),
 	SND_PCI_QUIRK(0x17aa, 0x20ac, "Thinkpad X300", AD1884A_THINKPAD),
+	SND_PCI_QUIRK(0x103c, 0x2a82, "Touchsmart", AD1984A_TOUCHSMART),
 	{}
 };
 
@@ -4142,6 +4266,21 @@ static int patch_ad1884a(struct hda_codec *codec)
 		codec->patch_ops.unsol_event = ad1984a_thinkpad_unsol_event;
 		codec->patch_ops.init = ad1984a_thinkpad_init;
 		break;
+	case AD1984A_TOUCHSMART:
+		spec->mixers[0] = ad1984a_touchsmart_mixers;
+		spec->init_verbs[0] = ad1984a_touchsmart_verbs;
+		spec->multiout.dig_out_nid = 0;
+		codec->patch_ops.unsol_event = ad1984a_touchsmart_unsol_event;
+		codec->patch_ops.init = ad1984a_touchsmart_init;
+		/* set the upper-limit for mixer amp to 0dB for avoiding the
+		 * possible damage by overloading
+		 */
+		snd_hda_override_amp_caps(codec, 0x20, HDA_INPUT,
+					  (0x17 << AC_AMPCAP_OFFSET_SHIFT) |
+					  (0x17 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+					  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+					  (1 << AC_AMPCAP_MUTE_SHIFT));
+		break;
 	}
 
 	return 0;
-- 
1.6.0.4


--=-J56U1/hvhPtbcxv8DR5c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-J56U1/hvhPtbcxv8DR5c--
