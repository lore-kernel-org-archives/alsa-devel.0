From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] ASoC: tas571x: fix of several
	issues for TAS5717
Date: Thu, 6 Oct 2016 13:08:25 +0200
Message-ID: <20161006110825.cn2jrt5raqmw5s3w@sirena.org.uk>
References: <1475675467-5575-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2403891764480405977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BACC62657DF
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 13:08:41 +0200 (CEST)
In-Reply-To: <1475675467-5575-1-git-send-email-brain@jikos.cz>
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


--===============2403891764480405977==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hs2dmkegtp5mlxw5"
Content-Disposition: inline


--hs2dmkegtp5mlxw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2016 at 03:51:03PM +0200, Petr Kulhavy wrote:
> An extensive usage of the TAS571x driver with the TAS5717 chip revealed s=
everal
> issues which in the first place caused audio to fail to play. This set of
> one-line and trivial patches fixes them.=20

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--hs2dmkegtp5mlxw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9jCoAAoJECTWi3JdVIfQwCgH/3Iubue467snTT2XUZXqEgcL
89r1XFT61U8iR3m2OjTnarAxk3XJBfuPdSFgCTtERxyJ1fAfFqssjPJno95vSt1Z
+az44fzEQCEk6QRSDSZFTVyvNzD59sEME55G6HcJEib/RUYtHGk975UC1csdifLI
I6e+XIBMisvZ5XvSyEvPR5i1gdrm+t1nvD96wqpLbKrPG107orFwanPr5ZG072PF
191S7uWaOX7M0bh8t4glhP0XzFPphvfRZ0xY9XZuDZAEEVWCQhUTf3yM8SxCHkh1
O+4oqBZsjXHWj4goTDTeIR3SkOHKarlNN27bYP3J3+FEpyLF7M/YUm0Z7NaLABg=
=DWwC
-----END PGP SIGNATURE-----

--hs2dmkegtp5mlxw5--

--===============2403891764480405977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2403891764480405977==--
