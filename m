From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Mon, 21 Aug 2017 12:00:51 +0100
Message-ID: <20170821110051.nn2wfijkb4tlzm26@sirena.org.uk>
References: <1503124744-13547-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1820079568874566846=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C4EA1266B48
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 13:00:54 +0200 (CEST)
In-Reply-To: <1503124744-13547-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yesanishhere@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1820079568874566846==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k47vlyd6l36idnoc"
Content-Disposition: inline


--k47vlyd6l36idnoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 11:39:04PM -0700, yesanishhere@gmail.com wrote:
> From: anish kumar <yesanishhere@gmail.com>
>=20
> When num_params is defined as one in case of
> codec to codec dai link, there is no point in
> allocating memory for kcontrol.
>=20
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  include/sound/soc-dapm.h |   1 -
>  sound/soc/soc-dapm.c     | 147 ++++++++++++++++++++++++-----------------=
------

This is a very big change and that commit log doesn't describe it in any
detail or really motivate it.  What exactly does this do and why?

--k47vlyd6l36idnoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmavV8ACgkQJNaLcl1U
h9BnQgf9Eg5GjP1PwBfbk6WM9zWMKuk2sc16DiZGULShAw7Ty0z3OgH86m27Kday
203emTDzMiezRzKtsi4HDCqkK7BuvrMcDDBOwfSytbev9CyVCQ218wq5J9sg1dVw
yU3GpEzeu6Xf2rv8mtxmJcHPria0vBszXyjrlVG7ohGrR78eENxBNvRgHivioIzf
7HTUxD6WjCzU4VQcOMwvm6BJY3nkiwavzNjeA64SgJ5WT2+XOuJWzmPAcl+3eFzc
2pn/2gESb1wZuwKgSLd7WpeYWXOzZ64mKngTv4vRCX1b3FG/HreiryAGU9kt9vds
VeBN4NQVUxuYw8Us+0duFTi/wG0lVQ==
=nyYX
-----END PGP SIGNATURE-----

--k47vlyd6l36idnoc--

--===============1820079568874566846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1820079568874566846==--
