From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Grant hw_params()
 permission to reprogram FLL
Date: Thu, 9 Jan 2014 18:25:51 +0000
Message-ID: <20140109182551.GO12858@sirena.org.uk>
References: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1557164047343533751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CD642652C5
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 19:25:59 +0100 (CET)
In-Reply-To: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1557164047343533751==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E+IgQzR66AIOcbjA"
Content-Disposition: inline


--E+IgQzR66AIOcbjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 25, 2013 at 06:37:15PM +0800, Nicolin Chen wrote:

> +	spin_lock(&data->fll_lock);
> +
> +	/* Protect FLL if it has not been disabled */
> +	if (data->fll_frequency)
> +		goto err_unlock;
> +
> +	ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL, WM8962_FLL_MCLK,
> +				  data->clk_frequency, fll_frequency);

You can't hold a spinlock and call sleeping functions like set_pll()
safely - it might do I/O and both the ASoC core and regmap use mutexes
which might be contended.

> +	mask = WM8962_MIXINL_TO_HPMIXL_MASK | WM8962_MIXINR_TO_HPMIXL_MASK |
> +		WM8962_IN4L_TO_HPMIXL_MASK | WM8962_IN4R_TO_HPMIXL_MASK;
> +	ret |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_1) & mask;
> +	ret |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_2) & mask;
> +	ret |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_1) & mask;
> +	ret |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_2) & mask;

Peering inside the CODEC register map isn't great and given that we
implement bias level changes for non-CPU paths immediately I'm not sure
what that's giving you over just using the bias level (which is the way
you're supposed to check if the CODEC is active)?

--E+IgQzR66AIOcbjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzumrAAoJELSic+t+oim9OTcQAJoC/fx88MtySre3EriWWxIz
lHOPrHfXdMSGcFxU5bH+rFKz1vjTFF/SYfShO9h59cJ0Ylx/7aStBRh4pNrRCZlc
tW/logL6RQT8/lKXu6vNGBro8wjBKN11BgDGjDeDtyh5cxDssp4jZB4bXaI0hrWz
B0ZeLJxrz+D6uAEm4FudP/xhKVx1dtXAbsqAgDrY76fFGzygW6ItjTsSOE3FxBLW
7Mv5mpGZ8gQcneso7tj9T8v7PMr9hJ7DEuIs5T9nP2awt1XwpyRkyoox9zCWy5H2
oGw4B+8TdctakaGuh2jk2rzaAxNpgh/zzcJCPNan56o3QnLRXCDlJ8kEuAbVBevy
JL1cTz8/j6OiCbn7EKRhR5/h573KjoyxiMdTGwNzg/6eDk6XHDgSGnJRKL2CevJs
vIlKgcT3e5QL5v5Ay2JnAaQCSH5xfQ2Ql6bT8utn4rrzTuB2ZxpBVN/hBhYBtGPc
GhQKW4qBlCIFIljTRMvUacP24NsXDHF2KDvTB30X7ZG8I9Ry2r4DFAw9sHfnJn/T
PHp2An/f6ran/oomNyQQKbA/dgc1ONAOHJeuL4gRWyeEOwPDIn1RmF1t46XXZ2hY
/9ZdQ+Epjk6T5XEp/5sRBeSgJ8l14kczNZLhGPwPPu4BjDwf32hdtWW8cEPb8iym
5DaLrABDDJ5pwk89rFCN
=xBB/
-----END PGP SIGNATURE-----

--E+IgQzR66AIOcbjA--

--===============1557164047343533751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1557164047343533751==--
