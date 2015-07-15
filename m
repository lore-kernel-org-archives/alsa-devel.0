From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: cs4349: Add support for Cirrus
	Logic CS4349
Date: Wed, 15 Jul 2015 12:49:22 +0100
Message-ID: <20150715114922.GO11162@sirena.org.uk>
References: <55a5b61e.e2876b0a.89061.59cf@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3144966637005481769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F344265A82
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:49:29 +0200 (CEST)
In-Reply-To: <55a5b61e.e2876b0a.89061.59cf@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timothyc.howe@gmail.com
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============3144966637005481769==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bQjxe2ksi2vU832J"
Content-Disposition: inline


--bQjxe2ksi2vU832J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 08:23:39PM -0500, timothyc.howe@gmail.com wrote:

> +static int cs4349_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
> +				   int source, unsigned int freq, int dir)
> +{
> +	struct cs4349_private *cs4349 = snd_soc_codec_get_drvdata(codec);
> +
> +	cs4349->mclk = freq;
> +
> +	return 0;
> +}

On a more detailed look I'm not seeing anywhere where mclk is
referenced, it appears to be write only.  Better to remove this function
and the private data for it if it's not needed.

> +#ifdef CONFIG_PM
> +static int cs4349_runtime_suspend(struct device *dev)
> +{
> +	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
> +	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	regcache_cache_only(cs4349->regmap, true);
> +	regcache_sync(cs4349->regmap);

This doesn't make sense to me - we're syncing the register map right
after we put the device into cache only mode.  I think it's just a
cut'n'paste thing?

--bQjxe2ksi2vU832J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpkjCAAoJECTWi3JdVIfQJ2kIAIC0E9EqF8Ng+RFRCzoLY90C
ai00MIyso3T0BaI9aco0xYeyIGmOOvRS9YU33KAPHFSgKwvxNoFFu9tkDLLapnU9
RRIFtCdREJPa+sRj+XeqpGbcUouzoYbo0ag2b4CmZvXx3z5f7zCawmLELWVIINKG
9SY97Nh8Md/3m2f/SuKZ+7ZUIJnRd9uC3ujshNFHvsVpTbjEWkFoo1lodgg4cCvf
0SIymG2vlZAwXP5qV3JZorqm/yDWrM8lr4A7qq3vWuT72l7P3Em4lzYfKbeIKNMH
PpaAcy0/4csTM8+Nwd9JNBVotRXNQVsNIGR75w32+Sg1G2aWA5WE+nRlI5SwcIA=
=99iK
-----END PGP SIGNATURE-----

--bQjxe2ksi2vU832J--

--===============3144966637005481769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3144966637005481769==--
