From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/5] ASoC: sirf: add sirf platform
 driver which provides DMA
Date: Mon, 6 Jan 2014 17:07:15 +0000
Message-ID: <20140106170715.GK31886@sirena.org.uk>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-2-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4731539012398216328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D50522615EE
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:07:25 +0100 (CET)
In-Reply-To: <1388729104-28643-2-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============4731539012398216328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mndrpa8QG3Tvs5hl"
Content-Disposition: inline


--Mndrpa8QG3Tvs5hl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2014 at 02:05:00PM +0800, RongJun Ying wrote:

> index 0000000..1637089
> --- /dev/null
> +++ b/sound/soc/sirf/Kconfig
> @@ -0,0 +1,4 @@
> +config SND_SIRF_SOC
> +	tristate "Platform DMA driver for the SiRF SoC chips"
> +	depends on ARCH_SIRF && SND_SOC
> +	select SND_SOC_GENERIC_DMAENGINE_PCM

No need for the SND_SOC dependency, the subdirectories are only
enumerated if it is selected, and looking at the code I don't see a
build time dependency on ARCH_SIRF so it should be ARCH_SIRF ||
COMPILE_TEST.

> +static struct dma_chan *sirf_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_substream *substream)
> +{
> +	struct snd_dmaengine_dai_dma_data *dma_data;
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	return dma_request_slave_channel(rtd->cpu_dai->dev,
> +			dma_data->chan_name);
> +}
> +
> +static const struct snd_dmaengine_pcm_config sirf_dmaengine_pcm_config = {
> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +	.compat_request_channel = sirf_pcm_request_chan,

Do you need the compat_request_chan - I'd expect a newish ARM system to
be DT only and the code doesn't look like it's doing anything that the
core couldn't handle?

> +static struct platform_driver sirf_pcm_driver = {
> +	.driver = {
> +		.name = "sirf-pcm-audio",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = sirf_pcm_probe,
> +};

This doesn't look to ever access any hardware directly so it probably
shouldn't be a standalone driver as Lars-Peter says.

> +static int __init sirf_pcm_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = platform_driver_register(&sirf_pcm_driver);
> +	if (ret)
> +		pr_err("failed to register platform driver\n");
> +	return ret;
> +}

module_platform_driver() if there is some real hardware here.

--Mndrpa8QG3Tvs5hl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyuLAAAoJELSic+t+oim9EIEP/0y6WJDk6TwOrYMd1ivYCZGP
q2+oYaIrvmQ9rHD/QgurZrJ6B5gk7urSKZjsOxsOY803ivrXxJebpD9HolAu42vH
ndest+hlo18sw6b+124XBjJ45Kgwu+bnLbKyix8lCdi9FHyiKkiLV9AKDQ1nVCWp
cZTEK/ZoXIlQb7M4oht6PAOwLUgZXZAX5m50zB0XCzuWpxwlDexclhCB5JuDgtgJ
d7XtnhBUFIQkKBeyXMujAvtcotBjx8SrPhpDRR19v02R4PUkZB4cixrPguDbIc0x
45ApT7v4BpiXD/PEW125L/bHMRA/HkbFOgUllEK3oXo/bgUWaTujel6UZNN+f/Ey
J51cGM49Z8WxnDOchacOUwA7DQJ4HbMq8V0ilDkLY8o74a4WP30aFUz6uXAG/KW3
UnZyOp3HDWvz4UGo+RvewIVLSOO65zvJULOYRSipi+WhFX96NaPjxDM1tTDKXMvb
7rnXjr4Bin62Cvn/9ReHpKe8Vxu4DnXL1uTfFAO+2puXNjKkl6Hn5y7+FvJljXoL
aA69oCsBMBO5q8/YsKWVLhU24t4FCxCEYcMSi/nNfbLO/mP41qTtr3WbeVPAIkg6
8Sqj8PecHVsXZJIbc6fWMYl4sowVWHEvzfOpFKCBsiTEohO/41w6SfsILtpvfz8o
FqWh0SufvFSq9yNOnodj
=U4Nu
-----END PGP SIGNATURE-----

--Mndrpa8QG3Tvs5hl--

--===============4731539012398216328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4731539012398216328==--
