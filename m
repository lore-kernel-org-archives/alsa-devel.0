From: Yang Fang <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: ts3a227e: do not report jack status
 when there is i2c read err
Date: Wed, 1 Jul 2015 10:34:09 -0700
Message-ID: <20150701173409.GA111758@mocha>
References: <1435724282-109761-1-git-send-email-yang.a.fang@intel.com>
 <CAEUnVG6fLa_+rnmFQ1zWZod25pJomO6xqLbshj8_t8AhhtK9Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D7BCA26154E
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 19:35:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAEUnVG6fLa_+rnmFQ1zWZod25pJomO6xqLbshj8_t8AhhtK9Sg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, yang.a.fang@intel.com, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Denny Iriawan <denny.iriawan@intel.com>, Mark Brown <broonie@kernel.org>, "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>, kevin.strasser@linux.intel.com, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 01, 2015 at 10:12:37AM -0700, Dylan Reid wrote:
> On Tue, Jun 30, 2015 at 9:18 PM,  <yang.a.fang@intel.com> wrote:
> > From: "Fang, Yang A" <yang.a.fang@intel.com>
> >
> > After suspend -> resume the ts3a227e_interrupt sometimes comes before i2c
> > controller resume is called .regmap_read will return incorrect status
> > and report a wrong jack status.We should return if there is read err,the
> > interrupt will come again since it is level triggered and we are not yet
> > clear the interrupt. In addtion,cht_bsw_max98090_ti machine driver
> > registered additional notifier base on jack event which will program
> > the audio codec.there will be codec timeout err if such event occurs
> > prior to i2c controller is resumed.
> 
> Thanks, I think the error checking is good to have anyway, but should
> the interrupt also be disabled across suspend/resume?  I'd hope this
> device's resume callback wouldn't happen until after the parent i2c
> bus is ready.
I am looping Mika. I was expecting that interrupt would come after i2c
bus is ready. but with current pinctrl-cherryview driver the interrupt
comes in random order after resume.
> 
> >
> > Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> > ---
> >  sound/soc/codecs/ts3a227e.c |   18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
> > index 12232d7..12d0f2a 100644
> > --- a/sound/soc/codecs/ts3a227e.c
> > +++ b/sound/soc/codecs/ts3a227e.c
> > @@ -23,6 +23,7 @@
> >  #include "ts3a227e.h"
> >
> >  struct ts3a227e {
> > +       struct device *dev;
> >         struct regmap *regmap;
> >         struct snd_soc_jack *jack;
> >         bool plugged;
> > @@ -189,16 +190,28 @@ static irqreturn_t ts3a227e_interrupt(int irq, void *data)
> >         struct ts3a227e *ts3a227e = (struct ts3a227e *)data;
> >         struct regmap *regmap = ts3a227e->regmap;
> >         unsigned int int_reg, kp_int_reg, acc_reg, i;
> > +       struct device *dev = ts3a227e->dev;
> > +       int ret;
> >
> >         /* Check for plug/unplug. */
> > -       regmap_read(regmap, TS3A227E_REG_INTERRUPT, &int_reg);
> > +       ret = regmap_read(regmap, TS3A227E_REG_INTERRUPT, &int_reg);
> > +       if (ret) {
> > +               dev_err(dev, "failed to clear interrupt ret=%d\n", ret);
> > +               return IRQ_HANDLED;
> > +       }
> > +
> >         if (int_reg & (DETECTION_COMPLETE_EVENT | INS_REM_EVENT)) {
> >                 regmap_read(regmap, TS3A227E_REG_ACCESSORY_STATUS, &acc_reg);
> >                 ts3a227e_new_jack_state(ts3a227e, acc_reg);
> >         }
> >
> >         /* Report any key events. */
> > -       regmap_read(regmap, TS3A227E_REG_KP_INTERRUPT, &kp_int_reg);
> > +       ret = regmap_read(regmap, TS3A227E_REG_KP_INTERRUPT, &kp_int_reg);
> > +       if (ret) {
> > +               dev_err(dev, "failed to clear key interrupt ret=%d\n", ret);
> > +               return IRQ_HANDLED;
> > +       }
> > +
> >         for (i = 0; i < TS3A227E_NUM_BUTTONS; i++) {
> >                 if (kp_int_reg & PRESS_MASK(i))
> >                         ts3a227e->buttons_held |= (1 << i);
> > @@ -283,6 +296,7 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
> >                 return -ENOMEM;
> >
> >         i2c_set_clientdata(i2c, ts3a227e);
> > +       ts3a227e->dev = dev;
> >
> >         ts3a227e->regmap = devm_regmap_init_i2c(i2c, &ts3a227e_regmap_config);
> >         if (IS_ERR(ts3a227e->regmap))
> > --
> > 1.7.9.5
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
