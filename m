From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_spdif: Fix clock source for
 rxclk rate measurement
Date: Fri, 25 Apr 2014 17:10:15 +0100
Message-ID: <20140425161015.GQ12304@sirena.org.uk>
References: <cover.1398427055.git.Guangyu.Chen@freescale.com>
 <cbeb07fbdadd7bf72f74224d5ad12c9706376c95.1398427055.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4095280081964581183=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24CB9261A6C
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 18:10:30 +0200 (CEST)
In-Reply-To: <cbeb07fbdadd7bf72f74224d5ad12c9706376c95.1398427055.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4095280081964581183==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EroFgB/Y6GhjWuRm"
Content-Disposition: inline


--EroFgB/Y6GhjWuRm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 25, 2014 at 07:58:19PM +0800, Nicolin Chen wrote:

> +	/* Get system clock for rx clock rate calculation */
> +	sprintf(tmp, "rxtx%d", SPDIF_CLK_SRC_SYSCLK);
> +	spdif_priv->sysclk = devm_clk_get(&pdev->dev, tmp);
> +	if (IS_ERR(spdif_priv->sysclk)) {
> +		dev_err(&pdev->dev, "no sys clock (%s) in devicetree\n", tmp);
> +		return PTR_ERR(spdif_priv->sysclk);
> +	}
> +

Why is this not just a fixed string - it seems like the clock name is a
constant anyway?

--EroFgB/Y6GhjWuRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWojkAAoJELSic+t+oim99eQP/j47aNWOTwaMKsI/kPKLRWdg
QHIi6cJqg906vqQ7SKj7JKLD/Sp1+VeleA3b/Ve5IxPZBrbCBL1xsEV/yxN+DvTd
+nGu8adX04JCBIcizmaGtymUPsB3cYDvH4PiPn3fsXz6uuU8flFnzQ9AH1vNv9th
uILokXEeK2ce4F7JprZ7fDeYOkrzGP26rbvGFKcMyjGxtXeXDS0qqt0DJm1r4VGd
fkfCq6qJ9RW2+SPQNizKG97cadkwZBZnNgzsgrQoOb+PfXVVA2D90V+2y0FarhM7
YkFcspfyPWTimkmY1gDgZPrSlA8AkXmm055kL7EVwCz2xmUgWpK5jC5AmthQep7u
VnM6hospndEgtos6DHwkVnh540GEcNHgiWK0bCU10iR+ArcTWcPTPu7LzSX4hPfB
TDCVXtSrutNq4NvRwQJnYUiPcCN+O6eiEp42Fi/KF2JAUyHOyeXhjysymNWThDtT
dKCCytJyDFt313hNB166z+WbqDr6o4oZN60M4iGthhTyVx+QeWPO0g/N1jtSG9C9
IlRdIVfoqmr6MKs2tIjW6BqSPRucjhWlQ3kvUApZhBF281HDAFVJJuZkE+ZMIcCF
fwPhWzgbMtMfpGZbGGRti3kXPXbg1LrZ7czI+1ELcH/SD4WpblnnfwrcKeozxb+h
RVNnhJpcAL2eCJiJyG/z
=wTWu
-----END PGP SIGNATURE-----

--EroFgB/Y6GhjWuRm--

--===============4095280081964581183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4095280081964581183==--
