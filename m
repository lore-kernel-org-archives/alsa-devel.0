From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] sound:asoc: Add support for synopsys
 i2s controller as per ASoC framework.
Date: Tue, 20 Mar 2012 15:44:22 +0000
Message-ID: <20120320154420.GE3445@opensource.wolfsonmicro.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<7692a51789abe38e7066a582d8329dc93b8eced3.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8359371652807941012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DAF8104270
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 16:44:25 +0100 (CET)
In-Reply-To: <7692a51789abe38e7066a582d8329dc93b8eced3.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, spear-devel@list.st.com
List-Id: alsa-devel@alsa-project.org


--===============8359371652807941012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 05:03:46PM +0530, Rajeev Kumar wrote:
> This patch add support for synopsys I2S controller as per the ASoC framework.

If this really is a generic Synopsys block shouldn't it be in a Synopsys
directory, possibly with a wrapper in the SPEAr directory for the
platform integration?

> +struct i2s_platform_data {
> +	#define PLAY	(1 << 0)
> +	#define RECORD	(1 << 1)

Namespacing here and with most of the other defines in the header (and
the driver, though the ones in the code are less important).  Normally
ALSA headers go in include/sound.

> +
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		i2s_write_reg(dev->i2s_base, TCR(ch), dev->xfer_resolution);
> +		i2s_write_reg(dev->i2s_base, TFCR(ch), 0x02);
> +		irq = i2s_read_reg(dev->i2s_base, IMR(ch));
> +		i2s_write_reg(dev->i2s_base, IMR(ch), irq & ~0x30);
> +		i2s_write_reg(dev->i2s_base, TER(ch), 1);
> +	} else {
> +		i2s_write_reg(dev->i2s_base, RCR(ch), dev->xfer_resolution);
> +		i2s_write_reg(dev->i2s_base, RFCR(ch), 0x07);
> +		irq = i2s_read_reg(dev->i2s_base, IMR(ch));
> +		i2s_write_reg(dev->i2s_base, IMR(ch), irq & ~0x03);
> +		i2s_write_reg(dev->i2s_base, RER(ch), 1);
> +	}

It would be good to split out the bits that are common from the bits
that vary per stream.

> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		for (i = 0; i < 4; i++)
> +			i2s_write_reg(dev->i2s_base, TER(i), 0);
> +	} else {
> +		for (i = 0; i < 4; i++)
> +			i2s_write_reg(dev->i2s_base, RER(i), 0);

Magic numbers!

> +static irqreturn_t dw_i2s_play_irq(int irq, void *_dev)
> +{
> +	struct dw_i2s_dev *dev = (struct dw_i2s_dev *)_dev;
> +	u32 ch0, ch1;
> +
> +	/* check for the tx data overrun condition */
> +	ch0 = i2s_read_reg(dev->i2s_base, ISR(0)) & 0x20;
> +	ch1 = i2s_read_reg(dev->i2s_base, ISR(1)) & 0x20;
> +	if (ch0 || ch1) {
> +		/* disable i2s block */
> +		i2s_write_reg(dev->i2s_base, IER, 0);
> +
> +		/* disable tx block */
> +		i2s_write_reg(dev->i2s_base, ITER, 0);
> +
> +		/* flush all the tx fifo */
> +		i2s_write_reg(dev->i2s_base, TXFFR, 1);
> +
> +		/* clear tx data overrun interrupt */
> +		i2s_clear_irqs(dev, SNDRV_PCM_STREAM_PLAYBACK);
> +
> +		/* enable rx block */
> +		i2s_write_reg(dev->i2s_base, ITER, 1);
> +
> +		/* enable i2s block */
> +		i2s_write_reg(dev->i2s_base, IER, 1);
> +	}

This is somewhat unusual - normally ALSA detects underrun and overrun
and restarts the stream at the application layer.  This looks like it
attempts to mask information about errors from the application which
probably isn't waht we want to do.  Why is the normal ALSA handling not
sufficient?

> +
> +	return IRQ_HANDLED;

This unconditionally says it handled the interrupt even if it didn't.

> +static int
> +dw_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *cpu_dai)
> +{
> +	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
> +	struct dma_data *dma_data = NULL;
> +
> +	if (!(dev->capability & RECORD) &&
> +			(substream->stream == SNDRV_PCM_STREAM_CAPTURE))
> +		return -EINVAL;

Indentation.

> +
> +	if (dev->i2s_clk_cfg) {
> +		if (dev->i2s_clk_cfg(config)) {
> +			dev_err(dev->dev, "runtime audio clk config fail\n");
> +			if (cpu_dai->driver->ops->trigger) {
> +				int ret =
> +					cpu_dai->driver->ops->trigger(substream,
> +							SNDRV_PCM_TRIGGER_STOP,
> +							cpu_dai);
> +				if (ret < 0) {
> +					dev_err(dev->dev,
> +							"trigger stop fail\n");
> +					return ret;
> +				}
> +			}

No, return an error if you encounter an error!

> +static void
> +dw_i2s_shutdown(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)

Indentation - throughout the kernel the type goes on the same line as
the function name.

> +static const struct dev_pm_ops dw_i2s_dev_pm_ops = {
> +	.suspend = dw_i2s_suspend,
> +	.resume = dw_i2s_resume,
> +};

No, do this at the ASoC level like other CPU drivers (runtime PM
callbacks are OK).

> +	cap = pdata->cap;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no i2s resource defined\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> +		dev_err(&pdev->dev, "i2s region already claimed\n");
> +		return -EBUSY;
> +	}

There's devm_ versions of this stuff too.

> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);

devm_kzalloc()

> +	dev->i2s_base = ioremap(res->start, resource_size(res));
> +	if (!dev->i2s_base) {

devm_ioremap().

> +		if (dev->play_irq < 0)
> +			dev_warn(&pdev->dev, "play irq not defined\n");
> +		else {

Braces on both sides of the if.

> +static int __init dw_i2s_init(void)

module_platform_driver().

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKXMAAoJEBus8iNuMP3d0GcQAItFrzDdkVZ4CdN/FOfxHhcF
ih3ocQKAAn7Q1X4TU4fFgaKIstZejvaStSHyyNPBI3GB0/aHMrAVbZN4EClczgiL
/KTpKXeu5o5sb5m/R11jKPcdwO1PJKwiqcK/0Hm+871u4juI1Ws7tUPqMPf7jNyT
6L58Yn3YWX0h6Wd0rgutKDoaFnWuPtuGQhjRiR8Fn7KdoKJpGDzcdzgPbLL2qmOV
XzkhkwioNn+LqWIpPngrcgowghzZbR9dyuqrVsSzxX0U470HXu/7jPfXHhGYPG3K
v4sMbW6s4PTuEpEW1rtMX3fvP+8FQmOF28xJu5f3qB72xXFmlJVBDpaP/5X4hFXH
vURTlYd2Cd8bB60aYWLmxcHzzRDqaVEgFl7ybS81KM+FwYZkYMje7jePqMI3kYeF
yf6KYl3nmF1PsOAIUOK9LKzbyiYYyi8FwP2d4uxYqULp2vVmdS1JPK4S62jLGMGc
8I9k20r1HZH4HPFE/lyyrtqINDD9XdpDuGY0hyqPXFXr7hKl3+CskcxETA4q5paw
ZA4Q5fsOLFkhgKchW4wSmvffDfAjoZsGmi7akEYxfm5oi5gcUt+0ej2/uM/W42K0
mdjJPz9PFJwmStWZ5h6etY5BrtTx9Og5z6XuOGksT5Li62K089zOExdtVZPCA8u/
9ONqfN/RyJoUUWeUjEcs
=LwVY
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--

--===============8359371652807941012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8359371652807941012==--
