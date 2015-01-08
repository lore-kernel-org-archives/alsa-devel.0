From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix irq error check
Date: Thu, 8 Jan 2015 18:17:47 +0000
Message-ID: <20150108181747.GT2634@sirena.org.uk>
References: <1420667140-32744-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7267839913752098476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44633260498
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:17:59 +0100 (CET)
In-Reply-To: <1420667140-32744-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7267839913752098476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Xj16OFyOZKNHwhf"
Content-Disposition: inline


--9Xj16OFyOZKNHwhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 07:45:40PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Commit 2ffa531078037a0 ("ASoC: fsl_ssi: Fix module unbound") changed the =
way to=20
> retrieve the irq number from irq_of_parse_and_map() to platform_get_irq()=
, but
> missed to updated the irq error check accordingly.

Applied, thanks.

--9Xj16OFyOZKNHwhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrsnKAAoJECTWi3JdVIfQty8H/RPStKaZx/B+Dal+Y4w2kxVc
ZxC38u9FO8hxnllVN8kLWkJlHgJTznkEquYxivllextjUdjbV2HWJRKcjOtSMKNG
EgR9I9wyJ4GFSMFn+vmvpYMZ1zBGCkv2M/sbhQGm8t4ZZczeR9aqHatzR2teK34N
lbf5nnaFTunvvSiJJRk09ipcvktwRLJfzy7yYbVAon7OcoXa4rdNgrvtB9AxNp+U
mFvfvRivejYaFvxkVMr30VD0oiHzlsdYT72Ph+YYPX/Nz8zhVlWx2DLs7NbG+UYv
gYsHRvToLSZF31mYvVREWlvmW2np4WFlm98GpXp8Vs6oovvTPkMUGLpS7jyKNSg=
=A9hI
-----END PGP SIGNATURE-----

--9Xj16OFyOZKNHwhf--

--===============7267839913752098476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7267839913752098476==--
