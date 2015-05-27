From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 5/9] ASoC: sti: Add platform driver
Date: Wed, 27 May 2015 10:48:04 +0200
Message-ID: <556584C4.3080004@st.com>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-6-git-send-email-arnaud.pouliquen@st.com>
 <20150525125002.GQ21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id A6AC7265990
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 10:48:08 +0200 (CEST)
In-Reply-To: <20150525125002.GQ21391@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 05/25/2015 02:50 PM, Mark Brown wrote:
> On Mon, May 18, 2015 at 02:12:52PM +0200, Arnaud Pouliquen wrote:
>> +	return snd_dmaengine_pcm_prepare_slave_config(substream, params,
>> +						     &dma_params->slave_config);
>
> You're using dmaengine but at least one of the earlier patches supplied
> a snd_pcm_hardware - the dmaengine code should be able to figure out
> constraints from the dmaengine driver in current code, is that causing
> you problems?
>
>> +static int sti_pcm_trigger(struct snd_pcm_substream *substream,
>> +			   int cmd)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +	struct sti_pcm_dma_params *params = runtime->private_data;
>> +	enum dma_transfer_direction direction;
>> +	struct dma_async_tx_descriptor *desc;
>> +	unsigned long flags = DMA_CTRL_ACK;
>> +	int ret = 0;
>> +
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +		direction = snd_pcm_substream_to_dma_direction(substream);
>> +
>> +		desc = dmaengine_prep_dma_cyclic(
>> +				params->dma_channel,	runtime->dma_addr,
>> +				snd_pcm_lib_buffer_bytes(substream),
>> +				snd_pcm_lib_period_bytes(substream),
>> +				direction, flags);
>
> Can you use snd_dmaengine_pcm_trigger?
>
>> +static snd_pcm_uframes_t sti_pcm_pointer(struct snd_pcm_substream *substream)
>> +{
>
> snd_dmaengine_pcm_pointer()?
>
As dmaengine_pcm_runtime_data is static, in this case i need to use also 
all the other ops function. i tried this before without success.
But as i don't remember the reason , I will test it again...

>> +static int sti_platform_engine_probe(struct platform_device *pdev)
>> +{
>> +	/*
>> +	 * Driver can not use snd_dmaengine_pcm_register.
>> +	 * Reason is that DMA needs to load a firmware.
>> +	 * This firmware is loaded on request_channel from file system.
>> +	 * So can not be done in probe while alsa card enumerated before
>> +	 * file system is mounted
>> +	 */
>
> This is not the only driver with similar needs, the Intel drivers use
> firmwares as well (all the DMA is done by the DSP which needs firmware)
> and even if it were we should be able to arrange for this to work rather
> than having to open code things.  That might mean having the dmaengine
> driver requesting firmware with _nowait() and then waiting until the
> firmware appears before registering as a DMA controller for example.  We
> may also be able to have the DMA engine only load the firmware when it's
> used rather than at probe (that might allow us to keep the DMA
> controller powered off for longer which would be a power win if possible).
>
> It's not just restricted to audio either.
>

Move dmaengine_pcm_request_chan from register to open could be a good 
compromise with (i hope) no impact on drivers that already use 
soc_generic_dma_engine. This is the implementation already proposed in 
of pcm_dmaengine.c
Another issue i'm facing, is that i have one DMA channel per CPU_DAI 
instance. As simple card imposes to define CPU_DAIs in one platform 
device, i need to define specific DMA name per CPU_DAI.
What is your recommendation on this point:
Do you want that i use snd_dmaengine_pcm_register and propose 
soc_gebneric_dmaengine driver patches?
or simply reuse pcm_dmaengine helper functions as much as possible.

>> +static const struct of_device_id snd_soc_sti_match[] = {
>> +	{ .compatible = "st,sti-audio-platform", },
>> +	{},
>> +};
>
> This doesn't seem to represent actual hardware, it seems to be an
> abstraction layer between dmaengine and your DAI drivers.  This is fine
> and normal but it means the driver shouldn't appear in DT.  Take a look
> at how other drivers like Tegra or the Freescale ones handle this.
>
No sure to full understand your comment...
I checked some Tegra and Freescale drivers,look similar...with 
declaration in DT.
Should i rename file and compatible name associated to DAI name
as example sti_uniperif.c  and .compatible = "st,sti-uniperif"
