From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sta32x: fix register range in
	regmap.
Date: Tue, 24 Feb 2015 17:46:14 +0900
Message-ID: <20150224084614.GB6236@finisterre.sirena.org.uk>
References: <1424535758-5140-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1217957122305174812=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3663260509
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 09:47:26 +0100 (CET)
In-Reply-To: <1424535758-5140-1-git-send-email-niederp@physik.uni-kl.de>
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


--===============1217957122305174812==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UXdImcDs+Jp8Skh3"
Content-Disposition: inline


--UXdImcDs+Jp8Skh3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2015 at 05:22:38PM +0100, Thomas Niederpr=FCm wrote:

> register ranges can be joined. This fixes a regression introduced in
> commit a1be4cead9b9504aa6fc93b624975601cec8c188 where the driver was

> changes since v1:
> 	- updated to apply to linux-next.
> 	- added commit id that introduced the regression in the
> 	  commit message.

Applied, but when referencing commits please remember to always include
a human readable description of the commit so people can understand the
commit message and if it's a fix use the Fixes: tag.  It's also better
to abbreviate the commit ID to twelve characters, it's much more
manageable.

--UXdImcDs+Jp8Skh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7DpVAAoJECTWi3JdVIfQqqAH/RwO3CdfR6e7WL5cGQscRmZt
T/JZ6RdPur1wWK+VaNfRo4gBzZ64nywoU+oCbOOAKIdrNzV4j1+IPBSHDtQY6TLq
/mYVhiPSguXRY6xvJBKuILEf9FqSAit4e7EdNKF9ewGAwUO1txtIKLY0paqp2XTF
cYVTAHhBkaYNgPXEbCH3CWQ756YwWUCvMh3W1W5fg/BfhTxfcMYEutsuFNOyxavx
8oiZiOcVXHZ/HTSbtM4YW3Gl3svnQuC1TH/fy+9r6qA56avcu1gd2TJPn/ajfBSi
7PtMte4zjjoxnSreSSyuDuXAUgCN9+QE0TM5Z4OjFMFE10/LOOom9vGNSZC1zBI=
=l8+O
-----END PGP SIGNATURE-----

--UXdImcDs+Jp8Skh3--

--===============1217957122305174812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1217957122305174812==--
