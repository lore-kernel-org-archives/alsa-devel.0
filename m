From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Wed, 29 Apr 2015 00:47:16 +0200
Message-ID: <55400DF4.2080309@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
 <553EB55D.4060701@gmx.com> <s5hlhhc3hiy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000709000104040207020605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id F3C51260425
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 00:46:52 +0200 (CEST)
Received: from [192.168.69.6] ([95.237.223.208]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MPE7E-1Yre7Y25Ca-004Q5N for
 <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 00:46:52 +0200
In-Reply-To: <s5hlhhc3hiy.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000709000104040207020605
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28/04/2015 08:15, Takashi Iwai wrote:
> snd_pci_quirk_lookup() just returns a value matching in the given
> table.  Provide a table like:
>
> enum {
> 	QUIRK_NONE,
> 	QUIRK_ALIENWARE,
> };
>
> static const struct snd_pci_quirk ca0132_quirks[] =3D {
> 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
> 	{}
> };
>
> then somewhere in the probe, check the table
>
> 	spec->quirk =3D snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
>
> then refer it appropriately
>
> 	if (spec->quirk =3D=3D QUIRK_ALIENWARE) {
> 		spec->out_pins[1] =3D 0x0f;
> 		....
> 	} else {
> 		spec->out_pins[1] =3D 0x10;
> 		....
> 	}
>
> The current ca0132 code has way too may fixed assignment, so the pin
> reassignment like other codec drivers doesn't work as is.  We'd need
> to sort it out first.  So, start from the simple workaround.
Thank you for your explanation.
I managed to fix the pin address, but as I told before the jack
detection is totally messed up.
"hdajacksensetest" fails with:
Ioctl call failed with error 16

I can't understand why, as ca0132_select_out() already relies on
spec->out_pins[0] and spec->out_pins[1].

Regards,
Gabriele


--------------000709000104040207020605
Content-Type: text/x-patch;
 name="ca0132-alienware.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ca0132-alienware.patch"

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4a4e7b2..c9b0211 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -748,10 +748,24 @@
=20
 	struct hda_codec *codec;
 	struct delayed_work unsol_hp_work;
+	const struct snd_pci_quirk *quirk;
=20
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
+};
+
+/*
+ * CA0132 quirks table
+ */
+enum {
+	QUIRK_NONE,
+	QUIRK_ALIENWARE,
+};
+
+static const struct snd_pci_quirk ca0132_quirks[] =3D {
+	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
+	{}
 };
=20
 /*
@@ -4653,6 +4667,7 @@
 		return -ENOMEM;
 	codec->spec =3D spec;
 	spec->codec =3D codec;
+	spec->quirk =3D snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
=20
 	spec->dsp_state =3D DSP_DOWNLOAD_INIT;
 	spec->num_mixers =3D 1;
@@ -4670,6 +4685,12 @@
=20
 	ca0132_config(codec);
=20
+	/* Apply detected quirks */
+	if (spec->quirk->value =3D=3D QUIRK_ALIENWARE) {
+		codec_dbg(codec, "QUIRK_ALIENWARE applied.\n\n");
+		spec->out_pins[1] =3D 0x0f;
+	}
+
 	err =3D snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
 	if (err < 0)
 		return err;

--------------000709000104040207020605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000709000104040207020605--
