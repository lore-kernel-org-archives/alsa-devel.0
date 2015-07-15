From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Enable HP amp and mute LED on HP Folio 9480m
Date: Tue, 14 Jul 2015 19:37:44 -0700
Message-ID: <86si8qw3gn.fsf@hiro.keithp.com>
References: <1436892035-19589-1-git-send-email-keithp@keithp.com> <1436895871-2459-1-git-send-email-keithp@keithp.com> <s5hio9m4jxf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hio9m4jxf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Takashi Iwai <tiwai@suse.de> writes:

> Thanks for the patch.  But this looks suboptimal, unfortunately, since
> it keeps the amp always on, and more badly, it would block the power
> save of the widget root node.

Thanks very much for your feedback; I wasn't sure precisely how this
code worked and tried to make a change that was as close as I could
manage to existing examples.

> Can just using gpio_mute_led_mask=0x18 and gpio_led=0 (also drop
> AC_VERB_SET_GPIO_DATA in gpio_init[]) work instead?  If GPIO4 is the
> the amp, we can associate it with the master mute control together
> with the mute LED.  The only concern would be the possible click
> noise, but it doesn't happen on most machines.

It's not quite that simple; the GPIO4 value is inverted from the mute
LED value (the amp is powered up when GPIO4 is set).

What I've done is to make the amp powered only when a headphone is
plugged in, and then removed the code which was disabling power saving,
which lets everything (including the amp) get turned back off when the
device goes idle.

Here's a second version of the patch.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-ALSA-hda-realtek-Enable-HP-amp-and-mute-LED-on-HP-Fo.patch
Content-Transfer-Encoding: quoted-printable

From=2060e2c02d651b0ca6e4b72aa1cab21660400fe2eb Mon Sep 17 00:00:00 2001
From: Keith Packard <keithp@keithp.com>
Date: Tue, 14 Jul 2015 09:30:33 -0700
Subject: [PATCH] ALSA: hda/realtek: Enable HP amp and mute LED on HP Folio
 9480m [v2]

This laptop needs GPIO4 pulled high to enable the headphone amplifier,
and has a mute LED on GPIO3. I modelled the patch on the existing
GPIO4 code which pulls the line low for the same purpose; this time,
the HP amp line is pulled high.

v2: Disable the headphone amplifier when no headphone is connected.
    Don't disable power savings to preserve the LED state.

Signed-off-by: Keith Packard <keithp@keithp.com>
=2D--
 sound/pci/hda/patch_realtek.c | 112 ++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 112 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d01045..621c195 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -99,6 +99,7 @@ struct alc_spec {
 	unsigned int gpio_led; /* used for alc269_fixup_hp_gpio_led() */
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
+	unsigned int gpio_hp_amp_mask;
=20
 	hda_nid_t headset_mic_pin;
 	hda_nid_t headphone_mic_pin;
@@ -4435,6 +4436,111 @@ static void alc290_fixup_mono_speakers(struct hda_c=
odec *codec,
 	}
 }
