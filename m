From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: rsnd: depends on OF
Date: Tue, 25 Oct 2016 14:28:31 +0100
Message-ID: <20161025132831.GT17252@sirena.org.uk>
References: <878ttdcm17.wl%kuninori.morimoto.gx@renesas.com>
 <877f8xclzq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7184377963612330489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C08D12614A0
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 15:28:40 +0200 (CEST)
In-Reply-To: <877f8xclzq.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============7184377963612330489==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HywJcj55HbA57jnN"
Content-Disposition: inline


--HywJcj55HbA57jnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 25, 2016 at 12:35:53AM +0000, Kuninori Morimoto wrote:

> @@ -37,6 +37,7 @@ config SND_SOC_SH4_SIU
>  config SND_SOC_RCAR
>  	tristate "R-Car series SRU/SCU/SSIU/SSI support"
>  	depends on COMMON_CLK
> +	depends on OF
>  	select SND_SIMPLE_CARD
>  	select REGMAP_MMIO
>  	help

Can we have an || COMPILE_TEST to help build coverage if there isn't a
build time dependency on DT please?

--HywJcj55HbA57jnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYD13HAAoJECTWi3JdVIfQ6aAH/AjbjuLbAQa6eYPOLH+MxMcw
0a1CbzFZ0BJLlVMa4IwYxl747EoCoXUDnOIVw0bV8i0gD9ZLJXaqScpc/lC4m8iv
IBebwe3t9GaIng6CJhpi3xyjoRCBNASjEs/0kbQRT+vida7X/YFSInzh3AcGqepk
vebAa4a7SQU5oW2s4nu0JVJrIDJQ1onO2W08OcPu9PpYK3YC0II8120fYKiIYx5P
xHh2WKnjs+TBSlubtcQeWD3ZKtNpbG2GxdcZBcj/E0S1bxihJmIGmM6pYEV/5Rpa
DrIz2/NaeSmVVxoyq6A02KKK5heA9npB6aa7qdleUwT7gewZ3wG9E7bxvhOx5Vk=
=VCVq
-----END PGP SIGNATURE-----

--HywJcj55HbA57jnN--

--===============7184377963612330489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7184377963612330489==--
