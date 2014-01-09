From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: wm_adsp: Fix sparse non static
	symbol warning
Date: Thu, 9 Jan 2014 15:31:58 +0000
Message-ID: <20140109153158.GB12858@sirena.org.uk>
References: <CAPgLHd_bNPEJmkjtmbeDrtmVMo5G7ELNCuyKuwT7Qa=weqh8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8398235956070401691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B15B2652BE
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 16:32:24 +0100 (CET)
In-Reply-To: <CAPgLHd_bNPEJmkjtmbeDrtmVMo5G7ELNCuyKuwT7Qa=weqh8kA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, yongjun_wei@trendmicro.com.cn, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8398235956070401691==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 10:22:35PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fixes the following sparse warning:
>=20
> sound/soc/codecs/wm_adsp.c:1500:6: warning:
>  symbol 'wm_adsp2_boot_work' was not declared. Should it be static?

This was already fixed.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzsDqAAoJELSic+t+oim9exgP/iQ9Xe9j1HP4xJpmEeLXzoJF
23gwcNlIwQjvnPYzYy5RJDvcp9/Q3tw+qtjDCAD5XG+/MY63GgJTdD4uivLd8i9g
uGhjdi8IuJcZ/nijx0WRLZNQctgCXMDM5CSBV8gFh3x7MblrFLUv8b/0DZshyCan
9tRh0IB2HgOsXPNOmA4kUnwICyk4++tC/TpauDMArH9CW0knifG5QxKxOiEIuORi
MRtZQyV9Xf4Jar2ZEdD1Zje4KlV52GzHRyf0hUVfaZjX2pPi1jYRB41HgmeZ3f+3
wQGDqoYdRJLyLocXhifLByDL4+hV3wbrix6ggExs/SZmetqEz6ORZHzbFWg2cTMs
K4nIjar8E3/LUHi5XiD3ssrsE90VoNRfxqfPjmab2zTPYzOGDpAtJxe/kj8SmcNn
R5eaDczoDHZggSvPOtTBQvN/bPToyg88oA1EqkKxpMpt4Dy8cnt+0iBiqEE3KzmT
3ULOEcQug4i8r/BShvCkPsOU1WwIkK9zIlDBGDQju9bk6NyZgOv2VmR3gGt4iPIR
Yml8bcgPI81EHVHFzcgUUJr5uXDevwmhCPIH3F33nJN3sUjMuBXI3okFWdsdYm20
f1O9vjy+u9/2GayWHGRFNa5RVaXv43u4LwXYKlJMEZ5HkM7gQYzY8vbIYOhA75fr
drV9pmHP+G2MwuDE/swf
=6Bfz
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============8398235956070401691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8398235956070401691==--
