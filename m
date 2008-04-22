From: Tim Niemeyer <tim.niemeyer@mastersword.de>
Subject: Re: [PATCH 5/5] soc - s3c24xx - Improve diagnostic
	output
Date: Tue, 22 Apr 2008 16:26:15 +0200
Message-ID: <20080422142615.GD29665@kassel081.server4you.de>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hprsi9du5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1805504075814840582=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mastersword.de (mastersword.de [62.75.246.81])
	by alsa0.perex.cz (Postfix) with ESMTP id EBAD51037F1
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 16:26:20 +0200 (CEST)
In-Reply-To: <s5hprsi9du5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============1805504075814840582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Takashi,

i think, if i change this, the other lines in the file, that use also the
__FUNCTION__, should be changed also.
Later in the evening, i could do this, but at the moment i have to
listen to my BWL-lesson.

* Takashi Iwai <tiwai@suse.de> [22-04-08 16:14]:
> At Tue, 22 Apr 2008 14:14:39 +0100,
> Mark Brown wrote:
> >=20
> > From: Tim Niemeyer <tim.niemeyer@mastersword.de>
> >=20
> > Add some debug messages for suspend/resume and to add a clear prefix to
> > s3c24xx-i2s and s3c24xx-pcm.
> >=20
> > Signed-off-by: Tim Niemeyer <reddog@mastersword.de>
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>=20
> Got the following checkpatch warnings.  Please fix.
>=20
> WARNING: __func__ should be used instead of gcc specific __FUNCTION__
> #17: FILE: soc/s3c24xx/s3c24xx-i2s.c:418:
> +	DBG("Entered %s\n", __FUNCTION__);
>=20
> WARNING: __func__ should be used instead of gcc specific __FUNCTION__
> #25: FILE: soc/s3c24xx/s3c24xx-i2s.c:432:
> +	DBG("Entered %s\n", __FUNCTION__);
>=20
>=20
> thanks,
>=20
> Takashi
>=20
>=20
> > ---
> >  sound/soc/s3c24xx/s3c24xx-i2s.c |    4 +++-
> >  sound/soc/s3c24xx/s3c24xx-pcm.c |    2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24x=
x-i2s.c
> > index 6b3cbbf..b7eca98 100644
> > --- a/sound/soc/s3c24xx/s3c24xx-i2s.c
> > +++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
> > @@ -46,7 +46,7 @@
> > =20
> >  #define S3C24XX_I2S_DEBUG 0
> >  #if S3C24XX_I2S_DEBUG
> > -#define DBG(x...) printk(KERN_DEBUG x)
> > +#define DBG(x...) printk(KERN_DEBUG "s3c24xx-i2s: " x)
> >  #else
> >  #define DBG(x...)
> >  #endif
> > @@ -415,6 +415,7 @@ static int s3c24xx_i2s_probe(struct platform_device=
 *pdev)
> >  int s3c24xx_i2s_suspend(struct platform_device *pdev,
> >  		struct snd_soc_cpu_dai *cpu_dai)
> >  {
> > +	DBG("Entered %s\n", __FUNCTION__);
> >  	s3c24xx_i2s.iiscon =3D readl(s3c24xx_i2s.regs + S3C2410_IISCON);
> >  	s3c24xx_i2s.iismod =3D readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
> >  	s3c24xx_i2s.iisfcon =3D readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
> > @@ -428,6 +429,7 @@ int s3c24xx_i2s_suspend(struct platform_device *pde=
v,
> >  int s3c24xx_i2s_resume(struct platform_device *pdev,
> >  		struct snd_soc_cpu_dai *cpu_dai)
> >  {
> > +	DBG("Entered %s\n", __FUNCTION__);
> >  	clk_enable(s3c24xx_i2s.iis_clk);
> > =20
> >  	writel(s3c24xx_i2s.iiscon, s3c24xx_i2s.regs + S3C2410_IISCON);
> > diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24x=
x-pcm.c
> > index 29a6c82..5394a40 100644
> > --- a/sound/soc/s3c24xx/s3c24xx-pcm.c
> > +++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
> > @@ -39,7 +39,7 @@
> > =20
> >  #define S3C24XX_PCM_DEBUG 0
> >  #if S3C24XX_PCM_DEBUG
> > -#define DBG(x...) printk(KERN_DEBUG x)
> > +#define DBG(x...) printk(KERN_DEBUG "s3c24xx-pcm: " x)
> >  #else
> >  #define DBG(x...)
> >  #endif
> > --=20
> > 1.5.5
> >=20
>=20


Tim Niemeyer

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDfWHGbn/Eak8UZYRAuI0AKCcRcAGxH7WGaQe5miEbFxkbtD0xwCgij+k
UPGmoGF05jcoMzvYrNS0SNI=
=x1MW
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

--===============1805504075814840582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1805504075814840582==--
