From: Shaw Terwilliger <sterwill@sourcegear.com>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 11 Dec 2006 10:52:44 -0600
Message-ID: <457D8CDC.4090501@sourcegear.com>
References: <4574866D.5070506@sourcegear.com>	
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>	
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>	
	<1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com>	 <457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>	
	<4579BF60.8000601@sourcegear.com>
	<1165767364.7530.148.camel@razman>	
	<457D6E99.2000207@sourcegear.com>
	<1165854833.7530.205.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1108175241=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165854833.7530.205.camel@razman>
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
--===============1108175241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC1131AF718F3D97E6FD0A23"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC1131AF718F3D97E6FD0A23
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

lineTobin Davis wrote:
> Ok, based on that information, I think I have a working patch.  Give
> this a try.=20
>=20
> I'll let the next guy work on the S/PDIF if there is an issue with it.

I get no sound from my speakers at all with this patch (via aplay,
speaker-test, etc.).  Here's the dmesg from load:

[601946.977991] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 23 (level,
low) -> IRQ 225
[601946.978931] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[601947.011648] ALSA
/data/downloads/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/h=
da_intel.c:696:
codec_mask =3D 0x1
[601947.196396] ALSA
/data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743:
hda_codec: model 'macpro' is selected

The mixer shows the following playback channels:

PCM
Front
Line-in
PC Speakers

I even tried the front headphone jack with the speaker test and toggled
the headphone switch.  No sound.

--=20
Shaw Terwilliger <sterwill@sourcegear.com>
SourceGear LLC


--------------enigCC1131AF718F3D97E6FD0A23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfYzhPEbgvbl6u4ERArsbAKCDq+ylBH6YgNl7CVzXEnErUpkuVACfalJe
rjBl1xJZz9uFuKj5jok9vbE=
=xKt9
-----END PGP SIGNATURE-----

--------------enigCC1131AF718F3D97E6FD0A23--


--===============1108175241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1108175241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1108175241==--
