From: Michael Gerdau <mgd@technosis.de>
Subject: Re:
	=?iso-8859-1?q?=5BRegression=5D_snd-hda-intel_no_lon?=
	=?iso-8859-1?q?ger_loads_as_of=09alsa-driver-hg20070728?=
Date: Fri, 10 Aug 2007 14:57:49 +0200
Message-ID: <200708101458.00591.mgd@technosis.de>
References: <200707302023.12091.mgd@technosis.de>
	<s5h64413bsd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3441839567696383153=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id DDB5F10391D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 14:58:01 +0200 (CEST)
In-Reply-To: <s5h64413bsd.wl%tiwai@suse.de>
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

--===============3441839567696383153==
Content-Type: multipart/signed;
  boundary="nextPart2581484.yy8FJcaKna";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2581484.yy8FJcaKna
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > snd-hda-intel does no longer load on my Dell XPS M1710 using
> > alsa-driver-hg20070728. However it works without apparent problems
> > with alsa-driver-hg20070727.
> >=20
> > I'm running 2.6.22.1-cfs-v19 on a SuSE 10.2 x86_64.
> >=20
> > Find attached an excerpt from /var/log/messages first loading
> > hg20070727 followed by hg20070728.
> >=20
> > If you need additional info drop me a note.
>=20
> Thanks for reporting.
>=20
> This looks rather like a tempory problem at preparation of tarball.
> You should have get the correct driver by hgcompile instead of
> configure.

Hmm.=20

I tried=20
  ./hgcompile --with-sequencer=3Dyes --with-debug=3Ddetect --with-cards=3Dh=
da-intel,usb-audio --with-card-options=3Dseq-rtctimer-default
which says
make: F=FCr das Ziel =BBall-deps=AB ist nichts zu tun.
[means: nothing to do for target =BBall-deps=AB]
and then invokes
  ./configure --with-sequencer=3Dyes --with-debug=3Ddetect --with-cards=3Dh=
da-intel,usb-audio --with-card-options=3Dseq-rtctimer-default

This works for alsa-driver-hg20070727 but does not work for any of the
later versions I tried, including alsa-driver-hg20070810

How temporary is temporary then ;-) ?


=46WIW here comes an excerpt from my /var/log/messages after trying to load
hg20070810 followed by hg20070727.

Aug 10 14:42:47 localhost kernel: PM: Removing info for No Bus:seq
Aug 10 14:42:47 localhost kernel: PM: Removing info for No Bus:timer
Aug 10 14:42:48 localhost kernel: PM: Adding info for No Bus:timer
Aug 10 14:42:48 localhost kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GS=
I 21 (level, low) -> IRQ 21
Aug 10 14:42:48 localhost kernel: PCI: Setting latency timer of device 0000=
:00:1b.0 to 64
Aug 10 14:42:48 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070810=
/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:708: codec_mask =3D 0x3
Aug 10 14:42:48 localhost kernel: hda-codec: No codec parser is available
Aug 10 14:42:48 localhost kernel: hda-codec: No codec parser is available
Aug 10 14:42:48 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070810=
/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1039: hda-intel: no codecs i=
nitialized
Aug 10 14:42:48 localhost kernel: ACPI: PCI interrupt for device 0000:00:1b=
=2E0 disabled
Aug 10 14:42:48 localhost kernel: PM: Adding info for No Bus:seq
Aug 10 14:49:23 localhost su: (to root) mgd on /dev/pts/8
Aug 10 14:49:33 localhost kernel: PM: Removing info for No Bus:seq
Aug 10 14:49:33 localhost kernel: PM: Removing info for No Bus:timer
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:timer
Aug 10 14:49:33 localhost kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GS=
I 21 (level, low) -> IRQ 21
Aug 10 14:49:33 localhost kernel: PCI: Setting latency timer of device 0000=
:00:1b.0 to 64
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:695: codec_mask =3D 0x3
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/hda_codec.c:1827: hda_codec: model 'ref' is selected for config 10=
28:1ce (Dell XPS M1710)
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 08 pin config 01c47010
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 09 pin config 01447010
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 0d pin config 0221401f
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 0e pin config 01114010
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 0f pin config 02a19020
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 10 pin config 01a19021
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 11 pin config 90100140
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid=
 12 pin config 01813122
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/hda_codec.c:2331: autoconfig: line_outs=3D1 (0xe/0x0/0x0/0x0/0x0)
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/hda_codec.c:2335:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/hda_codec.c:2339:    hp_outs=3D1 (0xd/0x0/0x0/0x0/0x0)
Aug 10 14:49:33 localhost kernel: ALSA /home/mgd/src/alsa-driver-hg20070727=
/pci/hda/hda_codec.c:2347:    inputs: mic=3D0x10, fmic=3D0xf, line=3D0x12, =
fline=3D0x0, cd=3D0x0, aux=3D0x0
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:card0
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:pcmC0D1p
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:pcmC0D1c
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:pcmC0D0p
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:pcmC0D0c
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:controlC0
Aug 10 14:49:33 localhost kernel: PM: Adding info for No Bus:seq
Aug 10 14:49:34 localhost kernel: PM: Adding info for No Bus:mixer
Aug 10 14:49:34 localhost kernel: PM: Adding info for No Bus:adsp
Aug 10 14:49:34 localhost kernel: PM: Adding info for No Bus:dsp
Aug 10 14:49:34 localhost kernel: PM: Adding info for No Bus:audio

Anything I can do to help track down the problem ?

Best,
Michael
=2D-=20
 Technosis GmbH, Gesch=E4ftsf=FChrer: Heiko Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--nextPart2581484.yy8FJcaKna
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGvGDYUYYhyuxDQc4RAi/OAJ0UE49mxzcqT94UlEbT7cIrO7pFnQCfSvka
5uE9X8N+Rw2hsVobjShCWgE=
=QWkS
-----END PGP SIGNATURE-----

--nextPart2581484.yy8FJcaKna--

--===============3441839567696383153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3441839567696383153==--