=20
+/* Set headphone amp power via a GPIO depending on whether the
+ * headphones are plugged in or not
+ */
+static void alc280_set_hp_amp_power(struct hda_codec *codec)
+{
+	struct alc_spec *spec =3D codec->spec;
+	unsigned int oldval =3D spec->gpio_led;
+
+	/* Headphone amp enable when headphone present */
+	if (spec->gen.hp_jack_present)
+		spec->gpio_led |=3D spec->gpio_hp_amp_mask;
+	else
+		spec->gpio_led &=3D ~spec->gpio_hp_amp_mask;
+
+	codec_dbg(codec,
+		  "set_hp_amp_power present %d oldval %02x current %02x\n",
+		  spec->gen.hp_jack_present,
+		  oldval, spec->gpio_led);
+
+	if (spec->gpio_led !=3D oldval)
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+				    spec->gpio_led);
+}
+
+/* Detect headphone connection, then go update the headphone amp
+ * GPIO */
+static void alc280_update_headset_mode(struct hda_codec *codec)
+{
+	alc_update_headset_mode(codec);
+	alc280_set_hp_amp_power(codec);
+}
+
+/* Hook to update headphone amp GPIO on config changes */
+static void
+alc280_update_headset_mode_hook(struct hda_codec *codec,
+				struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	alc280_update_headset_mode(codec);
+}
+
+/* Hook to update amp GPIO for automute */
+static void alc280_update_headset_jack_cb(struct hda_codec *codec,
+					  struct hda_jack_callback *jack)
+{
+	alc_update_headset_jack_cb(codec, jack);
+	alc280_set_hp_amp_power(codec);
+}
+
+/* Manage GPIOs for HP EliteBook Folio 9480m.
+ *
+ * GPIO4 is the headphone amplifier power control
+ * GPIO3 is the audio output mute indicator LED
+ */
+
+static void alc280_fixup_hp_9480m(struct hda_codec *codec,
+				  const struct hda_fixup *fix,
+				  int action)
+{
+	struct alc_spec *spec =3D codec->spec;
+	static const struct hda_verb gpio_init[] =3D {
+		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x18 },
+		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x18 },
+		{}
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+
+		/* Set the hooks to turn the headphone amp on/off
+		 * as needed
+		 */
+		spec->gen.vmaster_mute.hook =3D alc_fixup_gpio_mute_hook;
+		spec->gen.cap_sync_hook =3D alc280_update_headset_mode_hook;
+		spec->gen.automute_hook =3D alc280_update_headset_mode;
+		spec->gen.hp_automute_hook =3D alc280_update_headset_jack_cb;
+
+		/* The GPIOs are currently off */
+		spec->gpio_led =3D 0;
+
+		/* GPIO4 controls the headphone amp,
+		 * high is on, low is off
+		 */
+		spec->gpio_hp_amp_mask =3D 0x10;
+
+		/* GPIO3 is connected to the output mute LED,
+		 * high is on, low is off
+		 */
+		spec->mute_led_polarity =3D 0;
+		spec->gpio_mute_led_mask =3D 0x08;
+
+		/* Initialize GPIO configuration */
+		snd_hda_add_verbs(codec, gpio_init);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+
+		/* Force configuration of headphone amp
+		 * GPIO
+		 */
+		spec->current_headset_mode =3D 0;
+		alc280_update_headset_mode(codec);
+		break;
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
=20
@@ -4512,6 +4618,7 @@ enum {
 	ALC286_FIXUP_HP_GPIO_LED,
 	ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY,
 	ALC280_FIXUP_HP_DOCK_PINS,
+	ALC280_FIXUP_HP_9480M,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13_GPIO6,
@@ -5012,6 +5119,10 @@ static const struct hda_fixup alc269_fixups[] =3D {
 		.chained =3D true,
 		.chain_id =3D ALC280_FIXUP_HP_GPIO4
 	},
+	[ALC280_FIXUP_HP_9480M] =3D {
+		.type =3D HDA_FIXUP_FUNC,
+		.v.func =3D alc280_fixup_hp_9480m,
+	},
 	[ALC288_FIXUP_DELL_HEADSET_MODE] =3D {
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc_fixup_headset_mode_dell_alc288,
@@ -5103,6 +5214,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22bf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x22db, "HP", ALC280_FIXUP_HP_9480M),
 	SND_PCI_QUIRK(0x103c, 0x22dc, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x22fb, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),
 	/* ALC290 */
=2D-=20
2.1.4


--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


=2D-=20
=2Dkeith

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVaXHedsiGmkAAAARAQjGhw//RtenXBYy5tDdu65Ro9LprKUQIp2fIaFS
Qt+cpSF7pYGwZWooz6xVPUiqESOAwysrB6kFyf4DJTkvWPEpU6Ouzcnr1AtmGqfW
AnvvVeGTce0AkIqpOm0VsJ/OaHKFDhdtvMefOJEjJ6qn0eUWbi6vLafuxsaWw4Ju
nO1SBQ6b1bhhfjvkNSQmtg0K25aKiPjhYgPZlkZKTV1xhMpggAGd1IlhcpFQBI5L
6g8URWGkbXtzOx4kkq8OR4K3CnnyM6rUjGJu6WIynKIqbabJ2r2ZhXmazfxdozjw
E6BhUBb3WJb6PzR8CMW4+DjVoxIksdWJxROB6ZKzEFCnkxGxrLG5K9iedy3FNTKc
nKTFEqaBY7dkpaWfTkoggMKI1dtsVxFXLhLxA/hw7Yw0VtiAaJ2Oxm3Gf/Y0ju1q
+2wxxmOcZiM/Az3CuLTdW1Br4EmXdjTXKbvAqYPQSspF5/iDyrIdEx0y2p2FFmZA
ziqVsQO2BuIo3gRJr7MLYD1wXkPC6k0605PZdWOeu8BbnveV4c+9I0Z+Iz+xtIjx
AUneixkS+N+A4sFOWkrBCH4bsnS8nwXITak9emjSdJ04fnxK4Y9RlLSQgXci9vYR
suRwGV5VV0iY2/bgCjVKJQJeKVaWOl+gWcrzQuhmXvOEgK/9eeHCSlAAkWl/CeJQ
S4JCM+/88RY=
=jZ89
-----END PGP SIGNATURE-----
--==-=-=--
