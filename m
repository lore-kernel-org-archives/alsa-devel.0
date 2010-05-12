From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: [patch 5/6] kirkwood: Add i2s support
Date: Wed, 12 May 2010 16:38:25 +0200
Message-ID: <m339xxuqvy.fsf@anduin.mandriva.com>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.475198903@mandriva.com>
	<20100512102419.GF4330@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.moondrake.net [212.85.150.166])
	by alsa0.perex.cz (Postfix) with ESMTP id EAD181038A2
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 16:38:17 +0200 (CEST)
In-Reply-To: <20100512102419.GF4330@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Wed, 12 May 2010 11:24:19 +0100")
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
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Tue, May 11, 2010 at 06:23:47PM +0200, apatard@mandriva.com wrote:
>> This patch enables support for the i2s codec available on kirkwood platforms
>
> It's not a CODEC, it's the I2S controller in the CPU.  A CODEC is a
> device with DACs and ADCs in it.
>
>> +	do {
>> +		/* we've enabled only bytes interrupts ... */
>
> You were checking for error interrupts further up the function?
>
>> +		if (status & ~(KIRKWOOD_INT_CAUSE_PLAY_BYTES | \
>> +				KIRKWOOD_INT_CAUSE_REC_BYTES))
>> +			return IRQ_NONE;
>
> Surely it'd make sense to log the unexpected interrupts for diagnostics?
> You should never get here if there are no interrupts you've enabled.
> Unless the interrupt is shared, but that'd be a bit surprising for a
> SoC.

it's not shared iirc but there are different possible interrupt
cause. There used to be a message but I think it has been removed by
error. Should I had it back or remove the check ? (I prefer adding it
back but your point of view does matter).

>
> It also looks like it'd be more sensible to either drop the do/while
> loop entirely (the IRQ core should handle the interrupt still being
> asserted and it doesn't look like any of the handling should take so
> long that interrupts reassert while it's running anyway) or move the
> handling of error interrupts and the first read into the loop so you
> don't have two slightly different paths.

The loop is there to handle playback and record interrupts at the same
time. As regards the error interrupts, I preferred to put outside the
loop to differentiate "normal" interrupts from "error" interrupts.

>
>> +		/* ack int */
>> +		writel(status, priv->io + KIRKWOOD_INT_CAUSE);
>> +
>> +		if (status & KIRKWOOD_INT_CAUSE_PLAY_BYTES)
>> +			snd_pcm_period_elapsed(prdata->play_stream);
>> +
>> +		if (status & KIRKWOOD_INT_CAUSE_REC_BYTES)
>> +			snd_pcm_period_elapsed(prdata->rec_stream);
>> +
>> +		mask = readl(priv->io + KIRKWOOD_INT_MASK);
>> +		status = readl(priv->io + KIRKWOOD_INT_CAUSE) & mask;
>
> This masking didn't happen prior to the first entry into the loop.

Can you explain a little bit more ? at the beginning of the function,
there are the 2 same lines.

>
>> +       if (soc_runtime->dai->cpu_dai->private_data == NULL) {
>
> It seems a bit icky to be managing the DAI private data here...
>
>> +		err = request_irq(priv->irq, kirkwood_dma_irq, IRQF_SHARED,
>> +				  "kirkwood-dma", prdata);
>
> I'd suggest "kirkwood-i2s" as a name here.  Or take the name from the
> DAI.

ok

>
>> +static int kirkwood_dma_trigger(struct snd_pcm_substream *substream, int cmd)
>> +{
>> +	return 0;
>> +}
>
> Remove this if it's not implemented.
>
>> +static int kirkwood_dma_mmap(struct snd_pcm_substream *substream,
>> +		struct vm_area_struct *vma)
>> +{
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +
>> +	return dma_mmap_coherent(substream->pcm->card->dev, vma,
>> +					runtime->dma_area,
>> +					runtime->dma_addr,
>> +					runtime->dma_bytes);
>> +}
>
> Hrm, this looks like there should be a utility function to do it, it's
> not terribly driver specific.

hmm... I need to double check. I got some troubles with this kind of
stuff on my ST LS2E/F mips platforms, so I wrote something known to be
working.

>
>> +struct snd_soc_platform kirkwood_soc_platform = {
>> +	.name		= "kirkwood-dma",
>
> I'd also add an audio in here or something.
>
>> +#define AUDIO_WIN_BASE_REG(win)			(0xA00 + ((win)<<3))
>> +#define AUDIO_WIN_CTRL_REG(win)			(0xA04 + ((win)<<3))
>
> Namespacing.  Or move into the driver, there seems little reason for
> anything else to be peering at these.
>
>> +#define KIRKWOOD_RATES \
>> +	(SNDRV_PCM_RATE_44100 | \
>> +	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
>> +#define KIRKWOOD_FORMATS \
>> +	(SNDRV_PCM_FMTBIT_S16_LE | \
>> +	 SNDRV_PCM_FMTBIT_S24_LE | \
>> +	 SNDRV_PCM_FMTBIT_S32_LE)
>
> Move these into the driver.
>
>> +static inline void kirkwood_set_dco(void __iomem *io, unsigned long rate)
>> +{
>> +	unsigned long value;
>> +
>> +	value = KIRKWOOD_DCO_CTL_OFFSET_0;
>> +	switch (rate) {
>> +	default:
>> +	case 44100:
>> +		value |= KIRKWOOD_DCO_CTL_FREQ_11;
>> +		break;
>> +	case 48000:
>> +		value |= KIRKWOOD_DCO_CTL_FREQ_12;
>> +		break;
>> +	case 96000:
>> +		value |= KIRKWOOD_DCO_CTL_FREQ_24;
>> +		break;
>> +	}
>> +	writel(value, io + KIRKWOOD_DCO_CTL);
>> +
>> +	/* wait for dco locked */
>> +	do {
>> +		cpu_relax();
>> +		value = readl(io + KIRKWOOD_DCO_SPCR_STATUS);
>> +		value &= KIRKWOOD_DCO_SPCR_STATUS;
>> +	} while (value == 0);
>> +}
>
> Why is this an inline function in the header?
>
>> +	 * Size settings in play/rec i2s control regs and play/rec control
>> +	 * regs must be the same.
>> +	 */
>
> Ideally you'd be setting up constraints for this.
>
>> +	/*
>> +	 * specs says KIRKWOOD_PLAYCTL must be read 2 times before
>> +	 * changing it. So read 1 time here and 1 later.
>> +	 */
>> +	value = readl(priv->io + KIRKWOOD_PLAYCTL);
>
> Nice...
>
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +		/* stop audio, enable interrupts */
>
> If audio is running when you're getting a start trigger something is
> wrong...

I'm too paranoid ? here

>
>> +static int kirkwood_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
>> +				int clk_id, unsigned int freq, int dir)
>> +{
>> +	return 0;
>> +}
>
> Remove this.
>
>> +static void mv_audio_init(void __iomem *base)
>> +{
>> +	int timeout = 10000000;
>> +	unsigned int reg_data;
>> +
>> +	reg_data = readl(base + 0x1200);
>> +	reg_data &= (~(0x333FF8));
>> +	reg_data |= 0x111D18;
>> +	writel(reg_data, base + 0x1200);
>
> It's like magic!

yeah. I've not been able to find out any info in the specs about that
and last time I tried with that it was not working :(

>
>> +
>> +	do {
>> +		timeout--;
>> +	} while (timeout);
>
> The driver is busy waiting here but not polling anything.  Just use a
> sleep?
>
>> +	/* FIXME : should not be hardcoded */
>> +	priv->burst = 128;
>
> Platform data?
>
>> +static int kirkwood_i2s_probe(struct platform_device *pdev,
>> +                            struct snd_soc_dai *dai)
>
> This is the ASoC probe but...
>
> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> ...it's pulling all sorts of resources out of the device which are
> specific to the I2S controller.  You should have the I2S controller have
> a normal platform device which is probed on system startup and triggers
> DAI registration, just as you're doing in the CODEC driver.  All the
> resources should be there.  Apart from anything else this means you only
> need to set up each I2S controller once in the arch/arm code for the
> CPU.

ok. Will look at that stuff.

>
>> +	mv_audio_init(priv->io);
>
> Seems a bit odd ot have the separate init function in the middle of a
> bunch of other register writes.

I want to have interrupts disable before calling it. I don't want bad
suprises.


Arnaud
