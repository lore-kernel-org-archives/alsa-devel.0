From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8540: new codec driver
Date: Mon, 9 Jan 2017 20:00:52 +0000
Message-ID: <20170109200052.szyldvyxnki2jggj@sirena.org.uk>
References: <1483597244-9761-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3120758306895995667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 43109266AF5
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:00 +0100 (CET)
In-Reply-To: <1483597244-9761-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3120758306895995667==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cpdmxec4nozoce4c"
Content-Disposition: inline


--cpdmxec4nozoce4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2017 at 02:20:44PM +0800, John Hsu wrote:

This looks good overall, a couple of small points though:

> +static int nau8540_config_sysclk(struct nau8540 *nau8540,
> +       int clk_id, unsigned int freq)
> +{
> +       struct regmap *regmap = nau8540->regmap;
> +
> +       switch (clk_id) {
> +       case NAU8540_CLK_DIS:
> +       case NAU8540_CLK_MCLK:
> +               regmap_update_bits(regmap, NAU8540_REG_CLOCK_SRC,
> +                       NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_MCLK);
> +               regmap_update_bits(regmap, NAU8540_REG_FLL6,
> +                       NAU8540_DCO_EN, 0);
> +               break;
> +
> +       case NAU8540_CLK_INTERNAL:
> +               regmap_update_bits(regmap, NAU8540_REG_FLL6,
> +                       NAU8540_DCO_EN, NAU8540_DCO_EN);
> +               regmap_update_bits(regmap, NAU8540_REG_CLOCK_SRC,
> +                       NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_VCO);
> +               break;

The above are fine but...

> +
> +       case NAU8540_CLK_FLL_MCLK:
> +               regmap_update_bits(regmap, NAU8540_REG_FLL3,
> +                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_MCLK);
> +               break;
> +
> +       case NAU8540_CLK_FLL_BLK:
> +               regmap_update_bits(regmap, NAU8540_REG_FLL3,
> +                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_BLK);
> +               break;
> +
> +       case NAU8540_CLK_FLL_FS:
> +               regmap_update_bits(regmap, NAU8540_REG_FLL3,
> +                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_FS);
> +               break;

...these look like they're mixing in FLL configuration which I'd expect
to be done with set_pll() via the source argument and I'm not seeing
anything that sets the device to use the FLL here.  I'd expect the
source selection to go into set_pll() and I'd expect this function to
have a setting which tells the device to use the FLL.

> +static int nau8540_set_sysclk(struct snd_soc_codec *codec,
> +       int clk_id, int source, unsigned int freq, int dir)
> +{
> +       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
> +
> +       return nau8540_config_sysclk(nau8540, clk_id, freq);
> +}

This wrapper isn't really adding anything.

> +static void nau8540_init_regs(struct nau8540 *nau8540)
> +{
> +       struct regmap *regmap = nau8540->regmap;
> +
> +       /* Enable Bias/VMID/VMID Tieoff */
> +       regmap_update_bits(regmap, NAU8540_REG_VMID_CTRL,
> +               NAU8540_VMID_EN | NAU8540_VMID_SEL_MASK,
> +               NAU8540_VMID_EN | (0x2 << NAU8540_VMID_SEL_SFT));
> +       regmap_update_bits(regmap, NAU8540_REG_REFERENCE,
> +               NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN,
> +               NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN);
> +       mdelay(2);
> +       regmap_update_bits(regmap, NAU8540_REG_MIC_BIAS,
> +               NAU8540_PU_PRE, NAU8540_PU_PRE);
> +       regmap_update_bits(regmap, NAU8540_REG_CLOCK_CTRL,
> +               NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN,
> +               NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN);
> +       /* ADC OSR selection, CLK_ADC = Fs * OSR */
> +       regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
> +               NAU8540_ADC_OSR_MASK, NAU8540_ADC_OSR_64);
> +}

Does this sequence need to be done as part of resume as well?

--cpdmxec4nozoce4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhz6/MACgkQJNaLcl1U
h9CddAf/WSCUn+aJd2ewF1UQZMxB6UPMiYbLyvLBAZU8mfOBP33b7ugkzfevnR8/
QEDwggD7G/dHQvFgyncIls3U+k/FfrXQV7q1sbqAheXfIvsj7jfySMqhSQRXyFIE
arpTN30gdyCmntY0tgco89sA2lE6gd17HXQXATUB9a029ljduVVcoCcvxJyF0roq
NGmSiwJtbBmGhe9xUrw7Tj3sVvKZSGH33urrJxMat91ShLIh5ETtgcnVSt0wdXYC
of3NLRcOsd4SV5Vy7pUTjM3rP65ojSipKXXLMw0EFQrHegVlmkpUI0kjVW7ODRz5
sCqVDPFahCpwNaXxTGOwEM5xw3nt/Q==
=o8MY
-----END PGP SIGNATURE-----

--cpdmxec4nozoce4c--

--===============3120758306895995667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3120758306895995667==--
