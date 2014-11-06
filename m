From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC:rt5670:Add runtime PM support
Date: Thu, 6 Nov 2014 05:55:25 +0000
Message-ID: <20141106055525.GN8509@sirena.org.uk>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4437683675244941679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5A12650C5
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 06:55:36 +0100 (CET)
In-Reply-To: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4437683675244941679==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 12:23:51PM +0800, bardliao@realtek.com wrote:

> +#ifdef CONFIG_PM_RUNTIME
> +static void rt5670_use_internal_clk(struct rt5670_priv *rt5670)
> +{
> +	struct snd_soc_codec *codec = rt5670->codec;
> +
> +	if (!codec ||
> +	   (0 == rt5670->sysclk && RT5670_SCLK_S_RCCLK == rt5670->sysclk_src))

Normal kernel coding style is to put the variable before the constant.

> +		return;
> +
> +	snd_soc_update_bits(codec, RT5670_GLB_CLK,
> +			RT5670_SCLK_SRC_MASK, RT5670_SCLK_SRC_RCCLK);

Instead of using snd_soc_ here use regmap and then you don't need to
worry if the card is registered.

> +static int rt5670_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}

This should be undoing the change done on suspend otherwise we'll be
stuck on the internal clock after resuming.  Alternatively if something
will undo that elsewhere then presumably we don't need to use runtime PM
to select the internal clock anyway?

If this were an empty function it should be removed.

> +#define RT5670_PM_OPS	rt5670_pm
> +#else
> +#define RT5670_PM_OPS	NULL
> +#endif /* CONFIG_PM_RUNTIME */
> +
>  static struct i2c_driver rt5670_i2c_driver = {
>  	.driver = {
>  		.name = "rt5670",
>  		.owner = THIS_MODULE,
> +		.pm = &RT5670_PM_OPS,
>  	},

Usual idiom is to include the & in the #define for the PM active case.

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWw1NAAoJECTWi3JdVIfQoXoH/R884hq9peZCItPIOmbKGTn+
sBsvVNe2NvjMBoIwx98VDDDIA3XfS8TfDdmtIozc1QcX+5kNMBWgU7H+bdbhxRWl
h2xjI+oWzSsjczjxnpTQUWcpA3ogM/T/SxzzqhNXb/JHNzM5vD5w9R9fBBSDkhhM
UnB1GoWLtZeSNVV3UtYuSsOnLTJKBFN79Kg1bN7oOoq8YXM7BL+Nwv4QTmz/fxQA
1xhBTjSeEgXypUGL21gW3sRLn+w4rK7teqMklL7vbuyRcR3mo/cRWYvTvMGJ07G5
h5pbjpahnTOR28SizxZ+xPB1x2+Svfs5Ww2mdTUShYCfeF4uNBzDmMCjbS9Zx2w=
=YK7X
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--

--===============4437683675244941679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4437683675244941679==--
