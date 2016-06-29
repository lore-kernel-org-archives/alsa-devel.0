From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_tdm()
Date: Wed, 29 Jun 2016 19:11:59 +0100
Message-ID: <20160629181159.GH6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <878tyqsj48.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878tyqsj48.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 09:00:40AM +0000, Kuninori Morimoto wrote:

> +int asoc_simple_card_parse_tdm(struct device_node *port_np,
> +			       struct asoc_simple_dai *simple_dai)
> +{
> +	return snd_soc_of_parse_tdm_slot(port_np,
> +					 &simple_dai->tx_slot_mask,
> +					 &simple_dai->rx_slot_mask,
> +					 &simple_dai->slots,
> +					 &simple_dai->slot_width);
> +}
> +EXPORT_SYMBOL_GPL(asoc_simple_card_parse_tdm);

This is (obviously) a very thin wrapper around the existing interface.
If that makes sense then perhaps we should just update the existing
interface?

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdA9uAAoJECTWi3JdVIfQzuoH/RNpz4GQPGRWO5mtNf4O1gXL
/4lP925zvrHBxV2REnLowGz/XVjJE4fIEn3k8fHSjlNkn/z8PTXdEbuVMKJXpaZC
6Y8zVtMbsgqibsb4XLVFy6WlDUgh7s7+QZ2PPvmm0mMCVzVxh5wyzAISB1I/deEr
MoT32yu1BKFi/LUB+85HwtAr9jY2dvhgJdwQ8hvnL/kSIkm+b5aKXpay1LqLZFTX
16lvrgnQilcdJ42ygKxYY8LgltwrbZf0FMmSPAnaB3bn2Ot7Jlo3fcw5ky9xIfB7
CaC0cQIuGqC94t8aB3oBK3gby7v4Unl88/9G6xLnEJXBT0xBMwutCTq0o2XWZZU=
=tOnr
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
