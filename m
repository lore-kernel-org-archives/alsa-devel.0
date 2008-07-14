From: "Tony \"Chainsaw\" Vroon" <chainsaw@gentoo.org>
Subject: Re: SB0880 X-Fi Titanium Fatal1ty Pro (with	codecgraph)
Date: Mon, 14 Jul 2008 22:29:07 +0100
Message-ID: <1216070947.4071.14.camel@localhost>
References: <1215985902.4196.11.camel@localhost> <s5h4p6rw5zu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0246482022487880271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id D3EC71037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 23:28:46 +0200 (CEST)
In-Reply-To: <s5h4p6rw5zu.wl%tiwai@suse.de>
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


--===============0246482022487880271==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-igaxa+AUnn80CpwjjoSg"


--=-igaxa+AUnn80CpwjjoSg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-15 at 16:56 +0200, Takashi Iwai wrote:
> Could you try the git tree
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.=
6.git
> ?

Certainly, compiled and running:
Linux prometheus 2.6.26-rc7-00240-gfae47c0 #1 SMP Mon Jul 14 22:10:33
BST 2008 x86_64 Quad-Core AMD Opteron(tm) Processor 2354 AuthenticAMD
GNU/Linux

The card is detected, and the auto-detection really seems to do quite
well:
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
ALSA device list:
  #0: HDA Intel at 0xd0100000 irq 47

Unfortunately, it now reverts to the same "short attention span" problem
that I have seen before. This occured when I tried to write a
patch_creative.c myself, and I had blamed this on my unfamiliarity with
the framework:
hda_codec: num_steps =3D 0 for NID=3D0x8 (ctl =3D Line Capture Volume)
ALSA sound/pci/hda/hda_intel.c:601: hda_intel: azx_get_response timeout,
switching to polling mode: last cmd=3D0x101f000a
ALSA sound/pci/hda/hda_intel.c:608: hda_intel: azx_get_response timeout,
switching to single_cmd mode: last cmd=3D0x101f000a
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0

I provoked this with a simple: cat /proc/asound/card0/codec#1

It produces valid-looking output the first time (that I shared with you
in my initial e-mail), and then the card's short attention span gets the
better of it. It is dead in the water, and no matter how hard ALSA
tries, it gets no response out of it:

ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
__ratelimit: 3 messages suppressed
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0
__ratelimit: 85 messages suppressed
ALSA sound/pci/hda/hda_intel.c:666: hda-intel: get_response timeout:
IRS=3D0x0

Can you perhaps decode the command from the printk to a problematic
widget that should be left alone?
I will now powercycle the machine and try to use the soundcard without
poking at the codec info.

Note that I've tried this card on MSI as well, and the behaviour is
exactly the same (only disabling MSI is another troubleshooting step for
the framework, which is equally unsuccessful).
The card displays various completely broken codec configurations once in
this state, occasionally causing an 'Invalid AFG subtree' message but
usually settling on a GPIO configuration with 255 I/Os (seemingly caused
by reading an area of all ones):
GPIO: io=3D255, o=3D255, i=3D255, unsolicited=3D1, wake=3D1
  IO[0]: enable=3D1, dir=3D1, wake=3D1, sticky=3D1, data=3D1
  IO[1]: enable=3D1, dir=3D1, wake=3D1, sticky=3D1, data=3D1
(and so on)

The mainboard that I'm trying this on is a Tyan Thunder n6650W (S2915-E)
on BIOS revision 2.07; the card is in one of the 8-lane PCI-express
slots.

Regards,
Tony V.

--=-igaxa+AUnn80CpwjjoSg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh7xSMACgkQp5vW4rUFj5qBEgCgmmkQoBpytkTVkSYUSZKLoQaP
eH0Anj1VfMfN1xCInL192Yuem4hWtn2o
=D81d
-----END PGP SIGNATURE-----

--=-igaxa+AUnn80CpwjjoSg--


--===============0246482022487880271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0246482022487880271==--
