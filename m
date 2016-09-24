From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs4341: Add driver for CS4341
	CODEC
Date: Sat, 24 Sep 2016 20:07:16 +0100
Message-ID: <20160924190716.33m7mkq73zdnb7ur@sirena.org.uk>
References: <1473352169-23954-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7763285164989737048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 488FB265372
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 08:01:50 +0200 (CEST)
In-Reply-To: <1473352169-23954-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============7763285164989737048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bsuzrdc5uvufc6eq"
Content-Disposition: inline


--bsuzrdc5uvufc6eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2016 at 07:29:29PM +0300, Alexander Shiyan wrote:

> +	switch (format & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +	default:
> +		goto fmt_err;
> +	}

Why the goto?  Just put the error handling code in here directly.

> +	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		cs4341->fmt = format & SND_SOC_DAIFMT_FORMAT_MASK;
> +		return 0;
> +	default:
> +		break;

We silently ignore invalid formats here...

> +	SOC_SINGLE("Popguard Transient Control", CS4341_REG_MODE2, 1, 1, 0),

Popguard Transient Switch so that userspace tools know how to handle
this.

> +	spi->bits_per_word = spi->bits_per_word ? : 8;
> +	spi->max_speed_hz = spi->max_speed_hz ? : 6000000;

Please write normal if statements, it's easier to read..

--bsuzrdc5uvufc6eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5s7jAAoJECTWi3JdVIfQddEH/25F/LwBTZ6c27qFEmUCKiso
ObX+uu27Nvv9B6WiyLKBvYTq1p+cjpNlDAtcSzHvN/qs0EHwUumn/V0cdXZecLHK
D3oysJDqLKheH70EsKPbMi3kZRXhkpVwkNb6alVNWTE7TMA5g0h9X2eJRARrZigX
wE6EahkQb8foRRVy2SxKN2Ww027Lj+nwKdyc+YpgMVAZCQ+JXCkBfFKfnN9Iy0Xq
ZDqWCRhj8176u6g6sUWjCPm1mUS3WJm4Roqb226YNNN/Xk2RAaZTukvFpVkpWsaD
e/OSpZ9eBQD1A79aqpf5y6pWfQ6JaemdVr9qE46LaAIMm+aB9aGmHiM0lrXTj/g=
=F5oV
-----END PGP SIGNATURE-----

--bsuzrdc5uvufc6eq--

--===============7763285164989737048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7763285164989737048==--
