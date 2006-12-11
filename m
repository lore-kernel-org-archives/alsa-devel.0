From: Shaw Terwilliger <sterwill@sourcegear.com>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 11 Dec 2006 08:43:37 -0600
Message-ID: <457D6E99.2000207@sourcegear.com>
References: <4574866D.5070506@sourcegear.com>	
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>	
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>	
	<1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com>	 <457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>	
	<4579BF60.8000601@sourcegear.com>
	<1165767364.7530.148.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1484999379=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165767364.7530.148.camel@razman>
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
--===============1484999379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC0B36DD8D036AF85980A22F8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0B36DD8D036AF85980A22F8
Content-Type: multipart/mixed; boundary="------------020503080505030806030406"

This is a multi-part message in MIME format.
--------------020503080505030806030406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tobin Davis wrote:
> modprobe -r snd-hda-intel
> dmesg -c >/dev/null
> modprobe snd-hda-intel model=3Dauto
> dmesg >dmesg.out  # send me this output
>=20
> This should (hopefully) detect which port the headphones are on.  It
> won't enable sound, but it is useful for detecting pins from the bios
> settings.

File is attached.

> Also, when you said sound was coming from the surround channels, do you=

> know if the front output was coming from that?  To test this, reload th=
e
> driver with "model=3Dmacpro" and type:
> speaker-test -c 6 -t wav -Dplug:surround51

I get:

Unable to set nperiods 4 for playback: Invalid argument
Setting of hwparams failed: Invalid argument

If I change "-c 6" to "-c 8", I can run with the rest of the args (also
works with 4).  The "rear right" channel in the speaker test comes from
the actual front right speaker (and "rear left" from the actual front
left).  Speakers are plugged in the to Mac's rear line-out.  And it's
the "Surround" mixer strip (alsamixer) that controls these volumes.

--=20
Shaw Terwilliger <sterwill@sourcegear.com>
SourceGear LLC

--------------020503080505030806030406
Content-Type: text/plain;
 name="hda-model-auto.dmesg.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hda-model-auto.dmesg.txt"

WzU5MzkzOS4zNDM1ODRdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxYi4wW0FdIC0+
IEdTSSAyMyAobGV2ZWwsIGxvdykgLT4gSVJRIDIyNQpbNTkzOTM5LjM0NDQ1OF0gUENJOiBT
ZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWIuMCB0byA2NApbNTkz
OTM5LjM3ODU0N10gQUxTQSAvZGF0YS9kb3dubG9hZHMvYWxzYS1kcml2ZXItMS4wLjE0cmMx
L3BjaS9oZGEvLi4vLi4vYWxzYS1rZXJuZWwvcGNpL2hkYS9oZGFfaW50ZWwuYzo2OTY6IGNv
ZGVjX21hc2sgPSAweDEKWzU5MzkzOS41NTYzMjhdIEFMU0EgL2RhdGEvZG93bmxvYWRzL2Fs
c2EtZHJpdmVyLTEuMC4xNHJjMS9wY2kvaGRhL2hkYV9jb2RlYy5jOjE3NDM6IGhkYV9jb2Rl
YzogbW9kZWwgJ2F1dG8nIGlzIHNlbGVjdGVkCls1OTM5MzkuNjA0ODEyXSBBTFNBIC9kYXRh
L2Rvd25sb2Fkcy9hbHNhLWRyaXZlci0xLjAuMTRyYzEvcGNpL2hkYS9oZGFfY29kZWMuYzoy
MTc1OiBhdXRvY29uZmlnOiBsaW5lX291dHM9MSAoMHgxNS8weDAvMHgwLzB4MC8weDApCls1
OTM5MzkuNjA0ODE3XSBBTFNBIC9kYXRhL2Rvd25sb2Fkcy9hbHNhLWRyaXZlci0xLjAuMTRy
YzEvcGNpL2hkYS9oZGFfY29kZWMuYzoyMTc5OiAgICBzcGVha2VyX291dHM9MSAoMHgxYS8w
eDAvMHgwLzB4MC8weDApCls1OTM5MzkuNjA0ODIxXSBBTFNBIC9kYXRhL2Rvd25sb2Fkcy9h
bHNhLWRyaXZlci0xLjAuMTRyYzEvcGNpL2hkYS9oZGFfY29kZWMuYzoyMTgzOiAgICBocF9v
dXRzPTEgKDB4MTgvMHgwLzB4MC8weDAvMHgwKQpbNTkzOTM5LjYwNDgyNF0gQUxTQSAvZGF0
YS9kb3dubG9hZHMvYWxzYS1kcml2ZXItMS4wLjE0cmMxL3BjaS9oZGEvaGRhX2NvZGVjLmM6
MjE5MTogICAgaW5wdXRzOiBtaWM9MHgwLCBmbWljPTB4MCwgbGluZT0weDE5LCBmbGluZT0w
eDAsIGNkPTB4MCwgYXV4PTB4MAo=
--------------020503080505030806030406--

--------------enigC0B36DD8D036AF85980A22F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfW6ePEbgvbl6u4ERAuIKAJ9xG8wxGR+J/uKeRxUFCwI2uOyFLgCfRmpT
6O9E90EE9jJsB49gH8sh0n4=
=PJnN
-----END PGP SIGNATURE-----

--------------enigC0B36DD8D036AF85980A22F8--


--===============1484999379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1484999379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1484999379==--
