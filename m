From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] blackfin I2S(TDM mode) CPU DAI driver
Date: Sat, 25 Jul 2009 13:49:09 +0100
Message-ID: <20090725124909.GA7284@opensource.wolfsonmicro.com>
References: <1248286234-6053-1-git-send-email-21cnbao@gmail.com>
	<1248286234-6053-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BABD1037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Jul 2009 14:49:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248286234-6053-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 02:10:33AM +0800, Barry Song wrote:

> On the one hand, I2S and TDM means two completely different interface
> configuration to blackfin, results in completely different hardware
> configuration, DMA description and data transfer flow. Merging them as a
> whole will be very ugly and difficult to maintain.

I'm still a bit confused about why this is required - I'm not sure where
the requirement for the changes in the DMA layout come from. 

Looking at the code it appears that the main difference is that your TDM
mode always configures the DMA layout for 8 channel blocks.  This
appears to be because the SPORT code requires that you specify the block
size statically when you call sport_init().  Looking at the code it
seems like the SPORT hardware is capable of changing the memory layout
on the fly (at least, all this stuff appears to be written down by
software at various points during setup so I'd expect it to be changable
at runtime) and that the restrictions here are due to the SPORT API
rather than the hardware itself?

If that is the case then would it not be better to refactor the SPORT
API so that it is capable of changing the configuration on the fly and
then update the existing I2S driver to be able to take advantage of
that?  This would reduce the amount of code duplication here and I'd
expect it to also make things run more efficiently when less than 8
channels are in use in TDM mode.

> On the other hand, hardware board connection decides the I2S/TDM mode
> directly. It's needless to switch between I2S and TDM dynamically. For
> TDM mode, board driver can refer to the TDM instance, for I2S mode,

Are you saying that a physically different SPORT or other hardware
configuration on the CPU is required to use TDM mode?  The impression
given by the drivers has always been that this is some kind of generic
synchronous serial port and the way the SPORT number is set up seems to
support that.  Could you go into more detail here, please - this would
be a very unusual implementation decision for a CPU.

> +	if (sport_handle != NULL)
> +		runtime->private_data = sport_handle;
> +	else {
> +		pr_err("sport_handle is NULL\n");
> +		return -1;
> +	}

Should return a real error code here.

> +int bf5xx_pcm_tdm_new(struct snd_card *card, struct snd_soc_dai *dai,
> +	struct snd_pcm *pcm)
> +{

This should be static; any functions that are exported via operations
structures should be static.

> +static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params,
> +	struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +
> +	bf5xx_tdm.tcr2 &= ~0x1f;
> +	bf5xx_tdm.rcr2 &= ~0x1f;
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		bf5xx_tdm.tcr2 |= 31;
> +		bf5xx_tdm.rcr2 |= 31;
> +		sport_handle->wdsize = 4;
> +		break;
> +		/* at present, we only support 32bit transfer */
> +	default:
> +		pr_err("not supported PCM format yet\n");
> +		break;

This should return an error.

> +static int __devinit bfin_tdm_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +
> +	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
> +		pr_err("Requesting Peripherals failed\n");
> +		return -EFAULT;
> +	}

> +static struct platform_driver bfin_tdm_driver = {
> +	.probe  = bfin_tdm_probe,
> +	.remove = __devexit_p(bfin_tdm_remove),
> +	.driver = {
> +		.name   = "bfin-sport",
> +		.owner  = THIS_MODULE,
> +	},
> +};

This isn't a good name for the driver - all of the Blackfin CPU audio
drivers and probably some others use a SPORT so the same driver name
would apply for each of them.  If more than one of these drivers chose
the same name then you'd not be able to have both drivers in the kernel
at once.  The driver name should be something that's specific to the
device you're trying to register, such as bfin-tdm.
