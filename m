From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASOC: mmp: add sspa support
Date: Mon, 28 May 2012 15:59:05 +0100
Message-ID: <20120528145904.GK4032@opensource.wolfsonmicro.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0834659944679715988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
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
Cc: Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Chao Xie <cxie4@marvell.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0834659944679715988==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Content-Disposition: inline


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 03:11:02PM +0800, Zhangfei Gao wrote:
> The SSPA is a configurable multi-channel audio serial (TDM) interface.
> It's configurable at runtime to support up to 128 channels and the
> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
> support stereo format: I2S, left-justified or right-justified.

Mostly looks good.  A few fairly minor things...

> +static int mmp_sspa_startup(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(dai);
> +	struct ssp_device *sspa = sspa_priv->sspa;
> +	int ret = 0;
> +
> +	if (!cpu_dai->active) {
> +		clk_enable(sysclk);
> +		clk_enable(sspa->clk);
> +	}

The clock API is refcounted so you shouldn't need to worry about
multiple enables, you should just be able to unconditionally enable and
disable.  If this is needed we probably have a problem we should fix.

> +	switch (pll_id) {
> +	case MMP_SYSCLK:
> +		clk_set_rate(sysclk, freq_out);
> +		break;
> +	case MMP_SSPA_CLK:
> +		clk_set_rate(sspa->clk, freq_out);
> +		break;

You're ignoring the return values here.

> +	priv->sspa->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->sspa->clk)) {
> +		ret = PTR_ERR(priv->sspa->clk);
> +		goto err_free_clk;
> +	}

devm_clk_get().

> +	res = request_mem_region(res->start, resource_size(res),
> +			pdev->name);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "failed to request memory resource\n");
> +		ret = -EBUSY;
> +		goto err_get_res;
> +	}
> +
> +	priv->sspa->mmio_base = ioremap(res->start, resource_size(res));
> +	if (priv->sspa->mmio_base == NULL) {
> +		dev_err(&pdev->dev, "failed to ioremap() registers\n");
> +		ret = -ENODEV;
> +		goto err_free_mem;
> +	}

devm_request_and_ioremap().

> +err_free_clk:
> +	devm_kfree(&pdev->dev, priv->dma_params);
> +err_priv_dma_params:
> +	devm_kfree(&pdev->dev, priv->sspa);
> +err_priv_sspa:
> +	devm_kfree(&pdev->dev, priv);

The whole point of the devm_ stuff is that you don't need to do stuff
like this.

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw5KwAAoJEBus8iNuMP3dIycQAJolUW1FI08fu8MK2dyAmO0E
v647lBwjK6OIpiAht2ClEdaElVhhIH91riA6ozlqiwzE4/pxxDHjsxpZgUCRzQWE
o4XoZ+HukQca1bn0mTsT2mfpb8iJN6MSbkEmDOs3zne7VnMQKstrMWnZtRVZ3Hcs
0soicsINS/nPFtdrk2IiU6Z479BImnTRp6/XOiGrdBf8CW4xLuQlCSFzQzuk+RNy
xVCmeJB8cLkkWA4dgAONChwaiYjFQWF7a9s6CdsXEPcnMpU648xLIXc07DmsFZPK
6V2jo/bpDdLnfvb3RGrzgdXaV4KXC+ejxSkrvFAhD/ZU6wOFBJVmfg/Wy/fvhgb2
QX/8+8BurIjv3NsNO0m8hdQuFysPoCGJsMqXMAuEXo4aaVt3EKerHk8r92Lv2VD5
2gMpA8J4OlWQz+lYSft+sdC8yaiuEzx2a5Qg2+6Fz27xkSMRbvDc0aH1P5Kql14J
RanR3C1NbAPHdIgOCh8Bl1j5hslMIMjlgV4DGQn9GQqFvOXTQm7DLjoP5qdgjEoY
wG7ekFvMMxz9JtL0QdA1DFUHACwFlUMoCJx2omBFRomu3lie3wqGa6TRgRz/3eC1
kO0JMFoN+idKN30xZ5jNOgs/iAncQQJ/vkDiPVDJu4hW5fU2bKPGj71WHp8jy8Mw
1rCOOnKyDXOv/Nv4Ajb7
=jUMJ
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============0834659944679715988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0834659944679715988==--
