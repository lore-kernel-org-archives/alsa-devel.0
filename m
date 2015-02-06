From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
Subject: davinci-mcasp: extension to use AHCLKX pin as external
	clock source
Date: Fri, 06 Feb 2015 10:22:06 +0100
Message-ID: <54D487BE.2060209@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7176872960634597481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bytesatwork.ch (bytesatwork.ch [91.135.72.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A278F260590
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 10:22:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: urs.fassler@bytesatwork.ch, alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7176872960634597481==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AT8wU9xhF8puldXupBQrnda6swbaUJPP6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AT8wU9xhF8puldXupBQrnda6swbaUJPP6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The AHCLKX pin seems not to be supported as external source. The first
patch is a general fix to allow external clock. The second allows you to
select the AHCLKX pin as clock source.

Patch built against v3.19-rc7


--AT8wU9xhF8puldXupBQrnda6swbaUJPP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1Ie+AAoJEKKADLnESIBj4y8P/2Q5jZ8353VRURcakJECXpLR
gWR98MIMokosFexOrFF13eFizOhT/rW2NsBaYPJEK1Jw1qTqg/i4zhKaPaAG59mH
67IJxF/wpD6a9gTg+zThrNkad/rErlcE9wRZ2XEARhcXYKsI+Q8R1cSLihQVj4sj
XpcjaL57PdPryYYbiAzbW46iN/50bj2Iir5GW9kHX9dnz267JDSIYDqT3CYFz8gx
xFDHaOnTiZrEeJPGskvCnyeeK4l+f2AOCSiCjPFJHouiQTuW+YwIr1CsMmnhbz4g
8cjkQT5MnnHQSbt9ayvBUWIFNCsVmOqZhlfqse+SAqbWHUxl9llCLCSLzzFopchR
fi7fVyjY+MLYmKUOSKxGTMuYqklIV6JV38M71G2ohzM4kia9oMH5j9J5m7sAHqb/
l1SPDVejZqtOUqi8KKAAmDQWzy6ky5a6+7SSl7SX2fcvCwpjL5PovhEdc0bJLWUr
5i+b7A6/KgLFvYt5Q1+5TrXpYO/3Squp3UA+WQeBXfF9RwARHZa4AGn1khhZLsMk
5kdjsL9K8ajxRlZSih2UfAd31cVlSBQERCfMIdOhSMjiH9UQLH0sCOnP1vy2dWnd
/c32wJKchGBllw+kOLi+fjjEv+VyPhdP08rHO2/5NvdVn4Ss3NKN3obVXjA9qTWq
x4/n0Vt6wiA0eX5jmjNP
=T4Dk
-----END PGP SIGNATURE-----

--AT8wU9xhF8puldXupBQrnda6swbaUJPP6--

--===============7176872960634597481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7176872960634597481==--
