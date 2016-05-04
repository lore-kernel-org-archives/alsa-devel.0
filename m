From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v6] ASoC: dwc: Add custom PCM driver
Date: Wed, 4 May 2016 18:35:53 +0100
Message-ID: <20160504173553.GD6292@sirena.org.uk>
References: <cover.1461749984.git.joabreu@synopsys.com>
 <1467b43ff009213277fe8f092da40f0bb7609af4.1461749984.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Eldrgvv4EWsIM1sO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467b43ff009213277fe8f092da40f0bb7609af4.1461749984.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Eldrgvv4EWsIM1sO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 11:05:19AM +0100, Jose Abreu wrote:

> +	for (i =3D 0; i < 4; i++)
> +		isr[i] =3D i2s_read_reg(dev->i2s_base, ISR(i));
> +
> +	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_PLAYBACK);
> +	i2s_clear_irqs(dev, SNDRV_PCM_STREAM_CAPTURE);
> +
> +	if (dev->use_dmaengine)
> +		return IRQ_HANDLED;

The driver should not report that it handled interrupts unless it
actually did so otherwise shared interrupts won't work and if something
goes wrong that causes the interrupt to scream then the interrupt core
won't be able to do any error handling.  The driver should instead check
to see if any interrupts occurred and only acknowledge those it actually
handled.

> @@ -649,6 +673,19 @@ static int dw_i2s_probe(struct platform_device *pdev)
>  	if (IS_ERR(dev->i2s_base))
>  		return PTR_ERR(dev->i2s_base);
> =20
> +	irq_number =3D platform_get_irq(pdev, 0);
> +	if (irq_number <=3D 0) {
> +		dev_err(&pdev->dev, "get_irq fail\n");
> +		return -EINVAL;
> +	}

This will unconditionally fail if an interrupt is not provided which
will be incompatible with existing systems given that we don't currently
use the interrupt, I'm pretty sure you can find some in-tree devices
that get broken by this.  It's not like we even use the interrupt on
most systems so we should handle it being missing gracefully.

I'm also not seeing any code which masks or unmasks interrupts, if we
unconditionally enable interrupts we've no intention of using I'd expect
that will cause needless overhead for systems that don't use them.
Requesting it is fine but I'd expect to see the FIFO interrupts masked
in the device.

> +	ret =3D devm_request_irq(&pdev->dev, irq_number, dw_i2s_irq_handler,
> +			IRQF_SHARED, "dw_i2s_irq_handler", dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "request_irq fail\n");
> +		return ret;
> +	}

Are you *sure* that this results in safe freeing of the interrupt?
Until the interrupt is freed the interrupt could still fire so the
handler would need to support things being freed while the interrupt is
firing.  It is safer to manually free.

> +		dev->use_dmaengine =3D of_property_read_bool(pdev->dev.of_node,
> +				"dmas");

> -	if (!pdata) {
> +	if (dev->use_dmaengine) {
>  		ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);

This breaks non-DT users like the AMD graphics card.

> +int dw_pcm_transfer(u32 *lsample, u32 *rsample, int bytes, int buf_size,
> +		struct dw_pcm_binfo *bi)
> +{
> +	struct snd_pcm_runtime *rt =3D bi->stream->runtime;
> +	int dir =3D bi->stream->stream;
> +	int i;
> +
> +	for (i =3D 0; i < buf_size; i++) {
> +		if (dir =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +			memcpy(&lsample[i], bi->dma_pointer, bytes);
> +			bi->dma_pointer +=3D bytes;
> +			memcpy(&rsample[i], bi->dma_pointer, bytes);
> +			bi->dma_pointer +=3D bytes;

This code does not do DMA but it's using identifiers saying that it is
(which hence look like obvious bugs given that they're not using DMA
safe memory accesses).  This is just a scratch holding buffer AFAICT,
I'd expect to see code which says that explicitly.

It's not entirely clear that we have any bounds checking or anything to
make sure we stay within the buffer, there's an end of period reset but
it's hard to tell if that's enough.  I'm also not entirely sure why the
memcpy() is there at all - we appear to copy then immediately write to
FIFO which doesn't seem to add anything.

I'd also recommend looking at the xtfpga-i2s driver, it is for similar
hardware but avoids things like the memcpy().

> +static int dw_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

Remove empty functions, if that's not possible that's usually a sign
that the function needs to do something.

> +#ifdef CONFIG_OF
> +static const struct of_device_id dw_pcm_of[] =3D {
> +	{ .compatible =3D "snps,designware-pcm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dw_pcm_of);
> +#endif

This is adding a device tree binding but not documenting it.  All new
device tree bindings need to be documented.

--Eldrgvv4EWsIM1sO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKjL4AAoJECTWi3JdVIfQLbAH/iGlOsWXN4PmIcRUqbWm2rJ5
GDQt10N51WsW6uFG+d/HceID6/A+HJHBLY36sJb9pgeTpfbLBbUd1iqcpGdgdjM0
osQEyP3ivSMEnTiFsdA0Ul8SAlyt/Rq/5bgserZU+X8wUZ3mOBxTn72m6K0xxfzk
TI9+5YNA1QvOS6epTZxFQeK8+RLKva49ICLqyp5draM+4B+YeJsxldY4apRQ7P+/
KNTJi3w22+AQQ2dVBZFO8VgJyY2b2KyBrGJtg+VolKaoc3v6ep6FGlCH1nPVakLb
WfxvSdeoCIT1SLdBa3Q9p+YiU9slPjqah7xTlY1sVtPHISMGCDMqjnuaYtvN9pc=
=tqz+
-----END PGP SIGNATURE-----

--Eldrgvv4EWsIM1sO--
