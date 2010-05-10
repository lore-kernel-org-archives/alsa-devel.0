From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Not all channels working with IDT 92HD83C1X5
Date: Mon, 10 May 2010 08:36:30 +0200
Message-ID: <20100510063630.GA22381@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2379538481650886469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id D8B9F103802
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 08:36:30 +0200 (CEST)
Received: from mailbox.adnet.avionic-design.de
	(add-virt-zarafa.adnet.avionic-design.de [172.20.129.9])
	by benhur.adnet.avionic-design.de (Postfix) with ESMTP id 9202B2C4112
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 08:36:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id C5B872A280BA
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 08:36:29 +0200 (CEST)
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
	by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id l2Ay4Sb3t9zK for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 08:36:29 +0200 (CEST)
Received: from localhost (avionic-0027.adnet.avionic-design.de [172.20.13.224])
	(Authenticated sender: thierry.reding)
	by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id
	2CB7E2A2809D for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 08:36:29 +0200 (CEST)
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


--===============2379538481650886469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a board with an IDT 92HD83C1X5 codec connected to an Intel HDA
controller. When running a older "reference" Ubuntu 9.04 (provided by the
vendor) the codec works fine. I've been diffing the sources provided of the
2.6.28 kernel against vanilla 2.6.28 and couldn't find any significant
changes regarding HDA or the patch_sigmatel.c that has the support for this
codec.

However, when I use kernel 2.6.34-rc6 on the same hardware, only one channel
is working properly, all others remain muted. After some investigation I came
up with the attached patch that makes all channels work again. I am aware
that this is far from being acceptable code and that this is only a
workaround. Still, I am interested in fixing this properly, but I don't
really know where to start.

Also attached is an extract of dmesg with the actual output of the debugging
messages added by the attached patch.

Cheers,
Thierry

--tThc/1wpZn/ma/RB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="workaround.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 7fb7d01..a227381 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2448,6 +2448,11 @@ static void stac92xx_auto_set_pinctl(struct hda_code=
c *codec, hda_nid_t nid, int
 				  AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
 }
=20
+static unsigned int stac92xx_auto_get_pinctl(struct hda_codec *codec, hda_=
nid_t nid)
+{
+	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PIN_WIDGET_CONTROL, =
0x00);
+}
+
 #define stac92xx_hp_switch_info		snd_ctl_boolean_mono_info
=20
 static int stac92xx_hp_switch_get(struct snd_kcontrol *kcontrol,
@@ -4377,6 +4382,20 @@ static int stac92xx_init(struct hda_codec *codec)
 #endif=09
 	if (spec->dac_list)
 		stac92xx_power_down(codec);
+
+	snd_printd("pin control for nid:%x: %x, overwriting with %x\n", 0x0a,
+			stac92xx_auto_get_pinctl(codec, 0x0a), 0xc0);
+	stac92xx_auto_set_pinctl(codec, 0x0a, 0xc0);
+	snd_printd("pin control for nid:%x: %x, overwriting with %x\n", 0x0c,
+			stac92xx_auto_get_pinctl(codec, 0x0c), 0x40);
+	stac92xx_auto_set_pinctl(codec, 0x0c, 0x40);
+	snd_printd("pin control for nid:%x: %x, overwriting with %x\n", 0x0d,
+			stac92xx_auto_get_pinctl(codec, 0x0d), 0x40);
+	stac92xx_auto_set_pinctl(codec, 0x0d, 0x40);
+	snd_printd("pin control for nid:%x: %x, overwriting with %x\n", 0x0f,
+			stac92xx_auto_get_pinctl(codec, 0x0f), 0x40);
+	stac92xx_auto_set_pinctl(codec, 0x0f, 0x40);
+
 	return 0;
 }
=20

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-snd-hda-intel.log"

[  320.873160] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  320.879331] HDA Intel 0000:00:1b.0: irq 27 for MSI/MSI-X
[  320.885273] HDA Intel 0000:00:1b.0: setting latency timer to 64
[  320.891083] ALSA hda_intel.c:2489: chipset global capabilities = 0x4401
[  320.929023] ALSA hda_intel.c:904: codec_mask = 0x1
[  320.935204] ALSA hda_intel.c:1337: codec #0 probed OK
[  320.948094] ALSA patch_sigmatel.c:5343: hda_codec: 92HD83C1X5: BIOS auto-probing.
[  320.954439] ALSA hda_codec.c:4358: autoconfig: line_outs=1 (0xb/0x0/0x0/0x0/0x0)
[  320.960778] ALSA hda_codec.c:4362:    speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
[  320.967206] ALSA hda_codec.c:4366:    hp_outs=1 (0xa/0xb/0x0/0x0/0x0)
[  320.973720] ALSA hda_codec.c:4367:    mono: mono_out=0x0
[  320.980270] ALSA hda_codec.c:4370:    dig-out=0x1f/0x20
[  320.986860] ALSA hda_codec.c:4378:    inputs: mic=0x11, fmic=0xc, line=0xf, fline=0x0, cd=0x0, aux=0x0
[  320.994189] ALSA patch_sigmatel.c:3018: stac92xx: dac_nids=1 (0x13/0x0/0x0/0x0/0x0)
[  321.001502] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input15
[  321.017660] ALSA patch_sigmatel.c:4387: pin control for nid:a: 0, overwriting with c0
[  321.026777] ALSA patch_sigmatel.c:4390: pin control for nid:c: 24, overwriting with 40
[  321.034817] ALSA patch_sigmatel.c:4393: pin control for nid:d: 0, overwriting with 40
[  321.041797] ALSA patch_sigmatel.c:4396: pin control for nid:f: 20, overwriting with 40
[  321.048860] ALSA hda_codec.c:1968: Cannot find slave Surround Playback Volume, skipped
[  321.055777] ALSA hda_codec.c:1968: Cannot find slave Center Playback Volume, skipped
[  321.062614] ALSA hda_codec.c:1968: Cannot find slave LFE Playback Volume, skipped
[  321.069408] ALSA hda_codec.c:1968: Cannot find slave Side Playback Volume, skipped
[  321.076213] ALSA hda_codec.c:1968: Cannot find slave Surround Playback Switch, skipped
[  321.083019] ALSA hda_codec.c:1968: Cannot find slave Center Playback Switch, skipped
[  321.089845] ALSA hda_codec.c:1968: Cannot find slave LFE Playback Switch, skipped
[  321.096564] ALSA hda_codec.c:1968: Cannot find slave Side Playback Switch, skipped
[  321.103900] input: HDA Intel Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[  321.113685] input: HDA Intel Mic at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[  321.123851] input: HDA Intel HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[  321.145576] input: HDA Intel HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19

--tThc/1wpZn/ma/RB--

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvnqW4ACgkQZ+BJyKLjJp/qkACfWlRoulrNZG3v7/KQ9X+NhvjI
L2wAoInPNgk6obOgVNO6nPgGMgA8IA6r
=hYHy
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

--===============2379538481650886469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2379538481650886469==--
