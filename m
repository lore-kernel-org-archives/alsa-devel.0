From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5-resend 6/7] ASoC: sirf: Add usp driver
 which is used by dsp mode
Date: Fri, 7 Mar 2014 14:15:00 +0800
Message-ID: <20140307061500.GH13126@sirena.org.uk>
References: <1394008480-29135-1-git-send-email-rongjun.ying@csr.com>
 <1394008480-29135-7-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7699693044405827609=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D63265949
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 07:19:39 +0100 (CET)
In-Reply-To: <1394008480-29135-7-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============7699693044405827609==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EmKSbXfTaEg7BAFB"
Content-Disposition: inline


--EmKSbXfTaEg7BAFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2014 at 04:34:39PM +0800, RongJun Ying wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
>=20
> This patch adds ASoC support for SiRF SoCs USP(DSP mode) modules.
> Features include:
> 1. Only 1 channel support.
> 2. Support both master and slave mode.

This looks good but depends on the previous changes in the Makefile and
Kconfig.

--EmKSbXfTaEg7BAFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGWPhAAoJELSic+t+oim9wcoP/RKJbQKksQiUuZNFEqB79Wqf
8zYZUH6wlmUCTHHiVutoIC53pWTYg5z6TP/KW6DKtdQjV9yua5d4k81SRW5D6j1O
mIE9byi2LY8ELL9dEaloUwIQLD9hZg+ySY4xFkUEOjUlKh8SzfHGzsNiOboPsnIE
e/BX7iXWn/eTFaFDhw9DvuIUuBKH6MXaWky/NKmVfRFGGxC+5fGg3quAHgoWIdsf
e4ig+e01I0gDCHvfCnS3PsBbmWynDlslbkEsHRw7v8SwQ0SOr/g7UQspcuOmIqfz
3fwoKWet4lRLIe+cGei2HqRQqAAnhmnw1Zvvd9mT9HXM/75JQQg9PGwWYtzLqcr+
G0MMONW7p/JoPqcx4mEOkJf/s81vTo17yJ48chL8jjhU7sTdaaFuxfFsaOi2vFpf
FSrNRgXSfoZJajFJxejH7rs7QDZaOd82wgCxa+3/QjZxc0TCFuYSAhNdF/EJm7pi
nfokovllUQhCM2NkM8J0de2wrD9CeLqn4c25CnvMe60EK3jfnXZ+AnnUpTLDjgEt
EoShJ2zfQy/roE0fhFVkat/CEzRu3Rp1wscTrx9MrX69cqKMotrgKySOiHsWlZ3t
VyBB8i5+7HXZ76/aYn0Mk1Ac6LgsOXjvnRBkDG4GhTSTpYTWmrhJ6geVB4PXfsnB
xcp4Nu01BDGITbcdVIoP
=U3Yi
-----END PGP SIGNATURE-----

--EmKSbXfTaEg7BAFB--

--===============7699693044405827609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7699693044405827609==--
