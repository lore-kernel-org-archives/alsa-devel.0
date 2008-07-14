From: Tony Vroon <tony@vroon.org>
Subject: Re: SB0880 X-Fi Titanium Fatal1ty Pro (with	codecgraph)
Date: Mon, 14 Jul 2008 22:35:29 +0100
Message-ID: <1216071329.4018.1.camel@localhost>
References: <1215985902.4196.11.camel@localhost>
	<s5h4p6rw5zu.wl%tiwai@suse.de> <487B5344.7020709@gmx.de>
	<s5hskubq72c.wl%tiwai@suse.de> <487B5BD9.7090307@gmx.de>
	<s5h4p6qreho.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7078330285720450213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id E0E7624478
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 23:35:06 +0200 (CEST)
In-Reply-To: <s5h4p6qreho.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Maximilian =?ISO-8859-1?Q?G=FCntner?= <beomuex@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============7078330285720450213==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VE7D6thQlRpTC4F/1omt"


--=-VE7D6thQlRpTC4F/1omt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Clearly a harder reboot is required, I will power the machine off and
unplug it from the AC for a few minutes. A regular powercycle resulted
in the following oops report:

ACPI: PCI Interrupt Link [LK2E] enabled at IRQ 47
ACPI: PCI Interrupt 0000:83:00.0[A] -> Link [LK2E] -> GSI 47 (level,
high) -> IRQ 47
PCI: Setting latency timer of device 0000:83:00.0 to 64
ALSA sound/pci/hda/hda_intel.c:2022: chipset global capabilities =3D
0x3500
ALSA sound/pci/hda/hda_intel.c:754: codec_mask =3D 0x2
ALSA sound/pci/hda/hda_codec.c:3242: autoconfig: line_outs=3D4
(0xd/0xf/0xe/0x10/0x0)
ALSA sound/pci/hda/hda_codec.c:3246:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3250:    hp_outs=3D1 (0x11/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3251:    mono: mono_out=3D0x0
ALSA sound/pci/hda/hda_codec.c:3259:    inputs: mic=3D0x14, fmic=3D0x0,
line=3D0x13, fline=3D0x0, cd=3D0x0, aux=3D0x0
ALSA sound/pci/hda/hda_codec.c:2336: BUG? (info->nid)
Pid: 1, comm: swapper Not tainted 2.6.26-rc7-00240-gfae47c0 #1

Call Trace:
 [<ffffffff804668ed>] snd_hda_build_pcms+0x1fc/0x29c
 [<ffffffff804ec225>] azx_probe+0x7ed/0x7fd
 [<ffffffff804639b5>] azx_send_cmd+0x0/0x130
 [<ffffffff80463ae5>] azx_get_response+0x0/0x207
 [<ffffffff8046320a>] azx_attach_pcm_stream+0x0/0x1a0
 [<ffffffff80462ed4>] azx_power_notify+0x0/0x51
 [<ffffffff80324bd1>] pci_device_probe+0xa9/0xf6
 [<ffffffff803b138a>] driver_probe_device+0xb5/0x159
 [<ffffffff803b1474>] __driver_attach+0x46/0x6d
 [<ffffffff803b142e>] __driver_attach+0x0/0x6d
 [<ffffffff803b0c9e>] bus_for_each_dev+0x44/0x78
 [<ffffffff803b0630>] bus_add_driver+0xac/0x1e6
 [<ffffffff803b1638>] driver_register+0xa2/0x11f
 [<ffffffff80324e4a>] __pci_register_driver+0x4a/0x7c
 [<ffffffff80660b68>] alsa_card_azx_init+0x0/0x15
 [<ffffffff80644656>] kernel_init+0x146/0x28b
 [<ffffffff8020cc08>] child_rip+0xa/0x12
 [<ffffffff80644510>] kernel_init+0x0/0x28b
 [<ffffffff8020cbfe>] child_rip+0x0/0x12

ACPI: PCI interrupt for device 0000:83:00.0 disabled
HDA Intel: probe of 0000:83:00.0 failed with error -22
ALSA device list:
  No soundcards found.

Regards,
Tony V.

--=-VE7D6thQlRpTC4F/1omt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh7xqEACgkQp5vW4rUFj5rxEQCgnxv2ed9BqyE8wXE9lrTTHMAo
utgAoL0kZgpzxPQrmPyHtKTiIQ0PGY27
=f/II
-----END PGP SIGNATURE-----

--=-VE7D6thQlRpTC4F/1omt--


--===============7078330285720450213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7078330285720450213==--
