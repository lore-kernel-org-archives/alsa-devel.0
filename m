From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: mt6797: add mt6797 platform
	driver
Date: Wed, 18 Apr 2018 17:46:26 +0100
Message-ID: <20180418164626.GH10061@sirena.org.uk>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-4-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5572451119875139748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 783A526767A
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 18:46:34 +0200 (CEST)
In-Reply-To: <20180416003252.4177-4-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============5572451119875139748==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 08:32:50AM +0800, KaiChieh Chuang wrote:
> add support for mt6797 playback and capture
> to MediaTek sound codec,
> through MediaTek Proprietary audio interface.
> add memory interface as FE dai.
> add ADDA interface as BE dai.

Again this looks pretty good, some small comments but nothing major:

> +		/* set output mode */
> +		if (rate == 96000) {
> +			dl_src2_con0 |= (0x2 << 24); /* UP_SAMPLING_RATE_X4 */
> +			dl_src2_con0 |= 1 << 14;
> +		} else if (rate == 192000) {
> +			dl_src2_con0 |= (0x1 << 24); /* UP_SAMPLING_RATE_X2 */
> +			dl_src2_con0 |= 1 << 14;
> +		} else {
> +			dl_src2_con0 |= (0x3 << 24); /* UP_SAMPLING_RATE_X8 */
> +		}

This looks like a switch statement.

> +		/* turn of mute function */
> +		dl_src2_con0 |= (0x03 << 11);

Is there any reason for not implementing this as a mute_stream()
callback?  That'll keep the DAI muted during startup and before teardown
which will do the most to avoid any noise making it into the output.

> +static irqreturn_t mt6797_afe_irq_handler(int irq_id, void *dev)
> +{
> +	struct mtk_base_afe *afe = dev;
> +	struct mtk_base_afe_irq *irq;
> +	unsigned int status;
> +	unsigned int mcu_en;
> +	int ret;
> +	int i;
> +
> +	/* get irq that is sent to MCU */
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);

...

> +	/* clear irq */
> +	regmap_write(afe->regmap,
> +		     AFE_IRQ_MCU_CLR,
> +		     status & AFE_IRQ_STATUS_BITS);
> +
> +	return IRQ_HANDLED;
> +}

This unconditionally returns IRQ_HANDLED even if we didn't get an
interrupt - it's better to return IRQ_NONE unless we actually handled
something since that is more robust if something goes wrong, it lets the
IRQ core shut up interrupts that get latched on and works with shared
interrupts if any future designs do that.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXdmEACgkQJNaLcl1U
h9Dm5gf/V2pu7llSsyRFZ94RtbA6zbwBPZe/Q2PIg0AOJk41qZ88BY7oG4wOxWAB
TjPVqVybyqj5UYAOdEXUsdNNXiCAmgYiJyqvu+KV/I533ARZySvzvjwl2EE6pSvr
zTWqT/o5FI7N8srJL+Wtcyyry5k+5Rpx9S6fsFwuPG9ODzKFFuFF2dW7gj4IhlQR
Mme/8g5tfUqm3dUYuuHiNXhDIxIvi+SSulb65K7UExFLh5btRMuNFFyH0kb5o8Dp
I8jyYappuC5Iri4wApa1n7n6sWBj3n0c/Gh9asF+g24+ko7fx5Qt500sOhdOGbUs
62Lr2ERFlHRq+Qhq+TESUfsxCN7yIA==
=vRDM
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============5572451119875139748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5572451119875139748==--
