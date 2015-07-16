From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/35] ASoC: rsnd: add CTU/MIX prototype
	support
Date: Thu, 16 Jul 2015 22:19:34 +0100
Message-ID: <20150716211934.GD1602@sirena.org.uk>
References: <87d1ztx5pb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2823511275506369634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EE822666ED
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:19:41 +0200 (CEST)
In-Reply-To: <87d1ztx5pb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>, kobayashi <keita.kobayashi.ym@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============2823511275506369634==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 07:06:56AM +0000, Kuninori Morimoto wrote:

>  1) -  2) adds audio prefix support on DT which is needed on DPCM
>  3) - 29) cleanup/tidyup/workaround/prepare patches for CTU/MIX support
> 30) - 31) CTU/MIX support on driver
> 32) - 35) CTU/MIX support on SoC

*Please* don't submit such large patch serieses unless you really need
to, it's a lot to review at once.  It's best to split things up to
smaller sets to be easier to work with.  For example with this set it'd
be better to send the cleanups and tidyups first (ideally one kind of
cleanup at a time) then the new feature.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqB/lAAoJECTWi3JdVIfQ+rAH/0df0ptNSXi5o++FNZhOoV6u
i6sgYrIpI/TnSeom3aafbqiiwA69BW+AZwszBtEFNp4fY3f7maUgkhV9PQOkZJb/
cQiqnvymk/eePPRtvZUWGz4HeBJ9WYQcGO9FVdO54rFYbbcJ8AGlazh+CIFFUojf
0h6lhXKmAUFueZ1aBe9TntzPZX5YxALnP/QYWG+pS1Blw8wejd8J5dVqZFnxM29E
NyOh/SMhLEXVG1XNgDUZ1EzfTeQdjD8/mQecBv8pEAgbfeXbWzGpCG3mzXLPntrK
e1d1h0Raqla708JhW36+/FEQK+/wr//HvkKxXOs5Vrp81Q3FYXFjaFpyaTtmO5Y=
=rCoB
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

--===============2823511275506369634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2823511275506369634==--
