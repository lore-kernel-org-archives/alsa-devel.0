From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: audio-graph-scu-card: care link
	/ dai count
Date: Wed, 28 Nov 2018 10:46:29 +0000
Message-ID: <20181128104629.GH6828@sirena.org.uk>
References: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
 <87a7lw30k9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2321047252027739492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C68CC267AF3
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 11:46:30 +0100 (CET)
In-Reply-To: <87a7lw30k9.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2321047252027739492==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 04:59:04AM +0000, Kuninori Morimoto wrote:

> -static int asoc_graph_get_dais_count(struct device *dev)
> +static void asoc_graph_get_dais_count(struct device *dev,
> +				      int *link_num,
> +				      int *dais_num,
> +				      int *ccnf_num)

I can't tell what a "ccnf" is reading this and there's no documentation :(

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+cgQACgkQJNaLcl1U
h9CQmgf/evbGkbj3RtyRiSgzfTLJMjov7//3QysbKO4GeoqNsA0/GSJQfvAxiwif
PKweSLIMMv0x7MDAUZeBlzqbW52rMLKPfmjSFkjuWNER1kzzJ8NP8HgQ6tz62lfH
jqZuYtBHuCcp9DckUF4x6WFKHwhxvzDOxKD7APvP4ngwPWbXr4EjTVc5vvMCZn+o
gaCASXJKFc7EJfldEAKdiUFjwc+LhwTrp6P9vvnpbhRApCVGF//9t5RT569HJF8f
6z1FRUoXDFNJUeUt8LDrg5yJbJz2cQEftRyOMRdDN20UMICGZdgN5VSOEdUlzTKU
WL4RQgFN4gaTUQPPCBMk0A+gObI1fg==
=aXdZ
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--

--===============2321047252027739492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2321047252027739492==--
