From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Date: Mon, 3 Sep 2018 12:30:38 +0100
Message-ID: <20180903113038.GG10302@sirena.org.uk>
References: <20180831181737.29516-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831181737.29516-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
> The notification handler sets the reset line but never re-enables it
> as no one is listening for an enable event, this is certainly broken
> and was most likely just copied from other CODECs, remove this code.

Why not fix it?  The usual pattern would be to take the CODEC out of
reset when bringing the bias back to standby.

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNG10ACgkQJNaLcl1U
h9CxQAf/eZmq7ergT3Yp4xEktCTGm+7YASMCJsBlRbOdZSU1p3GJZnc4Okd5l5uI
KQHpzPS5HxdRYSwgHyA40fsMKw52xn7hDfIdzDU5cAw1VNabtMvb7y0eNcYlRRlI
MAY8trQ99JS5Ztho+D3sV3I+ciu+DNP0nZIQligedUDYVmHrSh/2flGHQRGZOAZL
NLr3Vwa5eIsmqBA6YzuZhlhiBrSIHDWpYyoovON6b4OYBgEW3+KeJP9HUwHOXbqt
BKxxD/5+k5oLi2yW9nSocxMQt105P70GTqYDC2ZayRckVTB/85erZi5xfSY6OlBJ
pnzgTxZU3OV2qf/hEUdOm2g37A+zMg==
=fMUk
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
