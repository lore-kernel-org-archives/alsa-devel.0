From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Logic low for
	inactive output slots
Date: Mon, 8 Jun 2015 18:51:34 +0100
Message-ID: <20150608175134.GM14071@sirena.org.uk>
References: <1433768627-30041-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8009605370861305453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B26260693
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 19:51:42 +0200 (CEST)
In-Reply-To: <1433768627-30041-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, misael.lopez@ti.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8009605370861305453==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z5Jh1Kjtcc8el5NM"
Content-Disposition: inline


--z5Jh1Kjtcc8el5NM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2015 at 04:03:47PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> The default state when serializers are in inactive slots is Hi-Z.
> In some cases, there are no additional components driving the data
> lines to a safe state so they might have noise.

Applied, thanks.

--z5Jh1Kjtcc8el5NM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddYlAAoJECTWi3JdVIfQkRsH/j4U3cG5uDRg/eSJTR8JxMUm
wc+GZpFv+0tPFJiNWPXoLWusqLbK5sEI3l7NLnMLaTrfN/kiEzYXfy+Oi5S6/IcY
Kd6ummkVnaYEXQpTcrc/q5YiAwDgnhuo1zpUb7KPKhkAy0PO5LqUM7sZEIvZgHMa
/VoVrmXCyIJXFuTNC/xMLIcsjkB4u5gVDoxrVU6mgWmZYL3OvsdYUaiGhKVNIa84
jTZN6vAikUL44V1C+t9IlrGCHajb/v/j9IU0yG9eTgikfHVyuR8r460JRy2YCedF
xgRuTBB1zjftZGbymf1aR//ZL9vV+66FVnPGeNXHtlvlh+JaFKlXk3MnCOonuhY=
=VD+C
-----END PGP SIGNATURE-----

--z5Jh1Kjtcc8el5NM--

--===============8009605370861305453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8009605370861305453==--
