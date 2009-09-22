From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: DaVinci: Voice Codec Interface
Date: Tue, 22 Sep 2009 14:36:05 -0700
Message-ID: <20090922213604.GB4736@sirena.org.uk>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl02-sjpop.stsn.net (s-utl02-sjpop.stsn.net [72.254.0.202])
	by alsa0.perex.cz (Postfix) with SMTP id 7D8C1244E4
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 23:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2009 at 01:29:20PM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

> 1) Adds an interface needed by the voice codec CQ0093.

It'd be better to mention the specific name of the interface here to
help people find the driver.

> 2) Add an option to select internal or external codec in the DM365.

Can you not do both simultaneously?  This should probably be a separate
patch anyway, the CPU side support is a different issue from using it on
a specific board - one patch to add the driver, one patch to use it on
the EVM.

I'd also expect that changes in the EVM board file would be required?

> +#define MOD_REG_BIT(val, mask, set) do { \
> +	if (set) { \
> +		val |= mask; \
> +	} else { \
> +		val &= ~mask; \
> +	} \
> +} while (0)

Is there not a generic version of this somewhere?  It seems to be used
in quite a few drivers.

> +static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct davinci_pcm_dma_params *dma_params = dai->dma_data;
> +	struct davinci_vcif_dev *dev = dai->private_data;
> +	u32 w;
> +
> +	/* Restart the codec before setup */
> +	davinci_vcif_stop(substream);
> +	davinci_vcif_start(substream);

This seems a bit odd - I'd expect to see the start at the end of the
function if you need to do this, otherwise the interface will be running
before you've configured it?

> +	/* Determine xfer data type */
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_U8:
> +		dma_params->data_type = 0;
> +
> +		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RD_BITS_8 |
> +					DAVINCI_VCIF_CTRL_RD_UNSIGNED |
> +					DAVINCI_VCIF_CTRL_WD_BITS_8 |
> +					DAVINCI_VCIF_CTRL_WD_UNSIGNED, 1);
> +		break;

These look like the interface needs to be configured the same way in
both directions?  If that is the case then set symmetric_rates in the
DAI.

> +	.playback = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = DAVINCI_VCIF_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},

You had options for handling more formats above, shouldn't they be
included here?

> +static struct platform_driver davinci_vcif_driver = {
> +	.probe		= davinci_vcif_probe,
> +	.remove		= davinci_vcif_remove,
> +	.driver		= {
> +		.name	= "voice_codec",
> +		.owner	= THIS_MODULE,
> +	},
> +};

Might "vcif" or "davinci-vcif" be a better name?
