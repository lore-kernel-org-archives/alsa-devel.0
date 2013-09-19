From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI
 I/O function
Date: Thu, 19 Sep 2013 12:49:10 +0100
Message-ID: <20130919114910.GE22389@lee--X1>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
 <1379527587-14567-2-git-send-email-broonie@kernel.org>
 <20130919091318.GA22389@lee--X1>
 <20130919095628.GH21013@sirena.org.uk>
 <20130919100434.GB22389@lee--X1>
 <20130919114107.GL21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130919114107.GL21013@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Marc Reilly <marc@cpdesign.com.au>, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org
List-Id: alsa-devel@alsa-project.org

> > Either way, it needs changing.
>=20
> Let's see if someone actually tests the code first though.

I've taken the liberty of bulding it, but I don't have the h/w to
actually run the code.

I get:
  drivers/mfd/mc13xxx-spi.c: In function =E2=80=98mc13xxx_spi_write=E2=80=
=99:
  drivers/mfd/mc13xxx-spi.c:97:14: warning: initialisation discards =E2=
=80=98const=E2=80=99 qualifier from pointer target type [enabled by def=
ault]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
