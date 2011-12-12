From: Reilly Grant <reillyeon@qotw.net>
Subject: Re: [PATCH] plug: Move fast_ops copy after slave
	configuration.
Date: Mon, 12 Dec 2011 09:00:09 -0800
Message-ID: <4EE63319.7030708@qotw.net>
References: <4EE507BC.7050603@qotw.net>
	<CAN8cciZ3Z7OJm5SdGZ3oR_MbpZ45-UYyrAz_vkdL9yaZQmuteg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4327135904818988130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jane.qotw.net (jane.qotw.net [72.14.183.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A83E245C9
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 18:00:32 +0100 (CET)
In-Reply-To: <CAN8cciZ3Z7OJm5SdGZ3oR_MbpZ45-UYyrAz_vkdL9yaZQmuteg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4327135904818988130==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig075967AF38ADE9CD5925D3D7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig075967AF38ADE9CD5925D3D7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Some applications do it anyways. I assume because not all drivers
include plug in their default device. Whether or not they are wrong the
library shouldn't crash because of it, especially since they could be
passing this configuration through from user input.

~ Reilly

On 12/11/2011 04:18 PM, Raymond Yau wrote:
> 2011/12/12 Reilly Grant <reillyeon@qotw.net>:
>=20
>>
>> This fixes a crash when two instances of plug are instantiated back to=

>> back and the format conversion plugin inserted by the second is skippe=
d
>> by the first because the fast_ops pointer is not properly updated. Thi=
s
>> is the case for applications requesting plug:default on Intel HDA chip=
s.
>=20
> The card 's "default" device of snd-hda-intel should be "plug:dmix"
>=20
> you don't need to use "plug:default"
>=20
> http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob_plain;f=3Dsrc/co=
nf/cards/HDA-Intel.conf
>=20
>=20
> # default with dmix+softvol & dsnoop
> HDA-Intel.pcm.default {
> 	@args [ CARD ]
> 	@args.CARD {
> 		type string
> 	}
> 	type asym
> 	playback.pcm {
> 		type plug
> 		slave.pcm {
> 			type softvol
> 			slave.pcm {
> 				@func concat
> 				strings [ "dmix:" $CARD ]
> 			}
> 			control {
> 				name "PCM Playback Volume"
> 				card $CARD
> 			}
> 		}
> 	}
> 	capture.pcm {
> 		type plug
> 		slave.pcm {
> 			type softvol
> 			slave.pcm {
> 				@func concat
> 				strings [ "dsnoop:" $CARD ]
> 			}
> 			control {
> 				name "Digital Capture Volume"
> 				card $CARD
> 			}
> 			min_dB -30.0
> 			max_dB 30.0
> 			resolution 121
> 		}
> 		# to avoid possible phase inversions with digital mics
> 		route_policy copy
> 	}
> 	hint.device 0
> }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--------------enig075967AF38ADE9CD5925D3D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJO5jMrAAoJEOXiGGAVSFKDeV8P/jMyGbUI43u7JCFIaVA35YAC
jzxxkihD58i14UL5/fnEm3V3uHJd2ICkGkDoOWMfBre2QSIIec0H23zayA3rA431
49OLEYar8fICHSICfqTGLVjR+l2ae8RReJT93ZRBqT5o7yjc6s5rIcbUFmNjVYD1
cEgxxoCoCUFyybV941E0QqxIqaJ+0oGjM8i6E6tFOqm5v0kj6zKGTcw7c5J27B6O
WPRAFZ2PpIAFoFa0x1ZJt/s4JVSxVugtPInyRUc1se2wSg0vwIj2cQuE3fRw8ONZ
XWQ/imKoTLWh45KK5DnnpZ6rPqvELvYXrwCrtvswxuEB1Gxy9TzeZnDfqtXWWMFb
OWtWAjkMiAm+PtZYuvv99keH9icVUnu9A5Xujixerk3fx7FPAHbifX5y7iy1o3pC
/eO2JhQwx2abxclUYb5fFldxTr+Jy7ydR/9rcar3FKyAEJhnmQovG4RcpqRPhj6u
vZmbJuUTQvtUImhHLPkqfig4/EYTBXdLrRXnix2+OWP5v1GbBtwcY4RRYbKd84lI
o8TMW91i4kAhrf/GPw9oWi3poQlYZyjrK3XzZtm0M8oSZeTNnxX62pUmF81brANj
NW+GbLSWDykhzm232z9LzUkIly4wTM5VJlZ6S/7LGRG54GP9sBSoLixUlVFgx1iI
tjsjmCZ4BdTrX3LFtuO7
=sxCt
-----END PGP SIGNATURE-----

--------------enig075967AF38ADE9CD5925D3D7--

--===============4327135904818988130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4327135904818988130==--
