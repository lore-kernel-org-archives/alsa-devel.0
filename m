From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: set idle_bias_off=1 for all platform
	DAPM contexts
Date: Thu, 5 Apr 2012 21:57:09 +0100
Message-ID: <20120405205708.GQ3129@opensource.wolfsonmicro.com>
References: <1333650481-19469-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1097396970677417030=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A83A62439F
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 22:57:13 +0200 (CEST)
In-Reply-To: <1333650481-19469-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1097396970677417030==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 12:28:01PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The ASoC core currently defaults to using STANDBY rather than OFF for
> idle ASoC platform devices, which causes a permanent pm_runtime_get() on
> them. This keeps the device active unnecessarily. This can be especially
> problematic when the ASoC platform device and DAI device are the same
> device.

Applied, thanks (for 3.4 as it looks like a bug fix to me).

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfgceAAoJEBus8iNuMP3dLUIQAIwrb5XvBsynm9M9NOV93sVh
PWTLqop/heiQrHVrQCYqHK6Kc84ZZfdb5uN0piUUEbrwwf/3d/k6wkFBIu6bAusi
68paNtwFbLE0LCX33WTE0WLXNlUMTr8SrK93T6W2WIwbqNB8hbnA+MYW2I6qJ14P
PYKR4LRCYHm1VxWq47Wbxt9RgiqORqqKMnZ/NMqRQ/mQ/kBsyl4zYLjO0Rlo7aUf
31SyvxclI8MxhSIr41JvOoz/iQQYJijWsfh9Ih4M/dmPP+yhMPBEKLo9WE7UwYdN
1Aobr0kPe12bktUY8HkGpCWBiifGV9aO2E1OvZnCDJD+DG4odKcB4HDt6ARDclmf
WapoB7ZymFiVvzBL7KDXguSpRC5tGWhfCPU3AA0tgw9gJsrnSxI4SKNxrm68iAHm
DRqkqmbOCqThEAqRLoEJtN0pgKKlTmduqP5F9Rx0mT/frIEpMEaEenITOgFWn6tB
y+2KV065dhshQnuMvcZPy4P4pSyJrKyF1HkIV4iEVg77ewFVQQ33WRWa+XQjr0mP
InvBpdOj4JBuX3AW4ra39a3klDAI0t7tOyKdGjL5zmWNpIrS6/hj5oFfYr3Fu1jj
2YQMsBThRh99ORddkxfJCS4d7bN8636LHuWgxQ1x2NpWYTaE+YQjqGuFEJk4/r39
xRMZTpcYNkTctRWR/Hpu
=kw5V
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--

--===============1097396970677417030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1097396970677417030==--
