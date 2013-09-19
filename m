From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI
 I/O function
Date: Thu, 19 Sep 2013 11:04:34 +0100
Message-ID: <20130919100434.GB22389@lee--X1>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
 <1379527587-14567-2-git-send-email-broonie@kernel.org>
 <20130919091318.GA22389@lee--X1>
 <20130919095628.GH21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130919095628.GH21013@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Marc Reilly <marc@cpdesign.com.au>, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org
List-Id: alsa-devel@alsa-project.org

> Please delete irrelevant context from mails, it makes it easier to fi=
nd
> the new content that's beenn added.

I did, off the bottom.

I only left 22 lines at the top. You're just being pernickety.

> > On Wed, 18 Sep 2013, Mark Brown wrote:
>=20
> > > @@ -94,10 +94,15 @@ static int mc13xxx_spi_write(void *context, c=
onst void *data, size_t count)
> > >  {
> > >  	struct device *dev =3D context;
> > >  	struct spi_device *spi =3D to_spi_device(dev);
> > > +	char *reg =3D data;
>=20
> > I think this requires a cast.
>=20
> No, you should never need a cast to or from void in C - it probably d=
oes
> want to be a const char though.

Either way, it needs changing.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
