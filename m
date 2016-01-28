From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V2 1/3] ASoC: bcm2835: move to use the clock framework
Date: Thu, 28 Jan 2016 14:08:37 -0800
Message-ID: <87vb6dfjbu.fsf@eliezer.anholt.net>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org> <1452602149-5875-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452602149-5875-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Since the move to the new clock framework with commit 94cb7f76caa0
> ("ARM: bcm2835: Switch to using the new clock driver support.")
> this driver was no longer functional as it was manipulating the
> clock registers locally without going true the framework.
>
> This patch moves to use the new clock framework and also
> moves away from the hardcoded address offsets for DMA getting
> the dma-address directly from the device tree.
>
> Note that the optimal bclk_ratio selection to avoid jitter
> due to the use of fractional dividers, which is in the
> current version has been removed, because not all devices
> support these non power of 2 sized transfers, which resulted
> in lots of (downstream) modules that use:
>   snd_soc_dai_set_bclk_ratio(cpu_dai, sample_bits * 2);
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  sound/soc/bcm/bcm2835-i2s.c |  284 ++++++++++---------------------------------
>  1 file changed, 64 insertions(+), 220 deletions(-)
>
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 3303d5f..1c1f221 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c

> -	dev->i2s_regmap = regmap[0];
> -	dev->clk_regmap = regmap[1];
> +	/* get the clock */
> +	dev->clk_prepared = false;
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk)) {
> +		dev_err(&pdev->dev, "could not get clk: %ld\n",
> +			PTR_ERR(dev->clk));
> +		return PTR_ERR(dev->clk);
> +	}
> +
> +	/* Request ioarea */
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	dev->i2s_regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +				&bcm2835_regmap_config);
> +	if (IS_ERR(dev->i2s_regmap))
> +		return PTR_ERR(dev->i2s_regmap);
> +
> +	/* Set the DMA address - we have to parse DT ourselves */
> +	addr = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
> +	if (!addr) {
> +		dev_err(&pdev->dev, "could not get DMA-register address\n");
> +		return -EINVAL;
> +	}
> +	dma_base = be32_to_cpup(addr);

Why aren't we just using mem->start like before?  That seems like an
independent change that should be justified on its own.  I'd be ready to
ack the patch if that change is removed.

I'm also trying to work my way through the clock changes.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqpFmAAoJELXWKTbR/J7ob4UQAJIKnVbHWodsLvdk/C4Qp+vG
jw3f0x5rJdbT/LbmSLcWRK308ab5PXk4du9ceoebDz01jM0NkoY2PtwYyajAHYmC
4aGq2/mO5GL50I6arECrT9/7j0oIjn0in8RAB5L4K71ojzDhaZ3pU4gnxqslCuTs
t8WVOY+r+zvxRqtzQ/btXuXpol+Bg09wn4mzwa1m5vsfXw02SVMYmt9EZYlUNHpK
hhk7dAUv0280o/ngQCDVXl4/QnI/3OQzZ+c41UHDcrpfWqMZ13KjAPyO2RRkQcTN
55L0fFzjDIbQGt4iWKX2aoNgSNs5lZNRqshMDxKzdjfysvzL2cqSIqLiYAVd24bR
GlCB8EfCvhohozHaVH3vRKgtc8r0Jxc7Fp1VjYc/hbPdhlpiTmJug2LaFLmBlehy
DAc7Xmdc3lhZqBqgCnJTiht4dPI/ym58sQrx3HCSpNgjJqDWqHDVukA4GRAQuT2P
669l7dUMG17hGcpLcpeRN7i4kzmIBVqftySI3aZVTqBDtcXc3QAu+AA/N5FBY+42
VtI6Q5vdIrkVORzVN7Y145usDGu4dA0ul3CU+prlANSpdbiee/gWkR8VP3iRi8bd
m655PIn66GIWfHb2pka4+2R+8VHjQ+TJEtcorqe0dsn1D7gSkqYiXdsVIM1vFHYe
PbBkLe5sN8L1Es3Vkfx3
=dPYL
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
