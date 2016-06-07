From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v8] ASoC: dwc: Add PIO PCM extension
Date: Tue, 7 Jun 2016 18:30:45 +0100
Message-ID: <20160607173045.GE7510@sirena.org.uk>
References: <cover.1464601439.git.joabreu@synopsys.com>
 <09988b615638750c435d95f87906d7974f2b239c.1464601439.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zljh9u/ceMLi+8mf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09988b615638750c435d95f87906d7974f2b239c.1464601439.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Zljh9u/ceMLi+8mf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 30, 2016 at 10:53:15AM +0100, Jose Abreu wrote:

A few small things but this looks basically fine.

> +		if (isr[i] & 0x33)
> +			irq_valid = true;

This checks for a mask of 0x33 but...

> +
> +		/*
> +		 * Check if TX fifo is empty. If empty fill FIFO with samples
> +		 * NOTE: Only two channels supported
> +		 */
> +		if ((isr[i] & 0x10) && (i == 0) && dev->use_pio)
> +			dw_pcm_push_tx(dev);
> +
> +		/* Error Handling */
> +		if (isr[i] & 0x20)
> +			dev_err(dev->dev, "TX overrun (ch_id=%d)\n", i);
> +		if (isr[i] & 0x02)
> +			dev_err(dev->dev, "RX overrun (ch_id=%d)\n", i);

...only 0x32 seem to actually be handled, and then only sometimes.  It's
going to be clearer and more robust to just set the handled flag to true
when handling, that way we don't have to match up different numerical
masks.  Some defines would help legibility too.

> +	ret = snd_pcm_lib_malloc_pages(substream,
> +			params_buffer_bytes(hw_params));
> +	return (ret < 0) ? ret : 0;

Write normal if statements please, it helps legibility.

--Zljh9u/ceMLi+8mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVwTEAAoJECTWi3JdVIfQpOkH/jo53I7XVozCpVboiydYvjd0
fB+yltk7y324ZEYxar51QhqlOwYISYt49R6mBsxp3FFd7FrbNEUMdeA19pNz6YwG
vd+ka9nDA7le0Ldh3IUV+APt42OnsesmAqJxoyJ+D6b4GR3YDuf0NERnMtwHwJvf
k4kvfXYT40hFv9bPGfR30JlblcXL6uTgSMQSdxWUQPd3tosWwSBzjDPUjyv3TnyV
nCvi6bj/r8zEVihlqhip4/G1Ie7ZPmadI/8I1Y0BayYFTKoyOrU7EKhvfSVhKop+
prltwuvuTpBn/sq4gX4QgXUNw3VqTImLqotRn/C+RBoNs040Ch6pvZsYqWh1ilI=
=1sZi
-----END PGP SIGNATURE-----

--Zljh9u/ceMLi+8mf--
