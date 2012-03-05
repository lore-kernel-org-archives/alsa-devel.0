From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Mon, 5 Mar 2012 16:06:25 +0800
Message-ID: <20120305080623.GD16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F894103EEF
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 08:52:00 +0100 (CET)
Received: by iakh37 with SMTP id h37so5519173iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Mar 2012 23:51:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120304133818.GE3083@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 04, 2012 at 01:38:18PM +0000, Mark Brown wrote:
> On Sat, Mar 03, 2012 at 11:20:01PM +0800, Shawn Guo wrote:
> 
> > +	ret = snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
> > +						  SND_SOC_DAIFMT_NB_NF |
> > +						  SND_SOC_DAIFMT_CBM_CFM);
> 
> Initialise this from the card.  
> 
> Since none of the startup is dynamic it should all be done on DAI init
> rather than rerun each time audio is started.
> 
Ok, will move imx_sgtl5000_startup over to snd_soc_dai_link init hook.
Please let me know if this is not what you are asking for.

> > +	/* Add soc-audio device */
> > +	data->soc_audio_pdev = platform_device_alloc("soc-audio", -1);
> > +	if (!data->soc_audio_pdev) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> 
> No, use snd_soc_register_card().  soc-audio has been deprecated since
> 2.6.38.
> 
I copied it from mpc8610_hpcd driver.  Will change.

> > +static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
> > +{
> > +	struct imx_sgtl5000_data *data = dev_get_drvdata(&pdev->dev);
> > +
> > +	platform_device_unregister(data->pcm_audio_pdev);
> 
> This looks like there's a problem with the bindings, why are you
> registering the DMA device from the card?

There is a dma node in the device tree to instantiate the dma device
backed by a dmaengine driver.  As a client peripheral of that dmaengine
device, the SSI owns just a dma request/event number.  With the number
encoded in SSI node, there is no hardware resource to be claimed by
that pcm-device, so we do not have it in device tree.  Then we have
to register this device in either fsl_ssi driver or machine driver.
I chose to do something that tegra is doing, registering the pcm device
in machine driver, to keep fsl_ssi away from imx specific bits as much
as possible.

-- 
Regards,
Shawn
