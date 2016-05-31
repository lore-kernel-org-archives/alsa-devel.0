From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tas571x: add input channel mixer for
	TAS5717/19
Date: Tue, 31 May 2016 17:52:13 +0100
Message-ID: <20160531165213.GG29837@sirena.org.uk>
References: <1464037967-24671-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0680451003810561864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67D5A2655DB
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 18:52:23 +0200 (CEST)
In-Reply-To: <1464037967-24671-1-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0680451003810561864==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u/esRqyc5dLeU/8t"
Content-Disposition: inline


--u/esRqyc5dLeU/8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 11:12:47PM +0200, Petr Kulhavy wrote:
> Add channel 1 and 2 input mixer registers and the related ALSA mixer
> controls for TAS5717/19 chips.
>=20
> The mixer control coefficients on the chip are linear in the range
> -3.99999 to +3.99999, encoded in 3.23 number format.
> In this patch the mixer controls are limited to 128 values
> from 0.0 to 1.0 in 1/64 steps.

This doesn't apply against current code, please check and resend.

--u/esRqyc5dLeU/8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTcE6AAoJECTWi3JdVIfQ+wYH/ick755LZOIXLvs4XxmhIzce
UsBta2G6l66/fkb7wYMbg19U+8N//DeLFz/RLqlnhn2BO9xwYfb5PLMbavYtmrce
4uQrhY2OoEPjpUzJf3AK9ZxO3c27ZRhlMcf/OVeAAShUS9Jb7HikhrvZD4TXg2gn
6B/SDeGUBsE4N6JvY1cUWVUB5pdeeeOigBxDOIsrnyvsUTi9ZXxDhWhSsrS2OeZN
pHZ2JupCyT9eODtQVURLHraL5BZhuLp/uVOpJAZZwDYh9AXRvEwoY9KFB/j0NAE/
RdPNG7CtqgTVMX9NoGDTG5tpca9bqQucLazjQ/LRZ5oKxeWr7XUxhan1zmn5n+o=
=0m9w
-----END PGP SIGNATURE-----

--u/esRqyc5dLeU/8t--

--===============0680451003810561864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0680451003810561864==--
