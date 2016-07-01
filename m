From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_card_name()
Date: Fri, 1 Jul 2016 11:52:49 +0200
Message-ID: <20160701095249.GJ6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <8760tusj2q.wl%kuninori.morimoto.gx@renesas.com>
 <20160629181555.GJ6247@sirena.org.uk>
 <874m8bbdei.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D85EWoRcDXv1uhH1"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874m8bbdei.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--D85EWoRcDXv1uhH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 02:55:06AM +0000, Kuninori Morimoto wrote:

> > > +	if (!card->name)
> > > +		card->name = card->dai_link->name;

> > This will unconditionally defererence dai_link but it's optional - we
> > can have analogue only cards.

> This is not new feature. Current simple-card already has it.

Right, but simple-card does need DAIs IIRC while this is intended to be
more general.  All it needs is a check before the dereference to be safe
so it's trivial to handle.

--D85EWoRcDXv1uhH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdj1vAAoJECTWi3JdVIfQTqsH/jCfCs8imQ75dgsRDjAJTiKJ
1Smd/XtGaIfT+O5vEPwcWQsPpczOH076IvZ2hjVPElNlQL2fwryjzHUoiGBTmOXl
tWiHkAPVqnchjvi9YTxORBuuMX557IPty1LySQSRkl8KDZoP3YulEU8S3g1DP6bg
Agkef9EmdMTr/9m+o32pkcLsKijvNcT5VzmDdvas4azUWY9MtxGYpW6iCgVS+G0R
HqfsyKOCZpv7tN6yPhFO8CEdjT1qL9SRFfIf+KQfyLSF2q9SNY6HtmYue9Q2s+ug
Wfi4RNABb0cyCilcGfpWMWA9bGua8+BQ3zCGwV04orpcWOyRioPUiGIGpkcufsw=
=aMJw
-----END PGP SIGNATURE-----

--D85EWoRcDXv1uhH1--
