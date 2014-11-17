From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: adau17x1: Replace w->codec with
 snd_soc_dapm_to_codec(w->dapm)
Date: Mon, 17 Nov 2014 10:28:03 +0000
Message-ID: <20141117102803.GS2722@sirena.org.uk>
References: <1416213456-5987-1-git-send-email-lars@metafoo.de>
 <1416213456-5987-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0343229908120121948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8292D2615F3
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 11:28:37 +0100 (CET)
In-Reply-To: <1416213456-5987-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0343229908120121948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xUq7mlTLx96rFlBf"
Content-Disposition: inline


--xUq7mlTLx96rFlBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 09:37:36AM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--xUq7mlTLx96rFlBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUac2yAAoJECTWi3JdVIfQ7owH/ArvoL7IwoW3/WjOV7cSDEw9
ELSDZwiSREHM7zyCkBUUbDidDQ9wi4GoYVl2aYyG/7La0dCYsiG/5LLgfE6DpzTf
8YeInHyZuIXDMbOyS/nKpsaT+ubs3yuYFVB01aJlfVrsnBl27L9ymTKw9U7J+/2g
l4u2Nd/XtINIxsTAcjV6wMAo624hPy4+RC+tbmJJB4OB1tQtJtNFl/CS6VcaBb06
u9pOExfyYdxNzAlKSVi2U+4mUbAodfr1o8utOOKgurGSMEG8Btm3crtA0aUd3AvZ
NhmmPHB2NxRU1OfqtlwIJrpnliFOLyIVwUzEirk8eBCcIm9ZZKx0i9zMMUc5oR8=
=fUjK
-----END PGP SIGNATURE-----

--xUq7mlTLx96rFlBf--

--===============0343229908120121948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0343229908120121948==--
