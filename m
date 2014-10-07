From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: soc-dapm: fix use after free
Date: Tue, 7 Oct 2014 13:12:53 +0100
Message-ID: <20141007121253.GB4609@sirena.org.uk>
References: <1412682085-5217-1-git-send-email-daniel@zonque.org>
 <1412682085-5217-3-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1036684133384270140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C5AF260473
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:13:15 +0200 (CEST)
In-Reply-To: <1412682085-5217-3-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1036684133384270140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UhXv5VeBZ/Y8lRnC"
Content-Disposition: inline


--UhXv5VeBZ/Y8lRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 01:41:24PM +0200, Daniel Mack wrote:
> Coverity spotted the following possible use-after-free condition in
> dapm_create_or_share_mixmux_kcontrol():

Applied, thanks.

--UhXv5VeBZ/Y8lRnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM9jEAAoJECTWi3JdVIfQWEEH/07/AxmUJqgKpKdQPLd4sl/K
ficdzXmjTPFp1StSxZLUbDPZ66yVSU3me4TJ70EcDvu0O8egLP7r+jImD6NaM2kg
KmGUX2DaAxvYqyb7UsGsMRV4d5ehFWMunw+1/V4L4kOod1USAQvGQMGTrGrwLJ8O
rLUQu9c7xLoEt6jsU73XHOY6wgH/SD6pS3q5SHzHWDppxI/iWFiG7J0ZOeJ20XMp
YqRmQpn4auBRDebNEYMmEw6DX0dCTYGisdhCDhQf9O18e7uG+yj/LsqjEVLeJwdI
COpum2+dhhztd8dW9Vd+YR43xAjZmjUbLUAt8YtksqhJN954sIgqTa3Bvuv6SZY=
=Qvlm
-----END PGP SIGNATURE-----

--UhXv5VeBZ/Y8lRnC--

--===============1036684133384270140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1036684133384270140==--
