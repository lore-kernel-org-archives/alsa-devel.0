From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/8] ASoC: Intel: Boards: Machine driver
 for SKL+ w/ HDAudio codecs
Date: Wed, 1 Aug 2018 11:04:42 +0100
Message-ID: <20180801100442.GD5509@sirena.org.uk>
References: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
 <20180727230554.31027-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7512416673474624442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA552676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 12:04:47 +0200 (CEST)
In-Reply-To: <20180727230554.31027-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7512416673474624442==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 06:05:49PM -0500, Pierre-Louis Bossart wrote:

> new file mode 100644
> index 000000000000..b2a9a6c6b147
> --- /dev/null
> +++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2015-18 Intel Corporation.
> + */

Please make the entire comment a C++ one in the C files so it looks more
intentional.

> +int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
> +{
> +	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
> +	struct skl_hda_hdmi_pcm *pcm;
> +	char dai_name[NAME_SIZE];
> +	static int i = 1;	/* hdmi codec dai name starts from index 1 */
> +
> +	pcm = devm_kzalloc(card->dev, sizeof(*pcm), GFP_KERNEL);
> +	if (!pcm)
> +		return -ENOMEM;
> +
> +	snprintf(dai_name, sizeof(dai_name), "intel-hdmi-hifi%d", i++);
> +	pcm->codec_dai = snd_soc_card_get_codec_dai(card, dai_name);

I'm confused, i is unconditionally 1 before the print and we then
increment it even though we never reference i again?

> +	if (codec_count == 1 && pdata->codec_mask & IDISP_CODEC_MASK) {
> +		num_links = IDISP_DAI_COUNT;
> +		num_route = IDISP_ROUTE_COUNT;
> +	} else {
> +		return -EINVAL;
> +	}

A warning about unsupported configurations might be nice if the code
ever gets executed on some shiny new laptop.

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlthhbkACgkQJNaLcl1U
h9AqGQf/e5xz5+CY9fO93Izy+5G+WksjtEXadLePADdym+GyQ2Xo9skVshuo4g1d
59wjGi7H8OPVsWDX1mZaxhQzZT63CXDGHKeUvXH5R9unxy0q4rEQYseapsyY3gC1
qZaZVArcR7ybSENyKCjmIwQBV7FW9h5TTKjXP+H3NLPOAa2Zimtx/gYgl2D+Kfq8
a33tquByUaojYsYH9B7hTKF21dMgS4JFqth94lAObNEDdLki2yiz642V705eJ2zF
UQTKtvsAT9D0WBFLeeYImt1lYwBKqjsgDAUJ/AR/bLarPRfXiuVjoPRfkFaT0oDN
FY8CQvMmSeIn5Kb+QDm7zBxZaOlefg==
=voiD
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--

--===============7512416673474624442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7512416673474624442==--
