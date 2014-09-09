From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Tue, 9 Sep 2014 16:21:14 +0100
Message-ID: <20140909152114.GA2601@sirena.org.uk>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <540EFDFF.7050804@tabi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7A15IXT36zwL5BDA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540EFDFF.7050804@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--7A15IXT36zwL5BDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 08:17:51AM -0500, Timur Tabi wrote:
> Shengjiu Wang wrote:
> >+	if (ssi_private->soc->imx)
> >+		clk_prepare_enable(ssi_private->clk);

> How about this instead?

> if (ssi_private->clk)
> 	clk_prepare_enable(ssi_private->clk);

Should be a !IS_ERR() - NULL is a valid clock.

--7A15IXT36zwL5BDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDxrmAAoJECTWi3JdVIfQGHQH/iYPDA+Ux7C65f6IB8MrMaBa
UekhxwGPUW+ixAdaweL1z04umskGJbbJHRbxkaFFyWi15lzF6KLN+ntWwxg7qpld
H7yUxhQixGWicLewybTFxSj5TMId8yNmbuC3pXDEn9eRz46F1MHwznSCcuEP4ueA
dsxAUoapO6cieCphAljMKOL/UEVOUmLbYCnpaVF/sOJThVY+IWWzZHVhjPqCiXx3
2VXxbK5VG9bZRWirapyOV2O54iFWKtcVGxsZKmDieMj32YzVMtDPn15qsAk+2trZ
ESajHSwBg45/QLRejykIoJC5Y+p3AeaWRmB48Hwb6SV+Z9udzliEf2+EblvVEbA=
=xkyN
-----END PGP SIGNATURE-----

--7A15IXT36zwL5BDA--
