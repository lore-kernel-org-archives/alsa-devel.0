From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/8] ASoC: da9055: Fix device registration of PMIC and
 CODEC devices
Date: Mon, 10 Feb 2014 11:51:09 +0000
Message-ID: <20140210115109.GC22773@lee--X1>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <20140207105657.GL14727@lee--X1>
 <20140207125831.GL32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140207125831.GL32298@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

> > > +/*
> > > + * DO NOT change the device Ids. The naming is intentionally spe=
cific as both
> > > + * the PMIC and CODEC parts of this chip are instantiated separa=
tely as I2C
> > > + * devices (both have configurable I2C addresses, and are to all=
 intents and
> > > + * purposes separate). As a result there are specific DA9055 ids=
 for PMIC
> > > + * and CODEC, which must be different to operate together.
> > > + */
>=20
> > I'm not sure this comment is required.
>=20
> They are, we've already had the suffixes removed from both PMIC and
> CODEC drivers by people doing code review causing the drivers to fail=
 to
> load for several kernel releases (this should be tagged to stable as =
a
> result).
>=20
> > Most device IDs are named this way.
>=20
> Having the suffix on a subdevice would be normal but it's not normal =
for
> the primary I2C device, usually you can just put the part number in.

Okay, no problem then. Ignore my last.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
