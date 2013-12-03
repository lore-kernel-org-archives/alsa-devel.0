From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: ux500: Dynamically fill DAI
 driver data on probe
Date: Tue, 3 Dec 2013 08:40:26 +0000
Message-ID: <20131203084026.GC11828@lee--X1>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-3-git-send-email-lee.jones@linaro.org>
 <529CCD2F.3060206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529CCD2F.3060206@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 02 Dec 2013, Lars-Peter Clausen wrote:

> On 12/02/2013 07:00 PM, Lee Jones wrote:
> [...]
> > +void ux500_msp_populate_dai_drv(struct snd_soc_dai_driver *ux500_m=
sp_dai_drv)
> > +{
> > +	ux500_msp_dai_drv->probe                 =3D ux500_msp_dai_probe;
> > +	ux500_msp_dai_drv->suspend               =3D NULL;
> > +	ux500_msp_dai_drv->resume                =3D NULL;
> > +	ux500_msp_dai_drv->playback.channels_min =3D UX500_MSP_MIN_CHANNE=
LS;
> > +	ux500_msp_dai_drv->playback.channels_max =3D UX500_MSP_MAX_CHANNE=
LS;
> > +	ux500_msp_dai_drv->playback.rates        =3D UX500_I2S_RATES;
> > +	ux500_msp_dai_drv->playback.formats      =3D UX500_I2S_FORMATS;
> > +	ux500_msp_dai_drv->capture.channels_min  =3D UX500_MSP_MIN_CHANNE=
LS;
> > +	ux500_msp_dai_drv->capture.channels_max  =3D UX500_MSP_MAX_CHANNE=
LS;
> > +	ux500_msp_dai_drv->capture.rates         =3D UX500_I2S_RATES;
> > +	ux500_msp_dai_drv->capture.formats       =3D UX500_I2S_FORMATS;
> > +	ux500_msp_dai_drv->ops                   =3D ux500_msp_dai_ops;
> >  };
>=20
> You can just use the same static driver for all devices. No need to
> dynamically allocate it.

How do you mean? Just create a 'static struct' instead?

> >  static const struct snd_soc_component_driver ux500_msp_component =3D=
 {
> > @@ -809,6 +742,7 @@ static const struct snd_soc_component_driver ux=
500_msp_component =3D {
> >  static int ux500_msp_drv_probe(struct platform_device *pdev)
> >  {
> >  	struct ux500_msp_i2s_drvdata *drvdata;
> > +	struct snd_soc_dai_driver *ux500_msp_dai_drv;
> >  	int ret =3D 0;
> > =20
> >  	dev_dbg(&pdev->dev, "%s: Enter (pdev->name =3D %s).\n", __func__,
> > @@ -863,8 +797,18 @@ static int ux500_msp_drv_probe(struct platform=
_device *pdev)
> >  	}
> >  	dev_set_drvdata(&pdev->dev, drvdata);
> > =20
> > +	ux500_msp_dai_drv =3D devm_kzalloc(&pdev->dev,
> > +					 sizeof(*ux500_msp_dai_drv),
> > +					 GFP_KERNEL);
> > +	if (!ux500_msp_dai_drv) {
> > +		ret =3D -ENOMEM;
> > +		goto err_init_msp;
> > +	}
> > +
> > +	ux500_msp_populate_dai_drv(ux500_msp_dai_drv);
> > +
> >  	ret =3D snd_soc_register_component(&pdev->dev, &ux500_msp_compone=
nt,
> > -					 &ux500_msp_dai_drv[drvdata->msp->id], 1);
> > +					 ux500_msp_dai_drv, 1);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "Error: %s: Failed to register MSP%d!\n",
> >  			__func__, drvdata->msp->id);
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
