From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] ASoC: rsnd: fix a possible NULL dereference
Date: Thu, 26 Nov 2015 08:17:15 +0100
Message-ID: <20151126071715.GB28184@Red>
References: <1448455796-27315-1-git-send-email-clabbe.montjoie@gmail.com>
 <8737vtejg6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737vtejg6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2015 at 11:46:45PM +0000, Kuninori Morimoto wrote:
>=20
> Hi LABBE
>=20
> Thank you for your patch
>=20
> > of_match_device could return NULL, and so cause a NULL pointer
> > dereference later.
> > Even if the probability of this case is very low, fixing it made
> > static analyzers happy.
> > Solving this with of_device_get_match_data made also code simplier.
> >=20
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > ---
> >  sound/soc/sh/rcar/core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
> > index deed48e..54cc44c 100644
> > --- a/sound/soc/sh/rcar/core.c
> > +++ b/sound/soc/sh/rcar/core.c
> > @@ -1204,7 +1204,6 @@ static int rsnd_probe(struct platform_device =
*pdev)
> >  	struct rsnd_priv *priv;
> >  	struct device *dev =3D &pdev->dev;
> >  	struct rsnd_dai *rdai;
> > -	const struct of_device_id *of_id =3D of_match_device(rsnd_of_matc=
h, dev);
> >  	const struct rsnd_of_data *of_data;
> >  	int (*probe_func[])(struct platform_device *pdev,
> >  			    const struct rsnd_of_data *of_data,
> > @@ -1221,11 +1220,13 @@ static int rsnd_probe(struct platform_devic=
e *pdev)
> >  	};
> >  	int ret, i;
> > =20
> > +	of_data =3D of_device_get_match_data(dev);
> > +	if (!of_data)
> > +		return 1;
>=20
> return 1 ?
> You want to use -EINVAL ?
>=20

I do that Uwe Kleine-K=F6nig said to me to do in others thread:
https://lkml.org/lkml/2015/11/12/70 and https://lkml.org/lkml/2015/11/1=
6/211

Regards
