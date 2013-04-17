From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
 driver
Date: Wed, 17 Apr 2013 11:48:08 +0200
Message-ID: <516E6FD8.5040400@ti.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 661122615FA
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 11:48:16 +0200 (CEST)
In-Reply-To: <1366046404-8759-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/15/2013 07:19 PM, Lars-Peter Clausen wrote:
> This patch adds a generic dmaengine PCM driver. It builds on top of the
> dmaengine PCM library and adds the missing pieces like DMA channel manage=
ment,
> buffer management and channel configuration. It will be able to replace t=
he
> majority of the existing platform specific dmaengine based PCM drivers.
> Devicetree is used to map the DMA channels to the PCM device.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> +static const char * const dmaengine_pcm_dma_channel_names[] =3D {
> +	[SNDRV_PCM_STREAM_PLAYBACK] =3D "tx",
> +	[SNDRV_PCM_STREAM_CAPTURE] =3D "rx",
> +};

> +
> +/**
> + * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
> + * @dev: The parent device for the PCM device
> + * @config: Platform specific PCM configuration
> + * @flags: Platform specific quirks
> + */
> +int snd_dmaengine_pcm_register(struct device *dev,
> +	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
> +{
> +	struct dmaengine_pcm *pcm;
> +	unsigned int i;
> +
> +	if (!dev->of_node)
> +		return -EINVAL;
> +
> +	pcm =3D kzalloc(sizeof(*pcm), GFP_KERNEL);
> +	if (!pcm)
> +		return -ENOMEM;
> +
> +	pcm->config =3D config;
> +
> +	for (i =3D SNDRV_PCM_STREAM_PLAYBACK; i <=3D SNDRV_PCM_STREAM_CAPTURE; =
i++) {
> +		pcm->chan[i] =3D of_dma_request_slave_channel(dev->of_node,
> +					dmaengine_pcm_dma_channel_names[i]);

Here we should have flexibility to provide custom DMA channel names. For OM=
AP4
AESS support (which I'm cleaning up right now for upstream) will need such a
flexibility since we will have 8 DMA channels and none of them is dedicated=
 tx
or rx.

> +	}
> +
> +	return snd_soc_add_platform(dev, &pcm->platform,
> +				&dmaengine_pcm_platform);
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
> +
> +/**
> + * snd_dmaengine_pcm_unregister - Removes a dmaengine based PCM device
> + * @dev: Parent device the PCM was register with
> + *
> + * Removes a dmaengine based PCM device previously registered with
> + * snd_dmaengine_pcm_register.
> + */
> +void snd_dmaengine_pcm_unregister(struct device *dev)
> +{
> +	struct snd_soc_platform *platform;
> +	struct dmaengine_pcm *pcm;
> +	unsigned int i;
> +
> +	platform =3D snd_soc_lookup_platform(dev);
> +	if (!platform)
> +		return;
> +
> +	pcm =3D soc_platform_to_pcm(platform);
> +
> +	for (i =3D SNDRV_PCM_STREAM_PLAYBACK; i <=3D SNDRV_PCM_STREAM_CAPTURE; =
i++) {
> +		if (pcm->chan[i])
> +			dma_release_channel(pcm->chan[i]);
> +	}
> +
> +	snd_soc_remove_platform(platform);
> +	kfree(pcm);
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
> +
> +MODULE_LICENSE("GPL");
> =



-- =

P=E9ter
