From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASOC: imx: add machine driver using
	wm8962 codec
Date: Tue, 29 Jan 2013 17:07:13 +0800
Message-ID: <20130129085831.GC32597@opensource.wolfsonmicro.com>
References: <1359445790-2070-1-git-send-email-b13634@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3491344090168285802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10C762652E5
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 10:07:23 +0100 (CET)
In-Reply-To: <1359445790-2070-1-git-send-email-b13634@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gary Zhang <b13634@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3491344090168285802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2013 at 03:49:50PM +0800, Gary Zhang wrote:

> +static struct imx_priv card_priv;

Global data bad...

> +static int imx_wm8962_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct imx_priv *priv = &card_priv;
> +	struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
> +
> +	if (!codec_dai->active)
> +		clk_enable(data->codec_clk);

Should be clk_prepare_enable() but it's not clear to me why you need
this...   Also the clock API does refcounting so there should be no need
to check for active, you should get matching startups and shutdowns.

This will also fail for analogue bypass paths, set_bias_level() would be
a good place to cover those.

> +	int_port--;
> +	ext_port--;
> +	ret = imx_audmux_v2_configure_port(int_port,
> +			IMX_AUDMUX_V2_PTCR_SYN |
> +			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> +			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
> +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> +			IMX_AUDMUX_V2_PTCR_TCLKDIR,
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
> +	if (ret) {
> +		dev_err(&pdev->dev, "audmux internal port setup failed\n");
> +		return ret;
> +	}
> +	imx_audmux_v2_configure_port(ext_port,
> +			IMX_AUDMUX_V2_PTCR_SYN,
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
> +	if (ret) {
> +		dev_err(&pdev->dev, "audmux external port setup failed\n");
> +		return ret;
> +	}

This stuff is pretty common for i.MX drivers - can we factor it out into
a helper library?

> +	ssi_pdev = of_find_device_by_node(ssi_np);
> +	if (!ssi_pdev) {
> +		dev_err(&pdev->dev, "failed to find SSI platform device\n");
> +		ret = -EINVAL;
> +		goto fail;
> +	}

Please remember to include binding documentation for all new device tree
bindings.

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRB5E4AAoJELSic+t+oim91bkP/0WtZnqFpWsYPbVJOb1yMtaY
gb6G/g/7mWC3OtGms+ApG1DWzHpi5jI04zsaT8Xg2swWfA3nqR/v8ILPYJeQNBMt
nV4QnPfQXD6FYgqFPgq3zqLNoRoLBIebHOHO/AOpJUfM4QmzloGY/zZatb/ZCJet
Rz094WUSPJayQ3B9mWdorSlMIA4ukZngxe/AY4hRgcT9Dqys7REko9IcXMmZGBp4
rmet+VN51AGiENKht/T5kzQBtAXZ4V0uD1hDM2sOruq98+F7FWoz78YgMgwwR5zy
ZKH6+nYFu7HUWo+1+46z0GTQiOElejv2bkvm2KTnB0t5Y6j00ECnDJxrmtmn748S
UQtYQEYEYHPu3UgwVs3JdeDM0nAoYZDCRsqa3GsPI9UyuEm69XEgxMNECUCssydW
3fI4UaVsl2P/Il8xbcl7qm8M29LW+l2RBLxuZNPkjEfyGt/wy/D/s2MKutP+XVoj
zHuMIKA+aGij8hbnOkU3ZRkEy2PASrDk/QqB80Ak0Q6E7Of+1laZgcPFpsXTjd5O
NI/6RLUohG4RVTIIvjQPEhrnkvpx7u68YugCu1fPvT6gIDBwpxe4bnvL9PgLsxqi
HhwNhiPUigfQXVcdH3w1MBOzMCJ9MLW93pSx068SBcBmj4IOh525MkcN7vcaAsf6
5A40w0UQkQmDXdMSoJ9y
=fK+T
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--

--===============3491344090168285802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3491344090168285802==--
