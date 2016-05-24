From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Tue, 24 May 2016 18:07:14 +0100
Message-ID: <57448A42.9050606@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
 <20160524164151.GM8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524164151.GM8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for your comments.

On 24-05-2016 17:41, Mark Brown wrote:
> On Mon, May 23, 2016 at 11:02:24AM +0100, Jose Abreu wrote:
>
>> +config SND_DESIGNWARE_PCM
>> +	bool "PCM PIO extension for I2S driver"
> Why can't this be built as a module?

I can change but my intention was to make this PCM a kind of extension to the
driver instead of adding a new module to the system.

>
>> +
>> +	return irq_valid ? IRQ_HANDLED : IRQ_NONE;
> Please write a normal if statement, the ternery operator doesn't help
> legibility.

Ok.

>
>>  static void i2s_start(struct dw_i2s_dev *dev,
>>  		      struct snd_pcm_substream *substream)
>>  {
>>  	struct i2s_clk_config_data *config = &dev->config;
>>  
>>  	i2s_write_reg(dev->i2s_base, IER, 1);
>> -	i2s_enable_irqs(dev, substream->stream, config->chan_nr);
>> +
>> +	if (dev->use_pio)
>> +		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
>>  
>>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>  		i2s_write_reg(dev->i2s_base, ITER, 1);
> That seems wrong, or at least something that should be separate?
> Previously we needed interrupts for DMA operation but now we enable
> interrupts only if we don't use DMA.  It feels like we want to make the
> change for DMA separately if only to make it clear for bisection, are we
> 100% sure that masking the interrupt won't also mask the DMA request
> signals?

Indeed I thought about this and the interrupts must also be enabled when in DMA
mode. Although there is no interrupt handler in the original driver (without
this patches) in some setups the interrupt line may be connected to the DMA
controller. I will drop this change and always enable interrupts. Please note
that I don't have a setup with DMA support so I can only test using the PIO mode.

>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq >= 0) {
>> +		dev_dbg(&pdev->dev, "using PIO mode\n");
>> +		dev->use_pio = true;
>> +
>> +		ret = devm_request_irq(&pdev->dev, irq, i2s_irq_handler, 0,
>> +				pdev->name, dev);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "failed to request irq\n");
>> +			return ret;
>> +		}
>> +	}
> This also seems wrong.  We're forcing PIO if an interrupt is provided
> rather than based on DMA being configured which means that if the
> interrupt is wired up and happens to be described in DT we'll get worse
> performance.  People should be able to just describe the system without
> worrying about this, and we might find some other use for the interrupts
> in future.  Indeed right now it would probably be reasonable to use the
> error interrupts all the time if they're available.

How should I then determine which mode to use?
    - Check if DMA parameters are declared in DT, or
    - Check if snd_dmaengine_pcm_register() fails, or
    - Assume PIO mode will be used when compiling with PIO PCM, or
    - Something else ?

Best regards,
Jose Miguel Abreu
