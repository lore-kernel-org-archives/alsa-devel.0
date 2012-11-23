From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Fri, 23 Nov 2012 09:12:36 +0000
Message-ID: <20121123091236.GA17471@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
 <505ADBE6.6080509@stericsson.com>
 <20120920125259.GA2755@gmail.com>
 <20121122140540.GA10986@gmail.com>
 <20121123015838.GH4385@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121123015838.GH4385@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Nov 2012, Mark Brown wrote:

> On Thu, Nov 22, 2012 at 02:05:40PM +0000, Lee Jones wrote:
> > On Thu, 20 Sep 2012, Lee Jones wrote:
>=20
> > > > > Can we have some closure on this patch please, as it's blocki=
ng the
> > > > > patch-set? I'm fairly sure the patch is doing the correct thi=
ng, as
> > > > > seconded by Mark.
>=20
> > > > I still don't like this. It is the dai_link-struct that bothers=
 me. We have
> > > > "ux500-msp-i2s.1" as name of the platform AND the cpu_dai. The =
MSP I2S-block is
> > > > not the platform and it is certainly not both platform and cpu-=
DAI at the same time.
> > > > Mark: Did you have a solution for this? Couldn't we just put NU=
LL on the
> > > > platform_name instead?
>=20
> > > There are other drivers which do this already.=20
>=20
> > > I don't think it's an issue to do this.
>=20
> > Has anyone had any more bright ideas on how we might handle this?
>=20
> > The device is still being handled in platform code and I'm desperat=
e
> > to get it out of there.
>=20
> Why do we need any ideas?  Just implement it already.

How do you mean? I've written the patch, just accept it. ;)

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
