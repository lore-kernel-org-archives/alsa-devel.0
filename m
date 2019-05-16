From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: AK4458: add regulator for ak4458
Date: Thu, 16 May 2019 17:54:07 +0100
Message-ID: <20190516165407.GJ5598@sirena.org.uk>
References: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
 <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Viorel Suman <viorel.suman@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 10:14:42AM -0300, Fabio Estevam wrote:

> > +       ret = devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies),
> > +                                     ak4458->supplies);
> > +       if (ret != 0) {
> > +               dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
> > +               return ret;

> This would break existing users that do not pass the regulators in device tree.

It won't, if you're using regulator_get() and there's just no regulator
in the DT the regulator framework just assumes that there is actually a
regulator there which isn't described in the DT and substitutes in a
dummy regulator for you.

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdla8ACgkQJNaLcl1U
h9APjQf+Lv8THYJ4esni1vNmG69HpD0BrrnTj4bJszGYZmzU+NUA1KpHwSgphVPx
dNEm9YVRL58Ap8OQ6R46L0vKKwjv7O2PQHVAVpuH94fJEkdnlRLYppoEof9hODaa
sIVb/mjegYSgclH+zisPqB4DrB9TFX55fkDl7I4JI+6IBuCCX6pGAmDC83VmgPhv
CBgNmyBfE6Iim+g1AKFLo6UJK8Ygn1KKRAfEmNVdN4Q+Zo2GcynfnznEHiUR3gCc
1iw2fGSjM4xOm42TezfFo+AZKBrCElE8jWQfInD3dQtbhJUtVljxIjOe1/ywebWi
qW8LBq1eK2SLwtpuk9lL4BDPZpj4LA==
=79lT
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
