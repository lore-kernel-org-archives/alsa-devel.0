From: Shaw Terwilliger <sterwill@sourcegear.com>
Subject: Re: Intel HDA on Mac Pro
Date: Fri, 08 Dec 2006 13:39:12 -0600
Message-ID: <4579BF60.8000601@sourcegear.com>
References: <4574866D.5070506@sourcegear.com>	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>	<1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com>	<457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1851396471=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165535200.7530.63.camel@razman>
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
--===============1851396471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B5D78B192CECC1F21BC4BE1"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B5D78B192CECC1F21BC4BE1
Content-Type: multipart/mixed; boundary="------------010900010707000500060908"

This is a multi-part message in MIME format.
--------------010900010707000500060908
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tobin Davis wrote:
> To test it, start with either the alsa-driver-hg20061130.tar.bz2 or
> download the recent 1.0.14rc1 and follow these instructions:
> tar -jxvf alsa-driver-<version>.tar.bz2   # <version> =3D=3D hg20061130=
 or
> 1.0.14rc1
> cd alsa-driver-<version>/alsa-kernel
> patch -p1 <macpro.patch.1
> cd ..
> ./configure --with-cards=3Dhda-intel --with-debug=3Ddetect ; make ; mak=
e install
> dmesg -c
> modprobe -r snd-hda-intel
> modprobe snd-hda-intel model=3Dmacpro
> dmesg >dmesg.out

Patch applies cleanly and builds with 1.0.14rc1, and macpro model
selection works.  The dmesg dump is attached (though it's pretty terse).

> Send me a copy of dmesg.out along with any differences that you see.  I=

> may need to tweak which pins get enabled.

Great news: I have the correct volume!  Here are some mixer oddities:

- The "Surround" mixer channels actually control what comes out of the
line-out jack on the back of the Mac Pro (where I have my speakers
plugged in).  This was the case before.

- The "Front Mic" mixer channels actually control the line-in jack on
the back of the Mac Pro (where I have my radio's line-out plugged in).

- No combination of mixer channel volumes and "Headphone" switch setting
seems to control the headphone jack on the front of the Mac Pro (can't
get any sound from it).  Not a big deal for me, but might be for others.

- The "PC Speaker" mixer channel doesn't control the internal speaker.
I don't know if this is actually possible in OS X (don't have it installe=
d).

Also, I don't have an optical cable to test the digital in/out.  Have
not tested the other analog channels (don't have a mic, etc.).

Thanks for your work fixing up the driver for the 885.

--=20
Shaw Terwilliger <sterwill@teamprise.com>
Teamprise LLC
http://teamprise.com/



--=20
Shaw Terwilliger <sterwill@sourcegear.com>
SourceGear LLC

--------------010900010707000500060908
Content-Type: text/plain;
 name="model-macpro.dmesg.out"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="model-macpro.dmesg.out"

WzM1MjMzNC45NjYzNTldIEFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxYi4wW0FdIC0+
IEdTSSAyMyAobGV2ZWwsIGxvdykgLT4gSVJRIDIyNQpbMzUyMzM0Ljk2NzI4OV0gUENJOiBT
ZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWIuMCB0byA2NApbMzUy
MzM1LjAwMDA5NV0gQUxTQSAvZGF0YS9kb3dubG9hZHMvYWxzYS1kcml2ZXItMS4wLjE0cmMx
L3BjaS9oZGEvLi4vLi4vYWxzYS1rZXJuZWwvcGNpL2hkYS9oZGFfaW50ZWwuYzo2OTY6IGNv
ZGVjX21hc2sgPSAweDEKWzM1MjMzNS4xNzc5MTddIEFMU0EgL2RhdGEvZG93bmxvYWRzL2Fs
c2EtZHJpdmVyLTEuMC4xNHJjMS9wY2kvaGRhL2hkYV9jb2RlYy5jOjE3NDM6IGhkYV9jb2Rl
YzogbW9kZWwgJ21hY3BybycgaXMgc2VsZWN0ZWQK
--------------010900010707000500060908--

--------------enig6B5D78B192CECC1F21BC4BE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeb9nPEbgvbl6u4ERArFRAJwJFZ7Gvrq0D0CurS7aXz/tY6hKdQCeJ813
ajgh2FYw8wCT4Nh8VmzJHuw=
=cOCk
-----END PGP SIGNATURE-----

--------------enig6B5D78B192CECC1F21BC4BE1--


--===============1851396471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1851396471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1851396471==--
