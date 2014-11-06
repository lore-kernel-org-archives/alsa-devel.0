From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 5/6] ASoC: Intel: add BYTCR machine
 driver with RT5640
Date: Thu, 6 Nov 2014 18:41:42 +0530
Message-ID: <20141106131141.GD1870@intel.com>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-6-git-send-email-vinod.koul@intel.com>
 <20141106124854.GC8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4719357652157373429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C8DA8260632
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 14:11:20 +0100 (CET)
In-Reply-To: <20141106124854.GC8509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4719357652157373429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:48:54PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2014 at 04:25:19PM +0530, Vinod Koul wrote:
>=20
> > +static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
> > +					struct snd_pcm_hw_params *params)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> > +	int ret;
> > +
> > +	if (strncmp(codec_dai->name, "rt5640-aif1", 11))
> > +		return 0;
>=20
> This looks wrong...  fairly sure I queried this on an earlier version of
> the patch and was told it wasn't required.
This was supposed to be removed, not sure why it creeped back in, will fix
now

>=20
> > +	ret =3D snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
> > +				     params_rate(params) * 512,
> > +				     SND_SOC_CLOCK_IN);
> > +	if (ret < 0) {
> > +		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
> > +		return ret;
> > +	}
> > +	ret =3D snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,
>=20
> Missing blank line here and in several places throughout the file.  I'd
> expect the PLL to be enabled before the sysclk is told to use it, error
> checking might kick in otherwise.
ok

>=20
> > +#ifdef CONFIG_PM_SLEEP
> > +static int snd_byt_prepare(struct device *dev)
> > +{
> > +	return snd_soc_suspend(dev);
> > +}
> > +
> > +static void snd_byt_complete(struct device *dev)
> > +{
> > +	snd_soc_resume(dev);
> > +}
> > +
> > +static int snd_byt_poweroff(struct device *dev)
> > +{
> > +	return snd_soc_poweroff(dev);
> > +}
> > +#else
> > +#define snd_byt_prepare NULL
> > +#define snd_byt_complete NULL
> > +#define snd_byt_poweroff NULL
> > +#endif
>=20
> Don't bother with the wrapper functions, they're not adding anything.
> Why are we using prepare() and complete() here - other machine drivers
> don't need to do that?  Comments might be helpful...
due to I2C. We have seen that codec is resumed but I2C is still
not ready causing i2c failures, so moving to complete and prepare helps. I
will add this comment. Will remove wrappers.

Thanks
--=20
~Vinod

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUW3ONAAoJEHwUBw8lI4NHR6sP/jZq6wuhmsu8dWFBVazAAXDA
gHJ9keL8tvGrgSzSfbhZ7wok8rkSolQsxW//Ja6TRCKXv/sS1QY10/MsLsBmJ4Dp
jjB9alV6xIZTIjsueE7ZOtZ196OJ65BqeCOv1zSQEegCEjHcvoiFChKxdURpBoo8
TRKbwhVDPgG7GPIvmT3hezLJSrFoVYbBHcl1/OFpVpjDYJm6g5JMDNUyCgu6DW+W
V8sWZLsARehc4quBiHCDOejG9lCQ/N5eQFZ8CXDi8FVGVtXshgMe31crjlMcXL7e
sVBH8t/f80RFc+hVSCXZUzXNRFpYLH/aj/1jLFoSymyxGcc7E1LqTYXYsQ6vZnjd
4EV1hbxi+AAnfHpWHCsV72emeDsJ8REd0xoPWRa5xT25Vjr/jJT+UYMkTaFcHhtq
9tPIXViP21sT9xO1IQKqRQU2J8Ol34MHmfsPbJFAJ/8FHHjpAjB+MirclWfZxo42
W0CV6i67hFldm6i2vieNiM9F2MrZZPP9vL13p8NcsyL0SN06/R0T9+/mnSkAKBN8
Tc4bjIAyrj3dNJ8As20ACKfwt1jtKjm+jfHkplY9ZX+sT5l/dr+tf+k/LJBo8KD/
DaMjUqhLz6IAPTN7q41SFmMsAcyMe+djJ4YGFsxrQcYyrJIjGhYwWyXymhqjeXtw
0DsOOcDik9R95flqWHT7
=5TeM
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

--===============4719357652157373429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4719357652157373429==--
