From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: MAX9860: new driver
Date: Fri, 13 May 2016 11:58:52 +0100
Message-ID: <20160513105852.GC22038@sirena.org.uk>
References: <1463124333-9489-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463124333-9489-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Misbah Ullah Khan <Misbahk@danlawinc.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 09:25:33AM +0200, Peter Rosin wrote:

> +static int max9860_dai_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct max9860_priv *max9860 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (max9860->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

This isn't the place to enforce restrictions on DAI format, do it in
set_dai_fmt().

Otherwise this looks good.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNbNqAAoJECTWi3JdVIfQUksH/iRwuGnoUek3FCic4AgeNTZw
FvcpVNAav8wSi0k9eCAesSHaUS7EHJGe195Ts0O29kkFclFVFFagShuRv4YQK9L4
BeHp4dtYvytwXFhcPJvtskS3ATVhmLAc3CP6ETkCK9tRDaKcufEU2RjIdVJVdEIp
x3R6Ykxw21aiBYItHk4sq4vuO5cUvGjx5/WQPGrPIfejjHwEBTL/QDKvPbSnaMvn
wtPmJd3nBM5nQ9WwWMlNVdPx5saU0CuVc4ZumwUBpTOIVE5gGgYbo/7WjPaPb19d
gBbOdNjOQcLd5rncz3/3RExOOzAWzByIiXQbHCw5ajCCgCv6VBazF71t3LsYklU=
=4uVn
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
