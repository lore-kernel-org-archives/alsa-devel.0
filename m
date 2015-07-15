From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Enable HP amp and mute
	LED on HP Folio 9480m
Date: Wed, 15 Jul 2015 12:14:39 -0700
Message-ID: <86k2u1qlls.fsf@hiro.keithp.com>
References: <1436892035-19589-1-git-send-email-keithp@keithp.com>
 <1436895871-2459-1-git-send-email-keithp@keithp.com>
 <s5hio9m4jxf.wl-tiwai@suse.de> <86si8qw3gn.fsf@hiro.keithp.com>
 <s5hd1zt4z3b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4511346010194785623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elaine.keithp.com (home.keithp.com [63.227.221.253])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DBF6265D9F
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 21:14:44 +0200 (CEST)
In-Reply-To: <s5hd1zt4z3b.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

--===============4511346010194785623==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Takashi Iwai <tiwai@suse.de> writes:

> Thanks!  The new patch looks good, but I think we don't have to use
> the headset code, as your case looks more like a headphone, not a
> combo headset that needs the special handling.  If so, the change can
> be reduced something like below.  Could you check whether this is
> enough?

Yes, that seems a lot simpler and works fine. I did remove the
led_power_filter setting; that doesn't seem relevant for GPIO-based
leds, and isn't necessary on my device in any case.

This patch is now otherwise essentially the same as yours, with the
addition of comments.

Thanks again for your help; it's always interesting to dive into some
different area of the kernel and see how it works.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-ALSA-hda-realtek-Enable-HP-amp-and-mute-LED-on-HP-Fo.patch
Content-Transfer-Encoding: quoted-printable

From=20ca694a8c6d481fd327822dd2adec35e82affb2be Mon Sep 17 00:00:00 2001
From: Keith Packard <keithp@keithp.com>
Date: Tue, 14 Jul 2015 09:30:33 -0700
Subject: [PATCH] ALSA: hda/realtek: Enable HP amp and mute LED on HP Folio
 9480m [v3]

This laptop needs GPIO4 pulled high to enable the headphone amplifier,
and has a mute LED on GPIO3. I modelled the patch on the existing
GPIO4 code which pulls the line low for the same purpose; this time,
the HP amp line is pulled high.

v2: Disable the headphone amplifier when no headphone is connected.
    Don't disable power savings to preserve the LED state.

v3: Remove headset-specific hooks and code; this is just a headphone.

Signed-off-by: Keith Packard <keithp@keithp.com>
=2D--
 sound/pci/hda/patch_realtek.c | 55 +++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 55 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6d01045..0e1f8c8 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4435,6 +4435,55 @@ static void alc290_fixup_mono_speakers(struct hda_co=
dec *codec,
 	}
 }
=20
+/* Hook to update amp GPIO4 for automute */
+static void alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
+					  struct hda_jack_callback *jack)
+{
+	struct alc_spec *spec =3D codec->spec;
+
+	snd_hda_gen_hp_automute(codec, jack);
+	/* mute_led_polarity is set to 0, so we pass inverted value here */
+	alc_update_gpio_led(codec, 0x10, !spec->gen.hp_jack_present);
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
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {
+		/* Set the hooks to turn the headphone amp on/off
+		 * as needed
+		 */
+		spec->gen.vmaster_mute.hook =3D alc_fixup_gpio_mute_hook;
+		spec->gen.hp_automute_hook =3D alc280_hp_gpio4_automute_hook;
+
+		/* The GPIOs are currently off */
+		spec->gpio_led =3D 0;
+
+		/* GPIO3 is connected to the output mute LED,
+		 * high is on, low is off
+		 */
+		spec->mute_led_polarity =3D 0;
+		spec->gpio_mute_led_mask =3D 0x08;
+
+		/* Initialize GPIO configuration */
+		snd_hda_add_verbs(codec, gpio_init);
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
=20
@@ -4512,6 +4561,7 @@ enum {
 	ALC286_FIXUP_HP_GPIO_LED,
 	ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY,
 	ALC280_FIXUP_HP_DOCK_PINS,
+	ALC280_FIXUP_HP_9480M,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13_GPIO6,
@@ -5012,6 +5062,10 @@ static const struct hda_fixup alc269_fixups[] =3D {
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
@@ -5103,6 +5157,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
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

iQIVAwUBVaaxINsiGmkAAAARAQjqJA//QzDX1+HeUtMhlkt9h3+R9HO8cWtZDddZ
zh7E1QvRDn9C0rXlY9EiOhCViJZKbtCPKRRmRwMk9o26tmbXiQpuBoKfjB6M8S1j
wJOQhxJe5eBMrdylswMRhhZQNeX0eFrpVMIh/XoErWMXUulIRbeOGWgpkMyIt727
O7E6ZIeGi3gollaIOlq0PjZ6uJoahU4mvThUbVy0WUmTvaWZUBSu9xkbj/EcmQrW
Tjl2B0JD6Yf9r+9cp3Z/Gag5/VTy/rriY9T83T6hmc6sOuRJGjfsmXrdRgCYtLAF
BbdjZ47PzQEJHqUX/s2DTDTfAw7wuGFgVtcnh8Jvucb0it1mCPiN2e7i3lCq6b0M
zeWqTGe/1VXXWQkUuY//dD/54dtMazHUMOvvEo8zTwL0lmeSRGalXGGiwa9Ezo9d
24fe8T5SWaIWrbofT8q6cXqU0jIFox+w49g+sNCHTLvlroRrTkfHiuCs8NNUNXW7
yKE/sHgKxORClln0OUltBUVYd3LPGQAhQMhDfgrcOPHpJyaEbzuYcW5PS7gaM7PK
n9suRwxILiPn2NFcKFlQgTOBeHoTcsuDjghpGhqlLz4hr6nTt49k0F90QJfoipT2
XMDbmM6UE8fXoq8AoR7YJ4YaSSj3hmWjIE9x9cOdBfsKuSzrePdax9QX7kPT/Uei
V7095AROJG8=
=8ukf
-----END PGP SIGNATURE-----
--==-=-=--

--===============4511346010194785623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4511346010194785623==--
