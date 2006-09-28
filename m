From: Mike Frysinger <vapier@gentoo.org>
Subject: Re:
 =?iso-8859-6?q?1=2E0=2E13rc3=3A_relocation_error=3A_?=
 =?iso-8859-6?q?mocp=3A_symbol=09snd=5Fpcm=5Fhw=5Fparams=5Fget=5Fchannels?=
 =?iso-8859-6?b?X21pbiAuLg==?=
Date: Thu, 28 Sep 2006 15:52:14 -0400
Message-ID: <200609281552.15643.vapier@gentoo.org>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<200609281459.48140.vapier@gentoo.org>
	<20060928192849.GD2855@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1586728848=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060928192849.GD2855@samweis.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

--===============1586728848==
Content-Type: multipart/signed; boundary="nextPart1482635.bsuFaB9GGE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1482635.bsuFaB9GGE
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

why dont you try building it by hand first and see if you have the same=20
problem

the build looked ok, but i'm still suspicious of the fact you're building o=
ut=20
of tree

another thing you could try is to copy & paste that final link which produc=
es=20
the libasound.so with the Versions file and stick -Wl,-M and review the=20
output ... you should see something like:
 .text	0x000000000004d394    0xb574 pcm/.libs/libpcm.a(pcm.o)
	0x0000000000054f9c	 __snd_pcm_hw_params_get_channels_min
	0x0000000000054fc8	snd_pcm_hw_params_get_channels_min@ALSA_0.9
	0x0000000000054f9c	snd_pcm_hw_params_get_channels_min@@ALSA_0.9.0rc4
there is of course a lot more output; i just snipped a ton

i'd also wager that this symbol isnt your only problem ... in your readelf,=
=20
grep for 0.9.0rc4 and make sure you have a whole bunch of symbols ...
=2Dmike

--nextPart1482635.bsuFaB9GGE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRwn70FjO5/oN/WBAQJXwg//U8PpSL/lV6RerHLoIePuny3/Nbk/4OpP
nH9C4lVxFTDah5y7SDrKKiSigd5MOHcBLRz8CollcdUZz8Xlwc6KARvX7br2WvGK
m8LZnwicXH4Zbr1Ct9VsS9JYDerwpJWANOUXwHzbQAV2QkGj/WArwGEYMRI/t+Y4
a2JbMV/bDbnzFrSuMfMv8JBoGBUB5puza9uDO9DjGB3FvKxWbis5OunDq7k8Jz2m
MXR1fcWiIevxPmsz4yDCYpIt6tPYAVclY8yDsqyU6f9e1E/vTPYzj6ypGU/QDucW
pKg5SxQcvsmLtzGdZl0F778yfrMVXEJaK5VFcAekMAcvf2OhwfLQQtFMo/SQRYM0
Y1PYLrka49mPOF9VmmMVR5nuIGxLSSpOr5G7qv1+svg7xKwvHZIQr0F6z1BneY5U
UUe8JNTJ79KqJDzo2UCRHr4NJkotED/shcVARyPE4taEvCIVYa+V7eD+7q09+Vvm
ByqFOYIGo3VQtzsX60N/N8+tqV53P1JBZBlDExmX2pNGmoGK0KnRZbgymKKDhkhc
gZDKwUMC7/qWxNAonzgO0r1TO5rncO7X2JNc0mf0NHCPd18KAtmvq9V/KiAksoxT
JflVEBU2VTKWDAp9xJ/rtzEAfi9fBGxfz48KoscITVpH6VKMmOv5VQG6uAE5WroA
FTasGV6vKwQ=
=502V
-----END PGP SIGNATURE-----

--nextPart1482635.bsuFaB9GGE--


--===============1586728848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1586728848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1586728848==--
