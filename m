From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC
 (with a WM8731)
Date: Wed, 29 Aug 2018 15:53:55 +0100
Message-ID: <20180829145355.GD27808@sirena.org.uk>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4703412676939971179=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 47A9026766C
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 16:53:57 +0200 (CEST)
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, florian.meier@koalo.de, cristian.birsan@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4703412676939971179==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29, 2018 at 05:47:26PM +0300, Codrin Ciubotariu wrote:

> +static const unsigned int wm8731_rates_12288000[] = {
> +	8000, 32000, 48000, 96000,
> +};
> +
> +static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 = {
> +	.list = wm8731_rates_12288000,
> +	.count = ARRAY_SIZE(wm8731_rates_12288000),
> +};
> +
> +static int snd_proto_startup(struct snd_pcm_substream *substream)
> +{
> +	/* Setup constraints, because there is a 12.288 MHz XTAL on the board */
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_RATE,
> +				   &wm8731_constraints_12288000);
> +	return 0;
> +}

This bit is better added to the CODEC driver since it'll apply to any
system where there's this clock rate (someone else could come in and add
other rates, no need to do that yourself though it'd be nice of course).

That also has the nice bonus that with that I think you'd be able to use
the graph card rather than a custom driver?

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGs4IACgkQJNaLcl1U
h9BMcQf9HdY9EONm+yWwQ7kU0mb+CJjqPSHn4kRKd7wuVKMauN0RyzVZKPpdhO4A
Kp3reX0sY5uqvKk2V1zh7/ceOHoMM+l3g+Gj+tmWF2eXEcuovP9fFNZY2HPG1Tjw
eU+focC0h/2AiT/y//70B3FhDAjH/Chd4Jtqpmdm3qfmfNbFaw42eJS+oA2eBK/f
4ZRO0Q1uj3N1YnGOsrsRR3+wFveVoVf+zG7tPPQJYQICxXj5MZf9ExiWSjfTl6/b
VN/qXMdOMGOT/2EKJzSFRTWKu4WKlJOdURxnTzHgeXxas7DF63pEeXgKdq22yq/Y
7GVcZisHHftdm8xEdQpW5GsZaP60Ng==
=5Nmi
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

--===============4703412676939971179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4703412676939971179==--
