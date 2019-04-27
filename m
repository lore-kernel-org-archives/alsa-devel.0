From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Date: Sat, 27 Apr 2019 18:17:15 +0100
Message-ID: <20190427171715.GF14916@sirena.org.uk>
References: <VE1PR04MB64797233B0BFE833550094C3E33E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64797233B0BFE833550094C3E33E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 10:51:15AM +0000, S.j. Wang wrote:
> > On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> > > Add pm runtime support and move clock handling there.
> > > Close the clocks at suspend to reduce the power consumption.

> > > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > > fsl_esai_resume is replaced by pm_runtime_force_resume.

> > This doesn't apply against current code, please check and resend.

> Which branch are you using?  I tried for-next and for-linus, both
> Are successful applied.

I'm applying against for-5.2, though if it depends on a patch queued for
5.1 that's fine, I can just merge that up - please just resend.  I think
I did try merging 5.1 though...

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEjpoACgkQJNaLcl1U
h9CHlQf6A1P1Ke+eIk6AjsV7q+IJv+iAexa+x1wOv3kVyxN9HNXMrrjuzMEX9GHF
5r7c9xhmJkX6qp8qFYVofOXeK3E9muhfjvSakheiyz6b3bpOP4bTNpZPK2m48Eda
aKkSFsu/TBWB42fymUVC5tAo45RWNe+5OSZrpCHou5DnvhhEMmdoMNS2ZDzrYFSt
h0rgmD+tb0YTZgP7WuEx0L/iSe0epJDpXyN8wgBozUQJp7muUvLnBPHEWqsNnoY9
bLVkFnRQhyZVi/urL0G5fGfbDwjRSXtoJJwjczQDAwXy20veWbr10l88uPXRbL5R
rIYLJu11thD17a4mSdf/UCUix1rE0A==
=tACM
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
