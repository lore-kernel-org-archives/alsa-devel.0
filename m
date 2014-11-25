From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/9] ASoC: ipq806x: add native LPAIF driver
Date: Tue, 25 Nov 2014 21:44:45 +0000
Message-ID: <20141125214445.GT7712@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-4-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jDJZvxmnOWiGS9cs"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-4-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--jDJZvxmnOWiGS9cs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2014 at 10:52:43AM -0800, Kenneth Westfield wrote:

> +#define DRV_NAME	"lpass-lpaif"
> +#define DRV_VERSION	"1.0"

Don't add versions like this, the kernel is already more than adequately
versioned and nobody is ever going to bother to update it.

> +static int lpaif_pcm_int_enable(uint8_t dma_ch)
> +{
> +	uint32_t intr_val;
> +	uint32_t status_val;
> +	unsigned long flags;
> +
> +	if (dma_ch >=3D LPAIF_MAX_CHANNELS) {
> +		pr_err("%s: invalid DMA channel given: %hhu\n",
> +				__func__, dma_ch);

dev_err().

> +void lpaif_cfg_i2s_playback(uint8_t enable, uint32_t mode, uint32_t off)
> +{

The kernel types for fixed size unsigned integers are u8, u32 and so on.

> +		if ((bit_width =3D=3D 16) && (channels =3D=3D 2)) {
> +			cfg |=3D LPAIF_DMACTL_WPSCNT_MONO;
> +		} else if (((bit_width =3D=3D 16) && (channels =3D=3D 4)) ||

switch statements please, it's both more legible and more extensible.

> +void lpaif_register_dma_irq_handler(int dma_ch,
> +		irqreturn_t (*callback)(int intrsrc, void *private_data),
> +		void *private_data)
> +{
> +	lpaif_dai[dma_ch]->callback =3D callback;
> +	lpaif_dai[dma_ch]->private_data =3D private_data;
> +}
> +
> +void lpaif_unregister_dma_irq_handler(int dma_ch)
> +{
> +	lpaif_dai[dma_ch]->callback =3D NULL;
> +	lpaif_dai[dma_ch]->private_data =3D NULL;
> +}

What is this doing?  Linux already has a perfectly good interface for
requesting and releasing interrupts...

> +static int lpaif_dai_find_dma_channel(uint32_t intrsrc)
> +{
> +	uint32_t dma_channel =3D 0;
> +
> +	while (dma_channel < LPAIF_MAX_CHANNELS) {
> +		if (intrsrc & LPAIF_PER_CH(dma_channel))
> +			return dma_channel;
> +
> +		dma_channel++;
> +	}

A comment explaining why we can't just map directly might be helpful
here.

> +
> +	return -1;

Real error codes please.

> +static irqreturn_t lpaif_dai_irq_handler(int irq, void *data)
> +{
> +	unsigned long flag;
> +	uint32_t intrsrc;
> +	uint32_t dma_ch;
> +	irqreturn_t ret =3D IRQ_NONE;
> +
> +	spin_lock_irqsave(&lpaif_lock, flag);
> +	intrsrc =3D readl(lpaif_dai_info.base + LPAIF_IRQ_STAT(0));
> +	writel(intrsrc, lpaif_dai_info.base + LPAIF_IRQ_CLEAR(0));
> +	spin_unlock_irqrestore(&lpaif_lock, flag);

This appears to be unconditionally acknowleding all interrupts, even
those we don't understand.  This is bad practice - we should at least be
logging an error and ideally returning IRQ_NONE if we don't understand
the interrupt and letting the core error handling work for us.  For
example it looks like this will happily and silently acknowledge both
error and underrun interrupts from the hardware.

It's also not at all obvious why we're taking this spinlock in the
interrupt handler, that's *extremely* unusual.  What is being protected
- the code needs to make that clear?

> +	while (intrsrc) {
> +		dma_ch =3D lpaif_dai_find_dma_channel(intrsrc);
> +		if (dma_ch !=3D -1) {
> +			if (lpaif_dai[dma_ch]->callback) {
> +
> +				ret =3D lpaif_dai[dma_ch]->callback(intrsrc,
> +					lpaif_dai[dma_ch]->private_data);
> +			}
> +			intrsrc &=3D ~LPAIF_PER_CH(dma_ch);
> +		} else {
> +			pr_err("%s: error getting channel\n", __func__);
> +			break;
> +		}
> +	}
> +	return ret;
> +}

This all looks like a very simple demux of a single register - don't we
have a generic irqchip that can handle it?  It looks like that's what
you're trying to implement here, each DMA channel could be requesting
the three interrupts it has separately rather than open coding an
interrupt controller here. =20

I'm not actually immediately seeing one right now but it'd be simple to
add (or regmap-irq could do it if we used a regmap, though it assumes
threading and isn't a great fit).

> +static struct platform_driver lpass_lpaif_driver =3D {
> +	.probe =3D lpaif_dai_probe,
> +	.remove =3D lpaif_dai_remove,
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.owner =3D THIS_MODULE,

No need for .owner on platform devices any more.

--jDJZvxmnOWiGS9cs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdPhNAAoJECTWi3JdVIfQyVgH/RQNJ8suVgNj09Yujw8ZwLND
l8P28Su2JzyxL+S2h1jCo+BES9JpHH6YR9IJoZTLctqLUtnotRTSPQiav65i41F3
2ZMyR/bNHZx1aUUuPi8V52k1hapjwgLHZvZXk7UwdZhZjEPJJEY9o5HqUUndH0DM
KfKYDN5AIZaCn4XqlVFqk6UjmT3Nn2FmIOrAWlF/GBZHBh1ujv9cnXmA6N9Ydls3
o9SJ5y55NfktUNTVOnFSX753njiUujtL+UZMlzM/Mnq62cFJcCznq8rPmM8QLpa3
77QrbFLuX4sFOdr0qp5vLWBef/Z0NkzN1ZzWSGbPiwaaBmuQqbi8u0FlYniwsE8=
=/K2Z
-----END PGP SIGNATURE-----

--jDJZvxmnOWiGS9cs--
