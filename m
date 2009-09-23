From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 2/4] ASoC: DaVinci: Voice Codec Interface
Date: Wed, 23 Sep 2009 09:18:42 -0600
Message-ID: <4ABA3C52.6010509@ridgerun.com>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922213604.GB4736@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 04AC5103862
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 17:19:12 +0200 (CEST)
In-Reply-To: <20090922213604.GB4736@sirena.org.uk>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Sep 22, 2009 at 01:29:20PM -0600, miguel.aguilar@ridgerun.com wrote:
>> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
>> 1) Adds an interface needed by the voice codec CQ0093.
> 
> It'd be better to mention the specific name of the interface here to
> help people find the driver.
[MA] ok.
> 
>> 2) Add an option to select internal or external codec in the DM365.
> 
> Can you not do both simultaneously?  This should probably be a separate
> patch anyway, the CPU side support is a different issue from using it on
> a specific board - one patch to add the driver, one patch to use it on
> the EVM.
> 
> I'd also expect that changes in the EVM board file would be required?
[MA] No external and internal codecs can not coexists since they share the same 
DMA channels for TX and RX, so the TI recommendation was choose one codec or the 
other one by the configuration menu.

Actually, This patch series have a separate patch for the driver, vcif, SoC 
specific code, and EVM specific code.
> 
>> +#define MOD_REG_BIT(val, mask, set) do { \
>> +	if (set) { \
>> +		val |= mask; \
>> +	} else { \
>> +		val &= ~mask; \
>> +	} \
>> +} while (0)
> 
> Is there not a generic version of this somewhere?  It seems to be used
> in quite a few drivers.
[MA] I will take a look if this is available some header that I can include.
> 
>> +static int davinci_vcif_hw_params(struct snd_pcm_substream *substream,
>> +				 struct snd_pcm_hw_params *params,
>> +				 struct snd_soc_dai *dai)
>> +{
>> +	struct davinci_pcm_dma_params *dma_params = dai->dma_data;
>> +	struct davinci_vcif_dev *dev = dai->private_data;
>> +	u32 w;
>> +
>> +	/* Restart the codec before setup */
>> +	davinci_vcif_stop(substream);
>> +	davinci_vcif_start(substream);
> 
> This seems a bit odd - I'd expect to see the start at the end of the
> function if you need to do this, otherwise the interface will be running
> before you've configured it?
[MA] The voice codec interface should be restarted before set the hw params. If 
you don't do this you will get underrun and overrun errors due to lack of the 
restarting process. Thats why I do a stop and then a start. I tried to include 
the prepare function however it is called after the hw params function, and that 
doesn't make sense.
> 
>> +	/* Determine xfer data type */
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_U8:
>> +		dma_params->data_type = 0;
>> +
>> +		MOD_REG_BIT(w, DAVINCI_VCIF_CTRL_RD_BITS_8 |
>> +					DAVINCI_VCIF_CTRL_RD_UNSIGNED |
>> +					DAVINCI_VCIF_CTRL_WD_BITS_8 |
>> +					DAVINCI_VCIF_CTRL_WD_UNSIGNED, 1);
>> +		break;
> 
> These look like the interface needs to be configured the same way in
> both directions?  If that is the case then set symmetric_rates in the
> DAI.
[MA]I think it should be symmetric, so the TX and RX should be configured in the 
same way.
> 
>> +	.playback = {
>> +		.channels_min = 1,
>> +		.channels_max = 2,
>> +		.rates = DAVINCI_VCIF_RATES,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
> 
> You had options for handling more formats above, shouldn't they be
> included here?
[MA] I'll check this.
> 
>> +static struct platform_driver davinci_vcif_driver = {
>> +	.probe		= davinci_vcif_probe,
>> +	.remove		= davinci_vcif_remove,
>> +	.driver		= {
>> +		.name	= "voice_codec",
>> +		.owner	= THIS_MODULE,
>> +	},
>> +};
> 
> Might "vcif" or "davinci-vcif" be a better name?
[MA]To use that name I should change the name of the clock, however that clock 
is actually for the whole voice codec module, both voice codec and voice codec 
interface. The voice codec interface is just a logical separation of the voice 
codec module.

Thanks,

Miguel Aguilar
