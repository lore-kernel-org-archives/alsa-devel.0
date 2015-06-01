From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/4] ASoC: arizona: Export functions to control
 subsystem DVFS
Date: Mon, 1 Jun 2015 17:10:47 +0100
Message-ID: <20150601161047.GC14071@sirena.org.uk>
References: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 02:04:48PM +0100, Richard Fitzgerald wrote:

> +int arizona_dvfs_down(struct snd_soc_codec *codec, unsigned int flags)
> +{
> +	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
> +	unsigned int old_reqs = priv->dvfs_reqs;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->dvfs_lock);
> +
> +	priv->dvfs_reqs &= ~flags;
> +
> +	if (!priv->dvfs_cached && old_reqs && !priv->dvfs_reqs)
> +		ret = arizona_dvfs_disable(codec);

What is the lock intended to protect here?  We read old_reqs outside the
lock so it's possible that dvfs_reqs could change between us reading
old_reqs and the locked section - I would have expected to see all the
reads and updates to be in the locked section but perhaps it doesn't
protect what I think it protects (all the DVFS-related variables).

> +	case SND_SOC_DAPM_PRE_PMD:
> +		/* We must ensure DVFS is disabled before the codec goes into
> +		 * suspend so that we are never in an illegal state of DVFS
> +		 * enabled without enough DCVDD
> +		 */
> +		priv->dvfs_cached = true;
> +
> +		if (priv->dvfs_reqs)
> +			ret = arizona_dvfs_disable(codec);

Are you sure that the function shouldn't check for requests?  It seems
like every caller is repeating the same check.

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbIQGAAoJECTWi3JdVIfQfYcH/0oBEutVagfKhC9nJLwK3sAi
w533a7x2+3Tye/4uts7qzFIytE553CNzj1//HF9tR5l7IMwOIFD7WgmXl5Bn9xUV
wLQsnbIML02BHCbkJkp6WYwI8/cawuNExUqfdjNzfnzjH5owpvzvU2Dg/nAX4X3X
swnmAqbIyasxeXJKkO2HnisHb/wfKFN2Gl+4velAlvGN6OeLqsnFxetV5z9anOhl
dRiLk0sMJaYF47Vyomn+psIodkkhUYqdQP+CLcXZvgqdKbPc4ldkWIBr/WWCJgbo
wtuZbHp1Zzqj4qY3VC6cgXxZTGRWLYr4spshjVkBxupuZRAQE8AF466/RFebQSQ=
=5ApT
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
