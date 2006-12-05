From: Shaw Terwilliger <sterwill@sourcegear.com>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 04 Dec 2006 22:02:58 -0600
Message-ID: <4574EF72.8020207@sourcegear.com>
References: <4574866D.5070506@sourcegear.com>	
	<1165265511.32312.86.camel@razman>
	<45748CF5.8040800@sourcegear.com>	
	<1165275957.32312.103.camel@razman>
	<4574BB17.1020807@sourcegear.com>
	<1165278602.32312.110.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0717495414=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165278602.32312.110.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0717495414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C1D602BAB2D7D19AE59E00B"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C1D602BAB2D7D19AE59E00B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

alsa-devel@lists.sourceforge.netTobin Davis wrote:
> This is strange.  Could you try 'lspci -s  0:1b -vv"?  It should have
> something there, but maybe not.

00:1b.0 Audio device: Intel Corporation Enterprise Southbridge High
Definition Audio (rev 09)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
-
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at 92f00000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enab=
le-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0

>> Kernel messages are from 1.0.13 with --with-debug=3Dfull:
>>
> I had thought you compiled with "--with-debug=3Ddetect".  This actually=

> gives different output than full debug mode.

I changed it to "full" later to see if I got any more info.  Here they
are again with --with-debug=3Ddetect (4 Xeon cores makes ALSA compiles fl=
y
by):

modprobe snd-hda-intel:
[37954.257842] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 23 (level,
low) -> IRQ 225
[37954.258700] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[37954.291651] ALSA
/data/downloads/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_=
intel.c:680:
codec_mask =3D 0x1
[37954.471856] ALSA
/data/downloads/alsa-driver-1.0.13/pci/hda/hda_codec.c:1756: hda_codec:
PCI 0:0, codec config 0 is selected

> This is actually good info.  Interesting that sound is coming out from
> the Surround channels.  The low volume could mean that EAPD still needs=

> to be set.
>=20
> I'll look more into this tomorrow.  Hopefully I can get a patch for you=

> to test.

Thanks for all your help.  I'm happy to test any patches you come up with=
=2E

--=20
Shaw Terwilliger <sterwill@sourcegear.com>
SourceGear LLC


--------------enig0C1D602BAB2D7D19AE59E00B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdO92PEbgvbl6u4ERAg6zAJ0WboIuN3zr5LUc65tCY0/szZDt9ACdE3BA
nRExILyNTrFd2hE+CenWv/E=
=l3XY
-----END PGP SIGNATURE-----

--------------enig0C1D602BAB2D7D19AE59E00B--


--===============0717495414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0717495414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0717495414==--
