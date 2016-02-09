From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: add crosstalk suppression
	feature
Date: Tue, 9 Feb 2016 18:39:44 +0000
Message-ID: <20160209183944.GL13270@sirena.org.uk>
References: <1454651566-28451-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6087991745577930987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ABA9261292
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 19:39:52 +0100 (CET)
In-Reply-To: <1454651566-28451-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6087991745577930987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 01:52:46PM +0800, John Hsu wrote:

> +/**
> + * computes log10 of a value; the result is round off to 3 decimal.
> + * this function takes reference to dvb-math.
> + *
> + * @return log10(value) * 1000
> + */
> +static u32 nau8825_intlog10_dec3(u32 value)
> +{
> +	u32 msb, logentry, significand, interpolation, log10val;
> +	u64 log2val;
> +
> +	msb = fls(value) - 1;
> +	significand = value << (31 - msb);
> +	logentry = (significand >> 23) & 0xff;
> +	interpolation = ((significand & 0x7fffff) *
> +		((logtable[(logentry + 1) & 0xff] -
> +		logtable[logentry]) & 0xffff)) >> 15;
> +
> +	log2val = ((msb << 24) + (logtable[logentry] << 8) + interpolation);
> +	log10val = (log2val * LOG10_MAGIC) >> 31;
> +	return log10val / ((1 << 24) / 1000);
> +}

This doesn't look driver specific, it should go somewhere generic
(though I can't immediately see any relevant place for it...).

> +	/* Config headphone volume */
> +	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSVOL_CTRL,
> +		NAU8825_HPL_VOL_MASK | NAU8825_HPR_VOL_MASK, 0x0492);

These are some very large register write sequences and there seems to be
a bunch of stuff in them like the above which looks a lot like it's
configuring things that we'd normally allow users to configure for their
use case.  This at least needs a lot more documentation about what this
is doing any why, and it's not clear to me that the code is safe with
respect to what happens if an application decides to do something at the
same time as the callibration is running.

> @@ -211,6 +585,7 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
>  	case NAU8825_REG_RESET:
>  	case NAU8825_REG_IRQ_STATUS:
>  	case NAU8825_REG_INT_CLR_KEY_STATUS:
> +	case NAU8825_REG_BIQ_CTRL ... NAU8825_REG_BIQ_COF10:
>  	case NAU8825_REG_IMM_RMS_L:
>  	case NAU8825_REG_IMM_RMS_R:
>  	case NAU8825_REG_I2C_DEVICE_ID:

It also looks like this could be split up a bit, things like this that
are just adding new registers could be separate.  The actual
callibration is tricky but there's a bunch of other changes to support
that.

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWujJvAAoJECTWi3JdVIfQiJUH/2qoz5P9Q1SBLAKcsJz4jC9y
QI1R1lPT2sLv1dGmT/OLtkHwWCVuroLbTYpGAILyi9ZcAAjcp8vejfNHI59O0FFi
fA92L9QAWZBwAQQ3Zc9oLM8yD0gFC0SZtK1Xv6bjOXWEqqRvNEz3mhVqG7SHF43O
+2abs/hG0vB6bDxVYvGe5swYd73UQwPy83rWsxFiwMhMeldgSrDtJT8QCFWOkq4r
J93pX8IXb+oi2aFMrZsfRRnH+GbjJp6On2m8EE9ofrsum/reXQsk3QbsQUVPELfn
UkmzizMXyRiXS2vpG87WW/c+sHQ3lxPwVV1fpxRIgE29nr7I68soDCK1hFkFTQY=
=cn80
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--

--===============6087991745577930987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6087991745577930987==--
