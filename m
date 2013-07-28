From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6 v2 resend] ASoC: add Renesas R-Car SCU
	feature
Date: Sun, 28 Jul 2013 19:32:45 +0100
Message-ID: <20130728183245.GE9858@sirena.org.uk>
References: <87a9m6ixgp.wl%kuninori.morimoto.gx@renesas.com>
 <87bo61wuoc.wl%kuninori.morimoto.gx@renesas.com>
 <87vc43rz43.wl%kuninori.morimoto.gx@renesas.com>
 <87ppubrz1t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8145376516220044662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 155F12618F2
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 20:32:50 +0200 (CEST)
In-Reply-To: <87ppubrz1t.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8145376516220044662==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DaUEczEJLvNJIL0g"
Content-Disposition: inline


--DaUEczEJLvNJIL0g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 21, 2013 at 09:36:35PM -0700, Kuninori Morimoto wrote:

> +#define RSND_GEN1_REG_MAP(g, s, i, oi, oa)				\
> +	do {								\
> +		(g)->reg_map[RSND_REG_##i].index  = RSND_GEN1_##s;	\
> +		(g)->reg_map[RSND_REG_##i].offset_id = oi;		\
> +		(g)->reg_map[RSND_REG_##i].offset_adr = oa;		\
> +	} while (0)
> +
> +static void rsnd_gen1_reg_map_init(struct rsnd_gen *gen)
> +{
> +	RSND_GEN1_REG_MAP(gen, SRU,	SSI_MODE0,	0x0,	0xD0);
> +	RSND_GEN1_REG_MAP(gen, SRU,	SSI_MODE1,	0x0,	0xD4);

This all really does look like regmap could be doing something useful
here.

> +static int rsnd_scu_init(struct rsnd_mod *mod,
> +			 struct rsnd_dai *rdai,
> +			 struct rsnd_dai_stream *io)
> +{
> +	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
> +	struct device *dev = rsnd_priv_to_dev(priv);
> +
> +	dev_dbg(dev, "%s.%d init\n", rsnd_mod_name(mod), rsnd_mod_id(mod));
> +
> +	return 0;
> +}

Clearing out these empty functions would be good if there's any left
after the full series is applied.

--DaUEczEJLvNJIL0g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9WPKAAoJELSic+t+oim9kw8P/2SntgpdNw++nXHsxQrCVmuv
WblE2uMhPE9V5+R3p8bIGz3jZCYdotKHGcGaghzj5ZsiQ7khiX6cEazDkzreodXE
fbqLqkwg7l8Ydas84e6jeijV/vnYDGCc5Qas9luICyg8Uu2BuUOd9Qbstprgvk+y
45jz4Y46K3Fp5vexbVTujfDlTTru4eyY34bE4xA7tRCfPeymUw/J9wMwAu4Zu5GS
Z9s6IXKHHwVpyvRjpHNAFNMd5EXXIfL6sGf0E9+veOOAqeKgEmdQ/5K7MzZS4knn
bsqJfmi2gj2f+HDZGPh2IV42L/GbTELuLRMfYYiRzmPrNstTPrpO0UGww+g5so4J
x/LDNm9nIW2XytNRsNbx19NrB5qcZpvrH3JXDFmgCv+LJZtCTO6DgV0e6D7A8Y4a
DYH2DZPEXYpL6nRa8Cu5icUOhnPb2jqnoF7MjCi7TucSWfdxBO3RmJSXDKSkg1LC
S7V9j1BHnxa53T8Icshxh2LOqT7kyP8VKBTd/y/NCE2eDMeN/yBVwaL52G5GeMQg
QEWDkVWaGe1o8tcF6fA6TsVG8rD93R63zvJCXO5O/ZRaXfLPx9QTWUh1BLpOGhsQ
TR2vna08We6pkqyhsq2IXc0fO81sedk3kVy+eMCEA/bDq7AApZT0Yy/6iJouRvfU
/W/cV8M3b68T5oWniEPm
=DpFP
-----END PGP SIGNATURE-----

--DaUEczEJLvNJIL0g--

--===============8145376516220044662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8145376516220044662==--
