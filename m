From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
Date: Tue, 3 Dec 2013 08:36:00 +0000
Message-ID: <20131203083600.GB11828@lee--X1>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-2-git-send-email-lee.jones@linaro.org>
 <529CCDAF.7050205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529CCDAF.7050205@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 02 Dec 2013, Lars-Peter Clausen wrote:

> On 12/02/2013 07:00 PM, Lee Jones wrote:
> > If booting with full DT support (i.e. DMA too, the last piece of th=
e
> > puzzle), then we don't need to use the compatible request channel c=
all
> > back. We also require slightly different flags to inform the core t=
hat
> > we are booting with DT.
>=20
> I don't think you need differentiate between DT and non-DT here.
> If the SND_DMAENGINE_PCM_FLAG_COMPAT is set and the
> SND_DMAENGINE_PCM_FLAG_NO_DT is not set it will first try to request =
the
> channels from the DT if that fails it will fallback to the compat pat=
h. So
> all this patch needs to do is remove the SND_DMAENGINE_PCM_FLAG_NO_DT=
, that
> should be it.

I have no way of testing that, as we are currently 80% through
shutting down platform data altogether. In fact, I think there is only
ASoC to be converted. Most of this stuff is going to be ripped out
within the next couple of weeks in any case. It will happen as soon as
I can find an hour or two to work on it.

=46or that reason I didn't want to disturb the current semantics. I've
already found that a bunch of he generic (oh, you can just use the
central) functions (for that) don't actually work for us for one
reason or another.

I plan to a) convert everything over to DT only and b) try to make the
generic functions work for us, so we can eliminate yet more code in
the very near future.

> > Cc: alsa-devel@alsa-project.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  sound/soc/ux500/ux500_pcm.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pc=
m.c
> > index 2f1bdb7..00cdd7b 100644
> > --- a/sound/soc/ux500/ux500_pcm.c
> > +++ b/sound/soc/ux500/ux500_pcm.c
> > @@ -134,15 +134,31 @@ static const struct snd_dmaengine_pcm_config =
ux500_dmaengine_pcm_config =3D {
> >  	.prepare_slave_config =3D ux500_pcm_prepare_slave_config,
> >  };
> > =20
> > +static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pc=
m_config =3D {
> > +	.prepare_slave_config =3D ux500_pcm_prepare_slave_config,
> > +};
> > +
> >  int ux500_pcm_register_platform(struct platform_device *pdev)
> >  {
> > +	const struct snd_dmaengine_pcm_config *pcm_config;
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	unsigned int pcm_flags;
> >  	int ret;
> > =20
> > -	ret =3D snd_dmaengine_pcm_register(&pdev->dev,
> > -			&ux500_dmaengine_pcm_config,
> > -			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> > -			SND_DMAENGINE_PCM_FLAG_COMPAT |
> > -			SND_DMAENGINE_PCM_FLAG_NO_DT);
> > +	if (np) {
> > +		pcm_config =3D &ux500_dmaengine_of_pcm_config;
> > +
> > +		pcm_flags =3D SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> > +			SND_DMAENGINE_PCM_FLAG_COMPAT;
> > +	} else {
> > +		pcm_config =3D &ux500_dmaengine_pcm_config;
> > +
> > +		pcm_flags =3D SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> > +			SND_DMAENGINE_PCM_FLAG_NO_DT |
> > +			SND_DMAENGINE_PCM_FLAG_COMPAT;
> > +	}
> > +
> > +	ret =3D snd_dmaengine_pcm_register(&pdev->dev, pcm_config, pcm_fl=
ags);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev,
> >  			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
