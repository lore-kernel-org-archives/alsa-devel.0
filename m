From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/29] ASoC: Intel: skl-pcm: disable
	skl_get_time_info
Date: Mon, 5 Aug 2019 16:45:12 +0100
Message-ID: <20190805154512.GJ6432@sirena.org.uk>
References: <87pnlx5rq3.wl-kuninori.morimoto.gx@renesas.com>
 <87o91h5rp5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0065193283058204460=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 160FEF800F4
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 17:45:14 +0200 (CEST)
In-Reply-To: <87o91h5rp5.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0065193283058204460==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2019 at 01:49:17PM +0900, Kuninori Morimoto wrote:

> Now, ALSA SoC doesn't setup rtd->ops.get_time_info.
> This means it never used in ALSA SoC even if
> sound driver had .get_time_info.

> This patch disable .get_time_info from skl-pcm.c.
> Because we might be going to support it in the future,
> it uses #if 0.

The #if 0 here isn't exactly nice...  it'd be better to just implement
get_time_info().

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1ITwcACgkQJNaLcl1U
h9BXowf/bZLOdC/nKV4j4ogYg8CtnKH17xq3ayjIbuQdZaiQqgOQclny98lqks9V
MNfeq0PELaDGxNoVOP/15/G5+omwbn08vWPAm/NZ1F9E+LcWGW6zv01Gn6B09pHo
eqCIRqOHgnGJ3z+/ynA6sIS9p9qjZITk53ggemhH+SRLxp/76aZoippNXOcSINXB
+fmJp4iT+c+Rij/1KFv7v7753XDG6CtRPuAqnmT2+Q9xT4Vb2e6J+r9LfhAPfuse
lYvf1y11svqSGHdixGDeVpZJm08kewc9yCLSBa/W2Hb5Uz0aqQiExl7XNNDkhJ8b
kzsHsi5AbA8XONqm5MaK3IQKITadMw==
=8cY3
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--

--===============0065193283058204460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0065193283058204460==--
