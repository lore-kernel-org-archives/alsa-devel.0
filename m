From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8731: init mutex in i2c init path
Date: Tue, 27 Jan 2015 18:21:58 +0000
Message-ID: <20150127182158.GE21293@sirena.org.uk>
References: <1421652223-721475-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7243964180009147312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1421652223-721475-1-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7243964180009147312==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wG6oWOmweUVxAUPD"
Content-Disposition: inline


--wG6oWOmweUVxAUPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2015 at 08:23:43AM +0100, Manuel Lauss wrote:
> The I2C init path forgot to init the mutex, leading to an oops when
> controls are accessed.

Applied, thanks.  Please remember to CC maintainers on patches,
including driver maintainers as well as subsystem maintainers.

--wG6oWOmweUVxAUPD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx9dFAAoJECTWi3JdVIfQ818H/1UoP3FZvq8rK+Wzg5DpYC7u
LgRFa+QfYao09MhcPQ3Knjg902Ao3LNrPtw7JF8fl66c1mdPmhJLRmUVmHwIabWM
pKpEztE8qUDJuQxXzMfiKO/j2E3qsAaP4iSiKbib8hyn87UEx5JDUvlP+kaMrFlL
OBtwQA14qbE/526r2qDkMaDZjzVJWnIzIsvWeCl0BSAw9ZdfpH53WALxd5AtF93x
IgWhcky9uArsf/xyFMfP3eDDFrY0GlmsPFdCqJmEUV0mXPDYkXid83KFzqzKKuD1
VGKaMrWJ2sALFkyIhXeS5/34OGKe49/2KdZoeQJ/t3unn5fXhZCiLyb5cj4FsvE=
=h0sn
-----END PGP SIGNATURE-----

--wG6oWOmweUVxAUPD--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============7243964180009147312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7243964180009147312==--
