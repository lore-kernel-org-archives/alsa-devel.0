From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: zx: Add zx296702 SPDIF support
Date: Fri, 1 May 2015 11:55:03 +0100
Message-ID: <20150501105503.GT22845@sirena.org.uk>
References: <1430366850-10281-1-git-send-email-jun.nie@linaro.org>
 <1430366850-10281-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7563490040490463662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A872606AC
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 12:55:19 +0200 (CEST)
In-Reply-To: <1430366850-10281-2-git-send-email-jun.nie@linaro.org>
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


--===============7563490040490463662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7MO6GK3Uow6U4uU+"
Content-Disposition: inline


--7MO6GK3Uow6U4uU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 12:07:30PM +0800, Jun Nie wrote:
> Add zx296702 SPDIF support

This is adding a new device with DT bindings but there is no bindings
document.  All new DT bindings must be documented.

> --- /dev/null
> +++ b/include/sound/zx_hdmi_audio.h
> @@ -0,0 +1,7 @@
> +#ifndef __ZX_HDMI_AUDIO_H__
> +#define __ZX_HDMI_AUDIO_H__
> +
> +int zx_hdmi_audio_cfg(int audio_codec, int audio_way,
> +		      u32 sample_rate, u32 sample_len);
> +void zx_hdmi_audio_en(int on);
> +#endif /* __ZX_HDMI_AUDIO_H__ */

So this isn't a S/PDIF controller but rather a HDMI controller and from
the looks of it one with yet another custom interface between the video
part and the audio part.  As I keep saying I'd really like to see more
code sharing between the various controllers doing this.  Please take a
look at some of the other controllers and see what can be shared, and
also at this:

 http://thread.gmane.org/gmane.comp.video.dri.devel/126588

series from Russell King.

> +config ZX296702_SPDIF
> +        bool "ZX296702 spdif"
> +	select ZX_PCM_DMA
> +        help
> +	  Say Y or M if you want to add support for codecs attached to the
> +	  zx296702 spdif interface

The indentation above looks inconsistent - probably a mix of tabs and
spaces.

> +static struct snd_dmaengine_dai_dma_data zx_spdif_pcm_stereo_out = {
> +	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
> +	.chan_name	= "tx",
> +	.maxburst	= 8,
> +};

The DMA driver said it needed custom channel names but this looks like
the standard "tx" for transmit?

> +static int zx_spdif_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct zx_spdif_info *zx_spdif = dev_get_drvdata(dai->dev);
> +
> +	snd_soc_dai_set_drvdata(dai, zx_spdif);
> +	zx_spdif_pcm_stereo_out.addr = zx_spdif->mapbase + ZX_DATA;
> +	snd_soc_dai_init_dma_data(dai, &zx_spdif_pcm_stereo_out, NULL);
> +	return 0;
> +}

This appears to be modifying a global variable rather than some driver
data, please don't do that - store anything discovered per device at
runtime in the driver datta.

> +static void zx_spdif_chanstats(void __iomem *base, unsigned int rate)
> +{
> +	u32 cstas1;
> +
> +	switch (rate) {
> +	case 22050:

> +	default:
> +		return;
> +	}

This should handle and report errrors, not ignore them.

> +		return -EINVAL;
> +	}
> +	if (2 == params_channels(params))
> +		val |= ZX_CTRL_DOUBLE_TRACK;
> +	else
> +		val |= ZX_CTRL_LEFT_TRACK;
> +	writel_relaxed(val, zx_spdif->reg_base + ZX_CTRL);

Missing blank line between this and the above block and please reverse
the arguments for the == - it's the more normal kernel coding style.

> +#if defined(CONFIG_ZX_HDMI_SND_SPDIF)
> +	sample_len = params_physical_width(params);
> +	zx_hdmi_audio_cfg(1, 0, params_rate(params), sample_len);
> +#endif

But this is the S/PDIF dirver...  in any case, this looks like something
that depends on the hardware rather than something that should be a
compile time option.  We should be able to boot the same kernel on many
systems.

> +	val = readl_relaxed(base + ZX_CTRL);
> +	val &= ~(ZX_CTRL_ENB_MASK | ZX_CTRL_TX_MASK);
> +	val |= on ? (ZX_CTRL_TX_OPEN | ZX_CTRL_ENB)
> +		: (ZX_CTRL_TX_CLOSE | ZX_CTRL_DNB);
> +	writel_relaxed(val, base + ZX_CTRL);

Please don't use the ternery operator like this, it does nothing for
legibility.

> +	if (clk_prepare_enable(zx_spdif->dai_clk))
> +		return -EIO;

Don't discard return values, pass them back.  You should probably also
be managing this clock at runtime to save power.

> +					 &zx_spdif_dai, 1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Register DAI failed\n");

Print error codes as well.

--7MO6GK3Uow6U4uU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ1uGAAoJECTWi3JdVIfQJbwH/3yCZaR9ZINGe3KgnnRz00oB
eOGXnv5Y8AsMyIV8xsT5UedqFSTX/8ZIzLDvesGs0ycrEJdi13c8VavrLGLchijN
KwtLAeh6ip7qYK7LpJwK1uT0MpdIP9Z9G4VvyNehB/bQrv7c6gTKJCUbdRQFc+Po
lWyLw00jdmqi1axbGIZlvdPZI2oh3Qw8UeanJwK+O4BtByOruoglHD/QoiLB17eW
jKsyxg5HFZ9dGsnXG1z2pX+WmHESRTpuR9O7heVS0+IcJIzAMGyz4EJo9gD6hXtQ
FBvQ3fRL3u92GrErgs+oUwLSFnqDaFrpYh7itKct7+OyZqAXWqHTyD1G9C3klNc=
=y4+B
-----END PGP SIGNATURE-----

--7MO6GK3Uow6U4uU+--

--===============7563490040490463662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7563490040490463662==--
