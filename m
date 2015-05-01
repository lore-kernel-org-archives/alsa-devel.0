From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: zx: Add ZTE zx296702 pcm support
Date: Fri, 1 May 2015 12:17:14 +0100
Message-ID: <20150501111714.GX22845@sirena.org.uk>
References: <1430366850-10281-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4127549996983519504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0785A26148F
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 13:17:24 +0200 (CEST)
In-Reply-To: <1430366850-10281-1-git-send-email-jun.nie@linaro.org>
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
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com, zte-lt@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4127549996983519504==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jgH0kDk3EN9DzA3A"
Content-Disposition: inline


--jgH0kDk3EN9DzA3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 12:07:29PM +0800, Jun Nie wrote:

> +static const struct snd_pcm_hardware snd_zx_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_PAUSE |
> +				  SNDRV_PCM_INFO_RESUME |
> +				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 16 * 1024,
> +	.periods_min		= 2,
> +	.periods_max		= 32,
> +	.buffer_bytes_max	= 60 * 1024,
> +};

Can the generic DMA code not work this out by querying the dmaengine
driver?

> +int zx_pcm_platform_register(struct device *dev)
> +{
> +	return devm_snd_dmaengine_pcm_register(dev, &zx_dmaengine_pcm_config,
> +			SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME |
> +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);

_NO_RESIDUE has been removed in current code, the core figures it out
automatically.  Like I said looking at the driver code I'm not clear why
this is specifying _CUSTOM_CHANNEL_NAME either, it looked like the
driver just used the one standard channel name.

--jgH0kDk3EN9DzA3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ2C6AAoJECTWi3JdVIfQdloH+weyDT3fgRREEHX8D+bmq7j5
xLppxo+xAEYVaOfNXQE7OVEmPz0ziKEp8c3ReLUUGcn6C7tbXLtl/VFXvc6qFP2b
oMmQgMjR/iKiOdQONtp3w5sSiotrBlcaebVNC0WFsiwh0LBDxx1UkhoWrdo2xxwP
lNfnENEc2VwZa3wxQpS/rq32RM7I7KYQXj38E+ISZrEUcdWl+YJmukLHcNCkowMg
Sqi/HlfArXeSAjCm3JMxcEmccfsD/ClLiz9ju0ebeyFUFhNfQnQKHwJB6z+tmhgj
MhlFu2MQ88SqbZA8K4D+yADowcGGqMQkC4IFoFw7YCF60BFWw07Tfs7/QXk4+iA=
=qEsk
-----END PGP SIGNATURE-----

--jgH0kDk3EN9DzA3A--

--===============4127549996983519504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4127549996983519504==--
