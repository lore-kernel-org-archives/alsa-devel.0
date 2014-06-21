From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: fix dpcm_path_put in dpcm
	runtime update
Date: Sat, 21 Jun 2014 11:30:13 +0100
Message-ID: <20140621103013.GR5099@sirena.org.uk>
References: <1401882126-26225-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4914703216602876672=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B208265141
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:30:23 +0200 (CEST)
In-Reply-To: <1401882126-26225-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4914703216602876672==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hUTgNrncnQ/xgPMs"
Content-Disposition: inline


--hUTgNrncnQ/xgPMs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2014 at 07:42:06PM +0800, Qiao Zhou wrote:
> we need to release dapm widget list after dpcm_path_get in
> soc_dpcm_runtime_update. otherwise, there will be potential memory
> leak. add dpcm_path_put to fix it.

Applied, thanks.

--hUTgNrncnQ/xgPMs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpV6yAAoJELSic+t+oim9kwIP/16fst7HAuF85ANLojSFDhou
fX0e8/Yxr++seNkqRPwcQSZqDOjMEiVrGx+wA3pBjHTHBmv9iXhDo/nPozvuLrgU
Z3qXEmH4IDiXD8b+lrBG7U+PPiS0A9rA4oZTgVTbZGzVdqFV2xNP0swjbq2lpeIA
A750lN91BOwWHv5XfKr1u7ckBqE6MWC0BLEvgXO7nls+X3ZT9MK798jnzo6IPdOg
akcEFsJ6f8LmQ7shxhDkQxPdy/w4sF78/oOr8MMMrrTsKhwFUYh/bYKwtRNkDFXP
hr6i1evZvwLLXZAL4U6PjMkICbx++/yE0nrSXR0zx8ikuqlmOr1WjVuzlPN10Fzb
PKta/2HqwyTvC3z47eK0Lt7pwDx0I8H0gGlfBMhHvsqMvfXZ4clr8Tnv7rt8Z6Y+
ZxwT+dTynjdIvFq5YoN9xrhh9T+z23ZeT7nkHDpvo/59CfK56TUl4wiW3rvmZy//
ixL1kv4MZQwr+mAI3LJIJWdUR8Xt0YqfVPgHd9f/T8RADyhFr6msXW5AnpZWWjSK
/xuKeUFNeUA+iWqI+/97KvUs4FZQNAX+rbOfFeJ3Xeh1H79pXxaHEVpXFlHsqYnr
5LrkUnm4Y4sB7TBsVj8zbLt45MFtYZiz1LbXrSxdjmwYkqyrvsL2FNuOvFoQfEkZ
gN6Jh5PaKNLt6VNSF2DE
=KRSm
-----END PGP SIGNATURE-----

--hUTgNrncnQ/xgPMs--

--===============4914703216602876672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4914703216602876672==--
