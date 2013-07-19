From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: usp-pcm: add CPU DAI driver for
 PCM simulated from USP
Date: Fri, 19 Jul 2013 19:13:13 +0100
Message-ID: <20130719181313.GT9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5768745926696752933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6C4265768
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:13:15 +0200 (CEST)
In-Reply-To: <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5768745926696752933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pnDjx0H/VpusRTEI"
Content-Disposition: inline


--pnDjx0H/VpusRTEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 07:07:19PM +0800, Barry Song wrote:

> +static int sirf_usp_pcm_divider(struct snd_soc_dai *dai, int div_id, int rate)
> +{
> +	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
> +
> +	u32 clk_rate = clk_get_rate(susp->clk);
> +	u32 clk_div = (clk_rate/(2*rate)) - 1;
> +	u32 clk_div_hi = (clk_div & 0xC00)>>10;
> +	u32 clk_div_lo = (clk_div & 0x3FF);
> +
> +	writel((clk_div_lo<<21) | readl(susp->base + USP_MODE2),
> +		susp->base + USP_MODE2);
> +	writel((clk_div_hi<<30) | readl(susp->base + USP_TX_FRAME_CTRL),
> +		susp->base + USP_TX_FRAME_CTRL);
> +
> +	return 0;
> +}

I'd be happier if this did some validation on the supplied rate (for
example, checking that it's less than the master rate) and had arguments
specifying which clock was being affected (in case there's more in
future revisions).

Also what exactly is the rate being set - can the driver just figure
this out automatically from the sample rate?

> +#ifdef CONFIG_PM
> +static int sirf_usp_pcm_suspend(struct platform_device *pdev,
> +	pm_message_t state)
> +{
> +	struct sirf_usp *susp = platform_get_drvdata(pdev);
> +
> +	susp->mode1_reg = readl(susp->base + USP_MODE1);
> +	susp->mode2_reg = readl(susp->base + USP_MODE2);
> +	sirf_usp_controller_uninit(susp);
> +	clk_disable_unprepare(susp->clk);
> +
> +	return 0;
> +}

Can this be done as runtime PM as well?  Seems like it'd save power.

> +	susp->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(susp->clk)) {
> +		dev_err(&pdev->dev, "Get clock failed.\n");
> +		return PTR_ERR(susp->clk);
> +	}

devm_clk_get().

--pnDjx0H/VpusRTEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6YG1AAoJELSic+t+oim9LLMP/1obJNGDcNvO/UefdQT6P95y
tH0OAQVzLJ/MF/97W6YZIdAruLLuPbFmqdgKqU925erx/Str+TKEHVUfXO340H5w
JgqjGSAdEouIJ7OG1q+KXW/q2KgrLErE0Yt6MY0IVA9yU0AyfYrgC/Qw3v12iqwB
AlTFRYp8tsDlR3dNWTnWh+YhPh9fVn3bkrVFJdFpuIZHDx4qHG/xKvdxb1o+Elyu
EhgWwVg3nxN1WzMYiYdEufDKOKUt79MVNLEDEaSo8sO8magp7XM+rdtO9nH+gvAQ
Xg/g3UESbxdSNxefS9QpV5HvXr9t1KY9fuHd/bmlrDUyaizd/yRgIBLFdfXfs541
r6DWlFOX2qNhQJ0idpU03DvsqpjyC2C8wVnox80gz2U/IDzS44R8YabQ3t9FJdNB
m0yRKQAqapqBN3MIm/GiKxHAd8x77/OHcyEpWGGpVayNfA2DijegfWknLXXOsalW
1AkVWuHQIABOYE864Hr8pWjAFn6JD+59kyFCU0fe0UT+SirdDPMteY/kf/dxvdKW
iZhua7je9nXY7N/l4OZhp9iYVefepBfqisNfseaJH1pSNgIKim1c3Z9IJbC87SE5
7uXIiG8Vbi3zlMLE0kFHIW/xpArJXtgkVDviYPOatNqFVkVsIqGon84s8xuU67ue
aFaM7dcpx01HbVvPYlky
=1Gzl
-----END PGP SIGNATURE-----

--pnDjx0H/VpusRTEI--

--===============5768745926696752933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5768745926696752933==--
