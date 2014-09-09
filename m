From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage
	in this module
Date: Tue, 9 Sep 2014 12:27:50 +0100
Message-ID: <20140909112750.GS2601@sirena.org.uk>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0508152607389354593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FBE7264F0F
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 13:28:08 +0200 (CEST)
In-Reply-To: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, timur@tabi.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============0508152607389354593==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKys6zTV8iyMJiwY"
Content-Disposition: inline


--NKys6zTV8iyMJiwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:

> +	if (ssi_private->soc->imx)
> +		clk_prepare_enable(ssi_private->clk);
> +

We're ignoring the error code here.

> -	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
> +	ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(ssi_private->clk)) {
>  		ret = PTR_ERR(ssi_private->clk);
> -		dev_err(&pdev->dev, "could not get clock: %d\n", ret);
> -		return ret;

Why is this change being made?  It wasn't mentioned in the commit log
and doesn't seem relevant to moving where the enable and disable are
done which is what the patch is supposed to be doing...

Please don't make different changes in the same patch.

--NKys6zTV8iyMJiwY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDuQ1AAoJECTWi3JdVIfQRFUH/A+c1fwfvIqcmYIlaJcAiWkO
Uuq0EjAEHWoUitSMxR1m/fvZ/UYttYAxEv/hl6HjFyhUlVyVklJ8jmtOlWpGfpIX
ZlisKPVpCFiE2bUdjjNxNvuVxu53MRUC6hmyDWiMN43UUNiBlYRpJrm+WKf0j8PB
o1nGbFVrfp5xOUAly951EFXBgC5PDPMZIY8XgL3pH6HesIv3URAxlL8JeguIuSWM
eM0i3O90aPHcfjKNT89fMru4Jhcw1jARkF9lE63EHXhbOnq+TDbWfIZKeYpNLoem
mB38k6NQH9IoFvr9kIoVqa9xLgP/c6da1w+3as8s40YPNfFVFeoKikKhBNsQuNQ=
=R1az
-----END PGP SIGNATURE-----

--NKys6zTV8iyMJiwY--

--===============0508152607389354593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0508152607389354593==--
