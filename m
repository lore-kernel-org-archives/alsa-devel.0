From: Michael Gerdau <mgd@technosis.de>
Subject: [Regression] snd-hda-intel no longer loads as of
	alsa-driver-hg20070728
Date: Mon, 30 Jul 2007 20:22:48 +0200
Message-ID: <200707302023.12091.mgd@technosis.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3539900537913051307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D29810383B
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jul 2007 20:23:14 +0200 (CEST)
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

--===============3539900537913051307==
Content-Type: multipart/signed;
  boundary="nextPart1693475.Wk3W558U7A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1693475.Wk3W558U7A
Content-Type: multipart/mixed;
  boundary="Boundary-01=_4xirGu+/fUuEXUi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_4xirGu+/fUuEXUi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list,

snd-hda-intel does no longer load on my Dell XPS M1710 using
alsa-driver-hg20070728. However it works without apparent problems
with alsa-driver-hg20070727.

I'm running 2.6.22.1-cfs-v19 on a SuSE 10.2 x86_64.

=46ind attached an excerpt from /var/log/messages first loading
hg20070727 followed by hg20070728.

If you need additional info drop me a note.

Best,
Michael
=2D-=20
 Technosis GmbH, Gesch=C3=A4ftsf=C3=BChrer: Michael Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--Boundary-01=_4xirGu+/fUuEXUi
Content-Type: text/plain;
  charset="utf-8";
  name="messages.alsa"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="messages.alsa"

Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:timer
Jul 30 20:08:06 seneca kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
Jul 30 20:08:06 seneca kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:695: codec_mask = 0x3
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:1827: hda_codec: model 'ref' is selected for config 1028:1ce (Dell XPS M1710)
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 08 pin config 01c47010
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 09 pin config 01447010
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 0d pin config 0221401f
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 0e pin config 01114010
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 0f pin config 02a19020
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 10 pin config 01a19021
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 11 pin config 90100140
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:841: hda_codec: pin nid 12 pin config 01813122
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:2331: autoconfig: line_outs=1 (0xe/0x0/0x0/0x0/0x0)
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:2335:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:2339:    hp_outs=1 (0xd/0x0/0x0/0x0/0x0)
Jul 30 20:08:06 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:2347:    inputs: mic=0x10, fmic=0xf, line=0x12, fline=0x0, cd=0x0, aux=0x0
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:card0
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:pcmC0D1p
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:pcmC0D1c
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:pcmC0D0p
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:pcmC0D0c
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:controlC0
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:seq
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:mixer
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:adsp
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:dsp
Jul 30 20:08:06 seneca kernel: PM: Adding info for No Bus:audio
Jul 30 20:08:18 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1185: azx_pcm_prepare: bufsize=0x4000, fragsize=0x2000, format=0x4011
Jul 30 20:08:18 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Jul 30 20:08:18 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Jul 30 20:08:18 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1185: azx_pcm_prepare: bufsize=0x4000, fragsize=0x2000, format=0x4011
Jul 30 20:08:18 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Jul 30 20:08:18 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Jul 30 20:08:21 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
Jul 30 20:08:21 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
Jul 30 20:08:21 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070727/pci/hda/hda_codec.c:631: hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
Jul 30 20:10:48 seneca su: (to root) mgd on /dev/pts/8
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:adsp
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:dsp
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:audio
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:mixer
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:seq
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:pcmC0D1p
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:pcmC0D1c
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:pcmC0D0p
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:pcmC0D0c
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:controlC0
Jul 30 20:11:22 seneca kernel: ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Jul 30 20:11:22 seneca kernel: PM: Removing info for No Bus:card0
Jul 30 20:11:23 seneca kernel: PM: Removing info for No Bus:timer
Jul 30 20:11:23 seneca kernel: PM: Adding info for No Bus:timer
Jul 30 20:11:23 seneca kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
Jul 30 20:11:23 seneca kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Jul 30 20:11:23 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070728/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:708: codec_mask = 0x3
Jul 30 20:11:23 seneca kernel: hda-codec: No codec parser is available
Jul 30 20:11:23 seneca kernel: hda-codec: No codec parser is available
Jul 30 20:11:23 seneca kernel: ALSA /home/mgd/src/alsa-driver-hg20070728/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1039: hda-intel: no codecs initialized
Jul 30 20:11:23 seneca kernel: ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Jul 30 20:11:23 seneca kernel: PM: Adding info for No Bus:seq

--Boundary-01=_4xirGu+/fUuEXUi--

--nextPart1693475.Wk3W558U7A
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGriyQUYYhyuxDQc4RAt7PAJ0fDWiDf98T8QifWYgpdmfmYBIH2gCdGyiN
1mhQYEajT2wLIsbnJTF3ygY=
=gwiR
-----END PGP SIGNATURE-----

--nextPart1693475.Wk3W558U7A--

--===============3539900537913051307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3539900537913051307==--
