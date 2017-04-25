From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 10/18] pinctrl: madera: Add driver for
 Cirrus Logic Madera codecs
Date: Tue, 25 Apr 2017 11:26:02 +0100
Message-ID: <1493115962.4826.51.camel@rf-debian.wolfsonmicro.main>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-11-git-send-email-rf@opensource.wolfsonmicro.com>
 <CACRpkdYtuu4mFf9bjz-z_kNhbgmuw7TQdQqBc66iWfFP5wp_fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2172A2667E7
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 12:26:05 +0200 (CEST)
In-Reply-To: <CACRpkdYtuu4mFf9bjz-z_kNhbgmuw7TQdQqBc66iWfFP5wp_fw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "open
 list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-04-25 at 11:41 +0200, Linus Walleij wrote:
> On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
> 
> > These codecs have a variable number of I/O lines each of which
> > is individually selectable to a wide range of possible functions.
> >
> > The functionality is slightly different from the traditional muxed
> > GPIO since most of the functions can be mapped to any pin (and even
> > the same function to multiple pins). Most pins have a dedicated
> > "alternate" function that is only available on that pin. The
> > alternate functions are usually a group of signals, though it is
> > not always necessary to enable the full group, depending on the
> > alternate function and how it is to be used. The mapping between
> > alternate functions and GPIO pins varies between codecs depending
> > on the number of alternate functions and available pins.
> >
> > Note on the Kconfig options:
> > The formula "default y if..." is used for PINCTRL_MADERA so that its
> > select options will be processed, allowing us to group selects for
> > pinctrl into the pinctrl Kconfig where they logically belong instead
> > of accumulating under the parent MFD Kconfig.
> >
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> (...)
> 
> > Changes since V1:
> 
> This is starting to look good!
> 
> In fact, kind of finished. Except:
> 
> > +       if (pdata) {
> > +               ret = pinctrl_register_mappings(pdata->gpio_configs,
> > +                                               pdata->n_gpio_configs);
> > +               if (ret) {
> > +                       dev_err(priv->dev,
> > +                               "Failed to register pdata mappings (%d)\n",
> > +                               ret);
> > +                       return ret;
> > +               }
> > +       }
> 
> What is this? It looks like boardfile support which we do not like to
> encourage. Why are the mappings not exclusively set up from
> device tree or similar?
> 

We want to work on systems that don't use DT for configuration, so we
offer pdata as a fallback across all the drivers. In that case the
configuration is defined as part of the parent pdata struct and this
applies it.

> Yours,
> Linus Walleij
