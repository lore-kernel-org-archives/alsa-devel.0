From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/22] ASoC: Ux500: Move MSP pinctrl setup into the MSP
 driver
Date: Mon, 20 Aug 2012 09:09:46 +0100
Message-ID: <20120820080945.GE8450@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
 <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, STEricsson_nomadik_linux@list.st.com, Patrice CHOTARD <patrice.chotard@stericsson.com>, Ola LILJA2 <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 14, 2012 at 10:51:02AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
>=20
> > In the initial submission of the MSP driver msp1 and msp3's associa=
ted
> > pinctrl mechanism was passed back to platform code using a plat_ini=
t()
> > call-back routine, but it has no place in platform code. The MSP dr=
iver
> > should set this up for the appropriate ports. Instead we use a use_=
pinctrl
> > identifier which is passed from platform_data/Device Tree which ind=
icates
> > which ports should use pinctrl.
> >
> > CC: alsa-devel@alsa-project.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> This is very good because it rids platform code and makes the driver
> self-contained without strange platform data hooks.
>=20
> Now details...
>=20
> > +/* MSP1/3 Tx/Rx usage protection */
> > +static DEFINE_SPINLOCK(msp_rxtx_lock);
> > +
> > +/* Pin modes */
> > +struct pinctrl *pinctrl_p;
> > +struct pinctrl_state *pinctrl_def;
> > +struct pinctrl_state *pinctrl_sleep;
> > +
> > +/* Reference Count */
> > +int pinctrl_rxtx_ref;
>=20
>=20
> But wait. These are just local statics. Surelty you can put these int=
o
> struct ux500_msp instead? Here it looks like these will be used for
> all ports, so MSP2 will enable the pins requested by MSP1 etc
> completely broken. So put it into the struct ux500_msp state
> container from ux500_msp_i2s.h where it belongs.

This was intentional, as in the previous implementation only MSP1 and
MSP3 (which share pins) were enabled for pinctrl. I will move them into
struct ux500_msp instead though, no problem

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
