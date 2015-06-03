From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Wed, 3 Jun 2015 18:58:01 +0100
Message-ID: <20150603175801.GQ14071@sirena.org.uk>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7170754116925149726=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D3162606D8
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 19:58:14 +0200 (CEST)
In-Reply-To: <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7170754116925149726==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4c4BJozgj/kzMVO6"
Content-Disposition: inline


--4c4BJozgj/kzMVO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 09:31:21PM +0800, Jun Nie wrote:

> +int zx_hdmi_audio_cfg(int audio_codec, int audio_way,
> +		      u32 sample_rate, u32 sample_len);
> +void zx_hdmi_audio_en(int on);

It's a bit hard to review this properly without knowing what these
functions do.

> +static int zx_hw_params(struct snd_pcm_substream *substream,
> +			struct snd_pcm_hw_params *params,
> +			struct snd_soc_dai *dai)
> +{
> +#ifdef CONFIG_ZX_HDMI_SND_SPDIF
> +	zx_hdmi_audio_cfg(1, 0, params_rate(params),
> +#endif
> +#ifdef CONFIG_ZX_HDMI_SND_I2S
> +	zx_hdmi_audio_cfg(1, 1, params_rate(params),
> +#endif
> +			  params_physical_width(params));
> +	return 0;
> +}

The magic numbers aren't great and it does seem a bit odd to call both
I2S and S/PDIF versions always - but I guess this will be restructured
following our discussion in the other thread anyway.

--4c4BJozgj/kzMVO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVb0AoAAoJECTWi3JdVIfQ88kH/jURbTa0mT0h3AVjpXZqjssK
EJAfdgz+YQTqqAGhk2TYekGiOuRnyP2gwvEzkJeUSB4tl9tSlhj8GFcwLTHRdNcl
lybv3PTSEuSpca5Ya+/2lpsEfsbk8LYJiAHPhIiVVkM40Y70mkrxZIf3gvaMcz1G
FF/nb5GpRL/ZMWqdjBHG43U2iFt6F7rifu9AnN1L1hkE50tolhD1u3LnqYhH6Xmp
NNFLgy4YsKwjDLWv/lMG8sECbWcWagjtGJdPhIjlvyw4lMmRXrA9ns3dkV0uNHFw
bsylhI+QavWv5VLTMg0Mj458ol3NhTeMRVr7+5clbxwXRK/COLpiDw8SC/Kj4/0=
=haeR
-----END PGP SIGNATURE-----

--4c4BJozgj/kzMVO6--

--===============7170754116925149726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7170754116925149726==--
