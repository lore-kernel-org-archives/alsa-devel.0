From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sta32x: fix register range in regmap.
Date: Sat, 21 Feb 2015 18:51:50 +0900
Message-ID: <20150221095150.GO6236@finisterre.sirena.org.uk>
References: <1424015616-31309-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3718788477315334517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B70CF260638
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 10:52:56 +0100 (CET)
In-Reply-To: <1424015616-31309-1-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, brandau@gmx.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3718788477315334517==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2015 at 04:53:36PM +0100, Thomas Niederpr=FCm wrote:
> The STA32X_AUTO3 is a writable register that currently does not appear
> in the regmap ranges(neither read nor write). By adding this register
> to the register ranges there is no gap anymore and the existing
> register ranges can be joined. This fixes a regression that made it
> impossible to choose the preset EQ mode set through the STA32X_AUTO3
> register.

This doesn't seem to apply to current code, can you please check and
resend?  It would also be good to say why the regression that's being
fixed happens.

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6FU1AAoJECTWi3JdVIfQm/4H/Ra9Y9Mpom4OfVcUngTbUTeb
OMfoa2X338lnWU19tRvj3wrXmiX96Oo3rD8V/Syv8Ia4VBoC5WZ6aJ1mBTH7zRft
eMp9d2yySVa3Hw4n+sHLNXq91+DF0twXtzn354OZmwIWRnX3Q8oy301I3q6e8WoB
9TxzivvqYInRmR13xewtgC5iSaqIc4zOPOXI4/7gng8/WbHIQU8sH9QGonfnl7/T
Al0pULSMSMuH58JypwPOSe4oCOJXM0f0qJwIuq5gyNfBw38oTmoxWd9vKHTCjEEe
/qrr8n7T0x2KXUKGl2Lc/yMza8qkzh9LB1EFcGhpQSdr2kykIDm7SDPBUMZ+7YM=
=FWhu
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--

--===============3718788477315334517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3718788477315334517==--
