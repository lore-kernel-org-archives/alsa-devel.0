From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: add pxa-squ dma support
Date: Tue, 22 May 2012 10:24:20 +0100
Message-ID: <20120522092419.GA21999@opensource.wolfsonmicro.com>
References: <1337330621-9072-1-git-send-email-zhouqiao@marvell.com>
	<1337330621-9072-2-git-send-email-zhouqiao@marvell.com>
	<B2A7C617B3AB7F44B7B44C7D374B431E13A04DBEBC@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4826256132563565971=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <B2A7C617B3AB7F44B7B44C7D374B431E13A04DBEBC@sc-vexch3.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============4826256132563565971==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 21, 2012 at 05:33:42PM -0700, Qiao Zhou wrote:

> Is there any suggestion/comment for this patch? Thanks!

Don't top post.

> +config SND_PXA_SOC_SQU
> +       tristate
> +       select GENERIC_ALLOCATOR
> +

The main reason I've left this is that I'm trying to decide what to say
about the fact that it's not using dmaengine - why is it not doing so?

There's also a few smaller issues below:

> +       for (i = 0; i < 2; i++) {
> +               dint = SDISR(i);
> +               if (dint) {
> +                       substream = squ_data->stream[i];
> +                       prtd = substream->runtime->private_data;
> +                       if (SDISR(i) & 0x1)
> +                               snd_pcm_period_elapsed(substream);
> +                       else
> +                               pr_debug("%s: SQU error on channel %d\n",
> +                                        prtd->params->name, i);

Should be dev_err().

> +                       SDISR(i) = 0;
> +               }
> +       }
> +
> +       return IRQ_HANDLED;

This interrupt handler unconditionally returns IRQ_HANDLED even if there
were no interrupts reported.  It should probably only do this if one of
the tests in the loop returned true.

> +       /* return if this is a bufferless transfer e.g.
> +        * codec <--> BT codec or GSM modem -- lg FIXME */
> +       if (!dma)
> +               return 0;

Remove this, systems should use the framework features for this (and I
don't think you're Liam...).

> +       prtd = kzalloc(sizeof(struct pxa_runtime_data), GFP_KERNEL);
> +       if (prtd == NULL) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }

devm_kzalloc().

> +struct snd_soc_platform_driver pxa_squ_soc_platform = {
> +       .ops = &pxa_squ_pcm_ops,
> +       .pcm_new = pxa_squ_pcm_new,
> +       .pcm_free = pxa_squ_pcm_free,
> +};
> +EXPORT_SYMBOL_GPL(pxa_squ_soc_platform);

This should never need to be exported.

> +       squ_data = kzalloc(sizeof(struct pxa_squ_priv), GFP_KERNEL);
> +       if (!squ_data)
> +               return -ENOMEM;

devm_kzalloc().

> +       squ_data->irq = pdata->irq;

Shouldn't the interrupt be supplied via a resource?

> +       ret =
> +           request_irq(squ_data->irq, pxa_squ_dma_irq, IRQF_DISABLED,
> +                       "pxa-squ", pdev);
> +       if (ret) {
> +               pr_err("Wow!  Can't register IRQ for SQU\n");

dev_err() and print the error code.

> +static int __init pxa_squ_pcm_modinit(void)
> +{
> +       return platform_driver_register(&pxa_squ_driver);
> +}
> +
> +module_init(pxa_squ_pcm_modinit);

module_platform_driver().

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPu1s9AAoJEBus8iNuMP3dauwQAIuRhclGzITBGvShrRRYw0pt
ZqazMi/2B4jVMQiSQChFu6xWZIu13fQ9W8nG/mBj4+qkcksq1YddkoIX4bsmVa10
tvdIebja1f652LuTW8UD3qDqq1V3K+ABBtnmwFvtSAi5IE3hNNXFXtunyuaAbNLL
tZbeMBso//nfBH7pizMC/gv/2Rvb1UsOViRsXzy+yP+E3nKnyc/XO7uNmA+sdn4i
ctPAk4k32NdJsZYFKbu7dFoHhH6dZAvYAbL84fDUPWAMu+WCxTCuhIoukrpU+WWP
eP0uBi4lTrL21outjAVr11L4JpkBIGi46+kjJaf4zK7hFpIa0bHIxSRblgNflffA
rPjwUjZcKaDbDAO/4BjtfXjMsHq7Fwe+7a++HeJHR3cQfyqyTDz4vPyt732YrMpz
TRTy1mNna+PnaXKbUqevzXNAezQIQFrMz8SwbSsJY+K+SXp/Hfi79lh0y/xQPOZb
SFBKTKJXH6MuZLCkUsGd2IVCDVzRmOVA3Z99krgL3nWtDO2MUpAAbqkz49pfRl3/
KPXxMo9I8UAiIBc1BstyTe2V/O0NQ/kF3jLVhIFWtS0HFKiXaUWvqKq0rtGRMfUw
0Zfb7KjeqtxoaObgHSjPv0nZKQ6iBnwqaF6c5VpxD304+SlB4lIdWf7dWr9Q8MHA
bxctwt9z+FQ1BItg3P+S
=3VVD
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4826256132563565971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4826256132563565971==--
