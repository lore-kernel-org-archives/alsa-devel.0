From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2] ASoC: sun4i-i2s: move code from
 startup/shutdown hooks into pm_runtime hooks
Date: Wed, 17 Oct 2018 09:45:39 +0200
Message-ID: <20181017074539.b6qeft5oba45dv5r@flea>
References: <20181016031141.16259-1-anarsoul@gmail.com>
 <20181016071626.m6jkoiixkvxks5ob@flea>
 <CA+E=qVcK7mBbZ-C8FyAxUty_wQ_aOjo1b0+iU4E5CgG=yBCj=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4919091027692826390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 1576A267545
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 09:45:49 +0200 (CEST)
In-Reply-To: <CA+E=qVcK7mBbZ-C8FyAxUty_wQ_aOjo1b0+iU4E5CgG=yBCj=g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Yong Deng <yong.deng@magewell.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4919091027692826390==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tcyw3tqz357wqfwd"
Content-Disposition: inline


--tcyw3tqz357wqfwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 08:08:41PM -0700, Vasily Khoruzhick wrote:
> On Tue, Oct 16, 2018 at 12:16 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Oct 15, 2018 at 08:11:41PM -0700, Vasily Khoruzhick wrote:
> > > startup() and shutdown() hooks are called for both substreams,
> > > so stopping either substream when another is running breaks the
> > > latter.
> > >
> > > E.g. playback breaks if capture is stopped when playback is running.
> > >
> > > Move code from startup() and shutdown() to resume() and suspend()
> > > hooks respectively to fix this issue
> > >
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > > v2: - rename from "ASoC: sun4i-i2s: don't try to start up
> > >                  or shut down DAI if it's active"
> > >     - move code from startup/shutdown hooks into pm_runtime
> > >
> > >  sound/soc/sunxi/sun4i-i2s.c | 61 +++++++++++++++--------------------=
--
> > >  1 file changed, 25 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > > index a4aa931ebfae..daa6c08cffbc 100644
> > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > @@ -644,40 +644,6 @@ static int sun4i_i2s_trigger(struct snd_pcm_subs=
tream *substream, int cmd,
> > >       return 0;
> > >  }
> > >
> > > -static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
> > > -                          struct snd_soc_dai *dai)
> > > -{
> > > -     struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> > > -
> > > -     /* Enable the whole hardware block */
> > > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > -                        SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
> > > -
> > > -     /* Enable the first output line */
> > > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > -                        SUN4I_I2S_CTRL_SDO_EN_MASK,
> > > -                        SUN4I_I2S_CTRL_SDO_EN(0));
> > > -
> > > -
> > > -     return clk_prepare_enable(i2s->mod_clk);
> > > -}
> > > -
> > > -static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
> > > -                            struct snd_soc_dai *dai)
> > > -{
> > > -     struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> > > -
> > > -     clk_disable_unprepare(i2s->mod_clk);
> > > -
> > > -     /* Disable our output lines */
> > > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > -                        SUN4I_I2S_CTRL_SDO_EN_MASK, 0);
> > > -
> > > -     /* Disable the whole hardware block */
> > > -     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > -                        SUN4I_I2S_CTRL_GL_EN, 0);
> > > -}
> > > -
> > >  static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> > >                               unsigned int freq, int dir)
> > >  {
> > > @@ -695,8 +661,6 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai=
_ops =3D {
> > >       .hw_params      =3D sun4i_i2s_hw_params,
> > >       .set_fmt        =3D sun4i_i2s_set_fmt,
> > >       .set_sysclk     =3D sun4i_i2s_set_sysclk,
> > > -     .shutdown       =3D sun4i_i2s_shutdown,
> > > -     .startup        =3D sun4i_i2s_startup,
> > >       .trigger        =3D sun4i_i2s_trigger,
> > >  };
> > >
> > > @@ -869,6 +833,21 @@ static int sun4i_i2s_runtime_resume(struct devic=
e *dev)
> > >               goto err_disable_clk;
> > >       }
> > >
> > > +     /* Enable the whole hardware block */
> > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > +                        SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
> > > +
> >
> > So this is definitely needed
> >
> > > +     /* Enable the first output line */
> > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > +                        SUN4I_I2S_CTRL_SDO_EN_MASK,
> > > +                        SUN4I_I2S_CTRL_SDO_EN(0));
> > > +
> > > +     ret =3D clk_prepare_enable(i2s->mod_clk);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to enable module clock\n");
> > > +             goto err_disable_clk;
> > > +     }
> >
> > But we really don't want to enable the module clock before the
> > playback / capture actually starts. And I'm guessing it would make
> > more sense to keep the output enable configuration there as well,
> > since it's likely that we will have support for it in the future, and
> > we'll need additional information from ASoC when we'll do.
>=20
> Should we go with v1 version of my patch then? I see no reason to
> shuffle code around if we keep startup() and shutdown() hooks.

I'd go for something in between. runtime_pm already provides whether
the device is active or not, so you can just move the
SUN4I_I2S_CTRL_GL_EN write to the runtime_resume and runtime_suspend
functions, and that should fix your issue.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tcyw3tqz357wqfwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvG6KIACgkQ0rTAlCFN
r3TJqA//XC908084US0fSHEu+xTdfFXsHS8UaqdbK0iq1QFWiSsAbhul+buJe03X
WP8grdpRL4O4w66g1X1JeB5NdGLW4RbgKDD8AhOwm1Ws4BVft4JmOlbxrsg5NZiU
7prZmaBrdEQY5UvlsG5QGsMSkNZySMv1xdxpGh6yd9LY0aSlNudjaxuAvY1L0/kb
+leOsNZFKc8i0aS/62ViL9IlgMvYTyI96jmf7UY6q4IiBRNrqhHD3VfS3ym4NcTF
glWtkPjW7eAHyhndnS0aLMnYY9WOKy+My8IjTZjwNW8/Dl/ITtGZhAgV20bm7DXE
4kbTMgB+CGobPv4yvmPJhPb+x9jYGvFMzSwOS3ecph8ENHjiWZTTIqktWyWo4891
PaFkHOPyLb/3pW3WUWjhA1unh9jkObOTnlh9gBIVG5Tn4HlQTuqvjeViUE52U76L
3O1ZbvzDxd5uXUH1KWuRbTUVhyCbmbk3HJU7Wnzz7rjPsM29UKF6qdgsafyc5p5K
XLj8rB7L1g+mlbs2coLSukJl+LJQRBz2MwK2AoD8vahqzc3bo8CgAmZWc8IHKWli
n0Ixqwzo5puT/hjUEgy+/GHeNfOdTkSlStKJRSUgg6ksq3plHRHLf1DliQDOLnG2
dqO7YMsUC60179MxoqlqXIwBswCuIcjvaG+5SqXHCiZzcT+r9sg=
=qlKx
-----END PGP SIGNATURE-----

--tcyw3tqz357wqfwd--

--===============4919091027692826390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4919091027692826390==--
