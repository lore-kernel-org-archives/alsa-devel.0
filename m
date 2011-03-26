From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: add SSM2604 codec driver
Date: Sat, 26 Mar 2011 12:12:39 +0000
Message-ID: <20110326121239.GC28537@opensource.wolfsonmicro.com>
References: <1281160447-10393-1-git-send-email-vapier@gentoo.org>
	<1301130440-11532-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DA6B243EB
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 13:12:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301130440-11532-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 05:07:20AM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

This mostly looks pretty good, a few issues below many of which are
style things - the namespacing one is the major one that's externally
visible.

> +static int ssm2604_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_new_controls(dapm, ssm2604_dapm_widgets,
> +				  ARRAY_SIZE(ssm2604_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, audio_conn, ARRAY_SIZE(audio_conn));

This should really use the driver data based initialisation that was
added during the last development cycle.

> +static int ssm2604_pcm_prepare(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	/* set active */
> +	snd_soc_write(codec, SSM2604_ACTIVE, ACTIVE_ACTIVATE_CODEC);

This still looks wrong - it won't handle simultaneous playback and
record properly (stopping one will stop the other) for example.  If you
were to make this register bit a DAPM supply for the DAC and ADC then
that'd do the right thing.

If the device can't support simultaneous playback and record there
should be constraints set up telling the application layer about that.

> +	case SND_SOC_BIAS_STANDBY:
> +		/* everything off except vref/vmid, */
> +		snd_soc_write(codec, SSM2604_PWR, reg | PWR_CLK_OUT_PDN);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		/* everything off, dac mute, inactive */

These comments have been cut'n'pasted and are I suspect inaccurate.

> +	/* Sync reg_cache with the hardware */
> +	for (i = 0; i < ARRAY_SIZE(ssm2604_reg); i++)
> +		snd_soc_write(codec, i, cache[i]);

There's snd_soc_cache_sync() which will do this for you.  It'll also do
additional stuff like suppress writes of default values which will speed
up resume a bit.

> +	ssm2604_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	snd_soc_write(codec, SSM2604_PWR, ssm2604->pwr_state);

I'm not sure what the pwr_state stuff is doing but shouldn't it be
handled by either DAPM or the bias level functions?

> +/* corgi i2c codec control layer */
> +static struct i2c_driver ssm2604_i2c_driver = {

Another cut'n'paste comment here.

> +	.driver = {
> +		.name = "ssm2604-codec",
> +		.owner = THIS_MODULE,

Drop the -codec from the name, it's not needed.

> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +	ret = i2c_add_driver(&ssm2604_i2c_driver);
> +	if (ret != 0) {
> +		printk(KERN_ERR "Failed to register ssm2604 I2C driver: %d\n",
> +		       ret);
> +	}
> +#endif

If the device only supports I2C then there's no need for the ifdefs.

> +/* Left ADC Volume Control (SSM2604_REG_LEFT_ADC_VOL) */
> +#define LINVOL_LIN_VOL          0x01F	/* Left Channel PGA Volume control                    */
> +#define LINVOL_LIN_ENABLE_MUTE  0x080	/* Left Channel Input Mute                            */
> +#define LINVOL_LRIN_BOTH        0x100	/* Left Channel Line Input Volume update              */
> +

Namespace any constants exported in the header - either do that or move
these and the similar constants into the driver code.
