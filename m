From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC - Support for multiple components
Date: Tue, 20 Apr 2010 02:14:19 +0900
Message-ID: <20100419171418.GD29819@opensource.wolfsonmicro.com>
References: <1271686144.3208.305.camel@odin>
	<p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
	<1271694314.3208.426.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27E0A247EE
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 19:14:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1271694314.3208.426.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Grant Likely <grant.likely@secretlab.ca>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Timur Tabi <timur@freescale.com>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 19, 2010 at 05:25:14PM +0100, Liam Girdwood wrote:
> On Mon, 2010-04-19 at 09:15 -0600, Grant Likely wrote:

> > - Related to that, how are things like i2c codecs handled?  By rights,
> > there will be an i2c device registered under the i2c bus device for
> > the control interface.  How will this relate to the ASoC model?

> I2C/SPI codecs can now register with the driver core as I2C/SPI drivers.
> e.g. the I2C/SPI device probe registers the ASoC device :-

This is very similar to the current code structurally, from the driver
point of view the main change here is that it's now become mandatory to
use device model style stuff.  This means that there's not much to be
scared about if your drivers are using that already, though
soc_of_simple never got converted.

> > - None of the drivers appear to include struct device_driver; which
> > tells me that they don't use the driver core binding model.  How do
> > drivers get bound to devices?  Why does the ASoC code create an driver
> > interface instead of using the core code (what does the core code not
> > provide)?

> ASoC doesn't fully use the driver model for components in this changeset
> (or at all) due to the complex relationships between the individual
> components for probing() and for control of PM operations (i.e. we cant
> have pops and clicks at suspend). 

> This is not to say ASoC wont use the full driver model for components in
> the future. This work is an important step on the way to achieving this
> aim. 

The ordering requirements here mean this is a *very* open question.
Linus just nacked a bunch of stuff for 2.6.34 which would have added
some ability to waiting for components to probe stuff that things like
ASoC would need to use the driver core fully.  At the minute subsystems
like ASoC which are built up of components that don't have much to do
with each other have to do something like ASoC is doing and waiting for
all the components to come online before bringing the subsystem level
devices up.

Again, this isn't much change from a driver point of view from the
situation in 2.6.34, it's more moving forward to making it mandatory
and taking advantage of the features that can be brought than anything
else.
