From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 2/8] sound:asoc: Add support for synopsys
 i2s controller as per ASoC framework.
Date: Mon, 26 Mar 2012 14:33:22 +0530
Message-ID: <4F7030DA.2090009@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<7692a51789abe38e7066a582d8329dc93b8eced3.1332242166.git.rajeev-dlh.kumar@st.com>
	<20120320154420.GE3445@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AE67103D57
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 11:02:51 +0200 (CEST)
In-Reply-To: <20120320154420.GE3445@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, spear-devel <spear-devel@list.st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark

On 3/20/2012 9:14 PM, Mark Brown wrote:
> On Tue, Mar 20, 2012 at 05:03:46PM +0530, Rajeev Kumar wrote:
>> This patch add support for synopsys I2S controller as per the ASoC framework.
>
> If this really is a generic Synopsys block shouldn't it be in a Synopsys
> directory, possibly with a wrapper in the SPEAr directory for the
> platform integration?
>

I will create a new directory by name dwc.

>> +struct i2s_platform_data {
>> +	#define PLAY	(1<<  0)
>> +	#define RECORD	(1<<  1)
>
> Namespacing here and with most of the other defines in the header (and
> the driver, though the ones in the code are less important).  Normally
> ALSA headers go in include/sound.
>

OK I will move it in include/sound/.
Next Patch will contains name spacing also.

>> +
>> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		i2s_write_reg(dev->i2s_base, TCR(ch), dev->xfer_resolution);
>> +		i2s_write_reg(dev->i2s_base, TFCR(ch), 0x02);
>> +		irq = i2s_read_reg(dev->i2s_base, IMR(ch));
>> +		i2s_write_reg(dev->i2s_base, IMR(ch), irq&  ~0x30);
>> +		i2s_write_reg(dev->i2s_base, TER(ch), 1);
>> +	} else {
>> +		i2s_write_reg(dev->i2s_base, RCR(ch), dev->xfer_resolution);
>> +		i2s_write_reg(dev->i2s_base, RFCR(ch), 0x07);
>> +		irq = i2s_read_reg(dev->i2s_base, IMR(ch));
>> +		i2s_write_reg(dev->i2s_base, IMR(ch), irq&  ~0x03);
>> +		i2s_write_reg(dev->i2s_base, RER(ch), 1);
>> +	}
>
> It would be good to split out the bits that are common from the bits
> that vary per stream.
>

OK,


>> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		for (i = 0; i<  4; i++)
>> +			i2s_write_reg(dev->i2s_base, TER(i), 0);
>> +	} else {
>> +		for (i = 0; i<  4; i++)
>> +			i2s_write_reg(dev->i2s_base, RER(i), 0);
>
> Magic numbers!
>

will be replaced with macro

>> +static irqreturn_t dw_i2s_play_irq(int irq, void *_dev)
>> +{
>> +	struct dw_i2s_dev *dev = (struct dw_i2s_dev *)_dev;
>> +	u32 ch0, ch1;
>> +
>> +	/* check for the tx data overrun condition */
>> +	ch0 = i2s_read_reg(dev->i2s_base, ISR(0))&  0x20;
>> +	ch1 = i2s_read_reg(dev->i2s_base, ISR(1))&  0x20;
>> +	if (ch0 || ch1) {
>> +		/* disable i2s block */
>> +		i2s_write_reg(dev->i2s_base, IER, 0);
>> +
>> +		/* disable tx block */
>> +		i2s_write_reg(dev->i2s_base, ITER, 0);
>> +
>> +		/* flush all the tx fifo */
>> +		i2s_write_reg(dev->i2s_base, TXFFR, 1);
>> +
>> +		/* clear tx data overrun interrupt */
>> +		i2s_clear_irqs(dev, SNDRV_PCM_STREAM_PLAYBACK);
>> +
>> +		/* enable rx block */
>> +		i2s_write_reg(dev->i2s_base, ITER, 1);
>> +
>> +		/* enable i2s block */
>> +		i2s_write_reg(dev->i2s_base, IER, 1);
>> +	}
>
> This is somewhat unusual - normally ALSA detects underrun and overrun
> and restarts the stream at the application layer.  This looks like it
> attempts to mask information about errors from the application which
> probably isn't waht we want to do.  Why is the normal ALSA handling not5
> sufficient?
>

Normal ALSA handling is sufficient for underrun and overrun. This 
handler is not required.

>> +
>> +	return IRQ_HANDLED;
>
> This unconditionally says it handled the interrupt even if it didn't.
>

Removing handler will remove this too.

>> +static int
>> +dw_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai)
>> +{
>> +	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
>> +	struct dma_data *dma_data = NULL;
>> +
>> +	if (!(dev->capability&  RECORD)&&
>> +			(substream->stream == SNDRV_PCM_STREAM_CAPTURE))
>> +		return -EINVAL;
>
> Indentation.
>

Ok

>> +
>> +	if (dev->i2s_clk_cfg) {
>> +		if (dev->i2s_clk_cfg(config)) {
>> +			dev_err(dev->dev, "runtime audio clk config fail\n");
>> +			if (cpu_dai->driver->ops->trigger) {
>> +				int ret =
>> +					cpu_dai->driver->ops->trigger(substream,
>> +							SNDRV_PCM_TRIGGER_STOP,
>> +							cpu_dai);
>> +				if (ret<  0) {
>> +					dev_err(dev->dev,
>> +							"trigger stop fail\n");
>> +					return ret;
>> +				}
>> +			}
>
> No, return an error if you encounter an error!
>

You need not to stop controller in case clock fail ?


>> +static void
>> +dw_i2s_shutdown(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>
> Indentation - throughout the kernel the type goes on the same line asi2s
> the function name.
>

Ok

>> +static const struct dev_pm_ops dw_i2s_dev_pm_ops = {
>> +	.suspend = dw_i2s_suspend,
>> +	.resume = dw_i2s_resume,
>> +};
>
> No, do this at the ASoC level like other CPU drivers (runtime PM
> callbacks are OK).
>

Ok,

>> +	cap = pdata->cap;
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "no i2s resource defined\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
>> +		dev_err(&pdev->dev, "i2s region already claimed\n");
>> +		return -EBUSY;
>> +	}
>
> There's devm_ versions of this stuff too.
>

OK

>> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>
> devm_kzalloc()
>

Ok

>> +	dev->i2s_base = ioremap(res->start, resource_size(res));
>> +	if (!dev->i2s_base) {
>
> devm_ioremap().
>

Ok


>> +		if (dev->play_irq<  0)
>> +			dev_warn(&pdev->dev, "play irq not defined\n");
>> +		else {
>
> Braces on both sides of the if.
>
Ok,


Best Regards
Rajeev

>> +static int __init dw_i2s_init(void)
>
> module_platform_driver().
