From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 01/17] mfd: madera: Add register definitions for
 Cirrus Logic Madera codecs
Date: Mon, 03 Jul 2017 03:52:46 -0700
Message-ID: <1499079166.9885.13.camel@perches.com>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
         <1496415790-19164-2-git-send-email-rf@opensource.wolfsonmicro.com>
         <20170703103330.uka6otpdes462eym@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170703103330.uka6otpdes462eym@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-07-03 at 11:33 +0100, Lee Jones wrote:
> On Fri, 02 Jun 2017, Richard Fitzgerald wrote:
> 
> > This patch adds a header file of register definitions for Cirrus
> > Logic "Madera" class codecs. These codecs are all based off a common
> > set of hardware IP so have a common register map (with a few minor
> > device-to-device variations). These are complex devices with a large
> > number of features and so have a correspondingly large register set.
> > The registers.h file has been auto-generated from the hardware register
> > definitions, stripped down to only registers we need to access from
> > the driver
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> > Changes since V2:
> > - Used new field names for IRQ1_STATUS_33 register
> > 
> >  MAINTAINERS                          |   10 +
> >  include/linux/mfd/madera/registers.h | 8832 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 8842 insertions(+)
> >  create mode 100644 include/linux/mfd/madera/registers.h
> 
> Applied, thanks.

followed by 400k of useless quoted reply!!!

Lee.  Seriously.  Don't be impolite to others.
Remember to trim  your replies.

