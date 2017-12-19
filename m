From: Mark Brown <broonie@kernel.org>
Subject: Re: About ASoC DAIs cleanup
Date: Tue, 19 Dec 2017 11:23:02 +0000
Message-ID: <20171219112302.GI8563@sirena.org.uk>
References: <87shciup8e.wl%kuninori.morimoto.gx@renesas.com>
 <87r2s2uo55.wl%kuninori.morimoto.gx@renesas.com>
 <87o9n6ukyg.wl%kuninori.morimoto.gx@renesas.com>
 <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171213155952.GL6416@sirena.org.uk>
 <87wp1qow1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171214050648.GU18649@localhost>
 <20171214113718.GB9788@sirena.org.uk>
 <20171215042053.GA18649@localhost>
 <87mv2grdqm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1855189066844967871=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A230D267671
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 12:23:06 +0100 (CET)
In-Reply-To: <87mv2grdqm.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1855189066844967871==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 02:16:07AM +0000, Kuninori Morimoto wrote:

> My quick idea is using "peripheral" flag.
> I think we can set it on soc_bind_dai_link() ?
> And we can use it like below

> 	for_each_dais(dai, xxx) {
> 		if(!dai->peripheral)
> 			/* non Peripheral =3D=3D CPU portion */
>=20
> 		if(dai->peripheral)
> 			/* Peripheral =3D=3D Codec portion */
> 	}

> But what do you think about this idea/naming etc ?
> I want to investigate more about Codec <-> Codec connection,
> which driver is using it ? Especially CPU portion

I'm thinking it might be better to keep the list ordered in the DAI link
- that will scale up better with multi-drop links.  What's going to be a
bit more tricky sometimes is working out which end of the link is a CPU
DAI but we can probably take a good guess easily enough on order neutral
bindings and things liken simple-card already know explicitly.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo49pUACgkQJNaLcl1U
h9Av3Af/ez3SdXuTwmSKAU1Xf8aDSsV2WlPvruArSvBuo7mUZCl/whAOk8/YFe5p
EkvRGEEXh8jmKdppGGZ6E2pF1+nMw98chj4qKSapdcxUwyVTg6AvhUdSUbFIPD81
ODEYUfJpVxcfUp1yIQcyXF9awUl3uXVKsVEEydOoVpvxQ+D8862n0862sFDyJVLi
QB9nbkCSsz2mtivCHNr78z8NRQqc/RngEZpC2nab542GY53wLGweHyZZgv7bonMg
V9Use+jE7Dc2CE1VPInEhUNlH9sQPk6sfqj7HaP6p8pIXTj/7hLUZnEN0uV+6B41
kuQWgtjBo9x2IODw41MDoscQ3teGbA==
=49zr
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--

--===============1855189066844967871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1855189066844967871==--
