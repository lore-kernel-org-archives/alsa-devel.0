From: "chaithrika" <chaithrika@ti.com>
Subject: Re: [PATCH v4 2/4] ARM: DaVinci: ASoC: Introduce
	platform driver model for dm644x, dm355
Date: Mon, 8 Jun 2009 16:49:48 +0530
Message-ID: <010601c9e82b$0909e150$1b1da3f0$@com>
References: <1244197703-30980-1-git-send-email-chaithrika@ti.com>
	<4A296524.9050505@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 40A7E10380A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 13:19:37 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58BJVIJ008154
	for <alsa-devel@alsa-project.org>; Mon, 8 Jun 2009 06:19:36 -0500
Received: from tidmzi-ftp.india.ext.ti.com (localhost [127.0.0.1])
	by dflp53.itg.ti.com (8.13.8/8.13.8) with SMTP id n58BJTvH008640
	for <alsa-devel@alsa-project.org>; Mon, 8 Jun 2009 06:19:30 -0500 (CDT)
Received: from symphonyindia.ti.com (symphony-ftp [192.168.247.11])
	by tidmzi-ftp.india.ext.ti.com (Postfix) with SMTP id 971BA3886B
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2009 16:46:50 +0530 (IST)
In-Reply-To: <4A296524.9050505@boundarydevices.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Troy Kisky' <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, 'Naresh Medisetty' <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 06, 2009 at 00:04:12, Troy Kisky wrote:
> Chaithrika U S wrote:
> > Introduce the platform driver model to get platform data for dm355 and
dm644x.
> > Register platform driver and acquire the resources in the probe function
Since
> > the platform specific code had been moved from machine driver to
dm<soc>.c
> > 
> > Signed-off-by: Naresh Medisetty <naresh@ti.com>
> > Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> > ---
> > This patch applies against ALSA mainline - that's the topic/asoc
> > branch of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > 
> >  sound/soc/davinci/davinci-i2s.c |  117
++++++++++++++++++++++-----------------
> >  1 files changed, 67 insertions(+), 50 deletions(-)
> > 
> > diff --git a/sound/soc/davinci/davinci-i2s.c
b/sound/soc/davinci/davinci-i2s.c
> > index b1ea52f..500d2f5 100644
> > --- a/sound/soc/davinci/davinci-i2s.c
> > +++ b/sound/soc/davinci/davinci-i2s.c
> > @@ -436,16 +436,40 @@ static int davinci_i2s_trigger(struct
snd_pcm_substream *substream, int cmd,
> >  	return ret;
> >  }
> >  
> > -static int davinci_i2s_probe(struct platform_device *pdev,
> > -			     struct snd_soc_dai *dai)
> > +#define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
> > +
> > +static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
> > +	.startup 	= davinci_i2s_startup,
> > +	.trigger	= davinci_i2s_trigger,
> > +	.hw_params	= davinci_i2s_hw_params,
> > +	.set_fmt	= davinci_i2s_set_dai_fmt,
> > +
> > +};
> > +
> > +struct snd_soc_dai davinci_i2s_dai = {
> > +	.name = "davinci-i2s",
> > +	.id = 0,
> > +	.playback = {
> > +		.channels_min = 2,
> > +		.channels_max = 2,
> > +		.rates = DAVINCI_I2S_RATES,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> > +	.capture = {
> > +		.channels_min = 2,
> > +		.channels_max = 2,
> > +		.rates = DAVINCI_I2S_RATES,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> > +	.ops = &davinci_i2s_dai_ops,
> > +
> > +};
> > +EXPORT_SYMBOL_GPL(davinci_i2s_dai);
> > +
> > +static int davinci_i2s_probe(struct platform_device *pdev)
> >  {
> > -	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> > -	struct snd_soc_card *card = socdev->card;
> > -	struct snd_soc_dai *cpu_dai = card->dai_link->cpu_dai;
> > +	struct snd_platform_data *pdata = pdev->dev.platform_data;
> >  	struct davinci_mcbsp_dev *dev;
> > -	struct resource *mem, *ioarea;
> > -	struct evm_snd_platform_data *pdata;
> > -	int ret;
> > +	struct resource *mem, *ioarea, *res;
> > +	int ret = 0;
> 
> I would leave this as int ret;
OK.

> >  
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!mem) {
> > @@ -466,9 +490,7 @@ static int davinci_i2s_probe(struct platform_device
*pdev,
> >  		goto err_release_region;
> >  	}
> >  
> > -	cpu_dai->private_data = dev;
> > -
> > -	dev->clk = clk_get(&pdev->dev, NULL);
> > +	dev->clk = clk_get(&pdev->dev, pdata->clk_name);
> >  	if (IS_ERR(dev->clk)) {
> >  		ret = -ENODEV;
> >  		goto err_free_mem;
> > @@ -476,18 +498,35 @@ static int davinci_i2s_probe(struct
platform_device *pdev,
> >  	clk_enable(dev->clk);
> >  
> >  	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
> > -	pdata = pdev->dev.platform_data;
> >  
> >  	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &davinci_i2s_pcm_out;
> > -	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel =
pdata->tx_dma_ch;
> >  	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->dma_addr =
> >  	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DXR_REG);
> >  
> >  	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE] = &davinci_i2s_pcm_in;
> > -	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel =
pdata->rx_dma_ch;
> >  	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->dma_addr =
> >  	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DRR_REG);
> >  
> > +	/* first TX, then RX */
> > +	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "no DMA resource\n");
> 
> And set ret = -EIO; or something similar here.
> 
> > +		goto err_free_mem;
> > +	}
> > +	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = res->start;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "no DMA resource\n");
> 
> And here
> 

OK. I will update these.

Thanks,
Chaithrika
