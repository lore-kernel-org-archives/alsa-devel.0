From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 09:48:46 +0100
Message-ID: <20130508084846.GB3459@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508080708.GH3102@gmail.com>
 <20130508082017.GA1526@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508082017.GA1526@balto.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Fabio Baltieri wrote:

> On Wed, May 08, 2013 at 09:07:08AM +0100, Lee Jones wrote:
> > On Wed, 08 May 2013, Fabio Baltieri wrote:
> >=20
> > > Drop pinctrl default/sleep state switching code, as it was breaki=
ng the
> > > capture interface by putting the I2S pins in hi-z mode regardless=
 of its
> > > usage status, and not giving any real benefit.
> > >=20
> > > Pinctrl default mode configuration is already managed automatical=
ly by a
> > > specific pinctrl hog.
> >=20
> > I'm sure we should support pinctrl though shouldn't we?
> >=20
> > Is there no way of fixing the implementation instead of ripping it =
out?
>=20
> Yes, but requesting the default pinctrl configuration should be enoug=
h,
> and as those pins are shared with multiple device ids, a "hog"
> configuration should be the cleanest.
>=20
> Actually I asked Linus an opinion before doing this, so maybe he can =
ack
> this patch or suggest a better way of doing this, such as declaring t=
he
> same pins for multiple device ids, but I'm not sure that would work a=
s
> expected.

Linus is on vacation at the moment, but I agree he should have the
final say on this. Better wait until he returns.

> > > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > > ---
> > >  sound/soc/ux500/ux500_msp_i2s.c | 56 ++-------------------------=
--------------
> > >  sound/soc/ux500/ux500_msp_i2s.h |  6 -----
> > >  2 files changed, 2 insertions(+), 60 deletions(-)
> > >=20
> > > diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux=
500_msp_i2s.c
> > > index 964cfd6..8512c78 100644
> > > --- a/sound/soc/ux500/ux500_msp_i2s.c
> > > +++ b/sound/soc/ux500/ux500_msp_i2s.c
> > > @@ -15,7 +15,6 @@
> > > =20
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > > -#include <linux/pinctrl/consumer.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/io.h>
> > > @@ -28,9 +27,6 @@
> > > =20
> > >  #include "ux500_msp_i2s.h"
> > > =20
> > > -/* MSP1/3 Tx/Rx usage protection */
> > > -static DEFINE_SPINLOCK(msp_rxtx_lock);
> > > -
> > >   /* Protocol desciptors */
> > >  static const struct msp_protdesc prot_descs[] =3D {
> > >  	{ /* I2S */
> > > @@ -358,24 +354,8 @@ static int configure_multichannel(struct ux5=
00_msp *msp,
> > > =20
> > >  static int enable_msp(struct ux500_msp *msp, struct ux500_msp_co=
nfig *config)
> > >  {
> > > -	int status =3D 0, retval =3D 0;
> > > +	int status =3D 0;
> > >  	u32 reg_val_DMACR, reg_val_GCR;
> > > -	unsigned long flags;
> > > -
> > > -	/* Check msp state whether in RUN or CONFIGURED Mode */
> > > -	if (msp->msp_state =3D=3D MSP_STATE_IDLE) {
> > > -		spin_lock_irqsave(&msp_rxtx_lock, flags);
> > > -		if (msp->pinctrl_rxtx_ref =3D=3D 0 &&
> > > -			!(IS_ERR(msp->pinctrl_p) || IS_ERR(msp->pinctrl_def))) {
> > > -			retval =3D pinctrl_select_state(msp->pinctrl_p,
> > > -						msp->pinctrl_def);
> > > -			if (retval)
> > > -				pr_err("could not set MSP defstate\n");
> > > -		}
> > > -		if (!retval)
> > > -			msp->pinctrl_rxtx_ref++;
> > > -		spin_unlock_irqrestore(&msp_rxtx_lock, flags);
> > > -	}
> > > =20
> > >  	/* Configure msp with protocol dependent settings */
> > >  	configure_protocol(msp, config);
> > > @@ -632,8 +612,7 @@ int ux500_msp_i2s_trigger(struct ux500_msp *m=
sp, int cmd, int direction)
> > > =20
> > >  int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
> > >  {
> > > -	int status =3D 0, retval =3D 0;
> > > -	unsigned long flags;
> > > +	int status =3D 0;
> > > =20
> > >  	dev_dbg(msp->dev, "%s: Enter (dir =3D 0x%01x).\n", __func__, di=
r);
> > > =20
> > > @@ -645,18 +624,6 @@ int ux500_msp_i2s_close(struct ux500_msp *ms=
p, unsigned int dir)
> > >  			       (~(FRAME_GEN_ENABLE | SRG_ENABLE))),
> > >  			      msp->registers + MSP_GCR);
> > > =20
> > > -		spin_lock_irqsave(&msp_rxtx_lock, flags);
> > > -		WARN_ON(!msp->pinctrl_rxtx_ref);
> > > -		msp->pinctrl_rxtx_ref--;
> > > -		if (msp->pinctrl_rxtx_ref =3D=3D 0 &&
> > > -			!(IS_ERR(msp->pinctrl_p) || IS_ERR(msp->pinctrl_sleep))) {
> > > -			retval =3D pinctrl_select_state(msp->pinctrl_p,
> > > -						msp->pinctrl_sleep);
> > > -			if (retval)
> > > -				pr_err("could not set MSP sleepstate\n");
> > > -		}
> > > -		spin_unlock_irqrestore(&msp_rxtx_lock, flags);
> > > -
> > >  		writel(0, msp->registers + MSP_GCR);
> > >  		writel(0, msp->registers + MSP_TCF);
> > >  		writel(0, msp->registers + MSP_RCF);
> > > @@ -745,25 +712,6 @@ int ux500_msp_i2s_init_msp(struct platform_d=
evice *pdev,
> > >  	dev_dbg(&pdev->dev, "I2S device-name: '%s'\n", i2s_cont->name);
> > >  	msp->i2s_cont =3D i2s_cont;
> > > =20
> > > -	msp->pinctrl_p =3D pinctrl_get(msp->dev);
> > > -	if (IS_ERR(msp->pinctrl_p))
> > > -		dev_err(&pdev->dev, "could not get MSP pinctrl\n");
> > > -	else {
> > > -		msp->pinctrl_def =3D pinctrl_lookup_state(msp->pinctrl_p,
> > > -						PINCTRL_STATE_DEFAULT);
> > > -		if (IS_ERR(msp->pinctrl_def)) {
> > > -			dev_err(&pdev->dev,
> > > -				"could not get MSP defstate (%li)\n",
> > > -				PTR_ERR(msp->pinctrl_def));
> > > -		}
> > > -		msp->pinctrl_sleep =3D pinctrl_lookup_state(msp->pinctrl_p,
> > > -						PINCTRL_STATE_SLEEP);
> > > -		if (IS_ERR(msp->pinctrl_sleep))
> > > -			dev_err(&pdev->dev,
> > > -				"could not get MSP idlestate (%li)\n",
> > > -				PTR_ERR(msp->pinctrl_def));
> > > -	}
> > > -
> > >  	return 0;
> > >  }
> > > =20
> > > diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux=
500_msp_i2s.h
> > > index 1311c0d..1ce336f 100644
> > > --- a/sound/soc/ux500/ux500_msp_i2s.h
> > > +++ b/sound/soc/ux500/ux500_msp_i2s.h
> > > @@ -530,12 +530,6 @@ struct ux500_msp {
> > >  	int loopback_enable;
> > >  	u32 backup_regs[MAX_MSP_BACKUP_REGS];
> > >  	unsigned int f_bitclk;
> > > -	/* Pin modes */
> > > -	struct pinctrl *pinctrl_p;
> > > -	struct pinctrl_state *pinctrl_def;
> > > -	struct pinctrl_state *pinctrl_sleep;
> > > -	/* Reference Count */
> > > -	int pinctrl_rxtx_ref;
> > >  };
> > > =20
> > >  struct ux500_msp_dma_params {
>=20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
