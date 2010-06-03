From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Thu, 3 Jun 2010 21:43:49 +1000
Message-ID: <20100603114349.GC3662@www.longlandclan.yi.org>
References: <20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
	<20100601033023.GA24820@www.longlandclan.yi.org>
	<20100601050731.GB24820@www.longlandclan.yi.org>
	<20100601113224.GA14493@www.longlandclan.yi.org>
	<20100603111455.GF10031@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id A9C97243F1
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 13:44:04 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OK8q3-0008PY-9U
	for alsa-devel@alsa-project.org; Thu, 03 Jun 2010 21:43:57 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OK8q1-0008Oy-LX
	for alsa-devel@alsa-project.org; Thu, 03 Jun 2010 21:43:55 +1000
Content-Disposition: inline
In-Reply-To: <20100603111455.GF10031@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric B?nard <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Jun 03, 2010 at 12:14:56PM +0100, Mark Brown wrote:
> On Tue, Jun 01, 2010 at 09:32:38PM +1000, Stuart Longland wrote:
> 
> I know this isn't a proper submission but a few comments below.  This
> looks like it'd be relatively easy to get submitted by stripping out a
> lot of the commented out code and custom interfaces (like the DA7210
> driver).

Yeah... I left it there for now as I'm referring to it (and other
drivers) as I go... gradually I'm replacing the ifdef'd code with my
own.

> > The CODEC driver claims total control of the I2C device, and therefore
> > makes it impossible to alter registers using i2c-tools.  However, as a
> > work-around; I have provided read/write access to the registers via
> > sysfs... we use the AIC3204 attached to I2C bus 0; the CODEC therefore
> > lives under:
> 
> > 	/sys/bus/i2c/devices/0-0018
> 
> > There are two files:
> > 	- regsel:	Takes or reports back the 16-bit register
> > 			address in hexadecimal
> > 	- regdata:	Reads or writes the value of the register
> 
> ASoC already provides register read/write access via debugfs as
> standard, there's no need to implement this.

Ahh okay, wasn't aware of this.  I shall investigate.

> > struct aic3204_setup_data {
> > 	unsigned int gpio_func[2];
> > };
> 
> This would normally be platform data in a file in include/sound so it
> can be set by the architecture code when the device is registered.

In the latest version of the driver, I've ditched this for now.  In its
place I have provided a mechanism for presetting all registers to an
arbitrary values which can be defined by the machine driver ... but even
this is temporary.

There's a lot of configuration options available; such as filter
coefficients and power modes.  These should all ultimately be done using
the existing standard APIs ... but for now, I've done something quick
and *very* dirty.

> > /* TODO: PLL */
> > /* #define ENABLE_PLL */

And I managed to get the PLL working. :-)

> > #if 0
> > 	printk( KERN_INFO "%s: pg %d reg %d[%04x] => %02x\n",
> > 			__func__, reg >> 8, reg & 0xff, reg, value[0] );
> > #endif
> 
> dev_dbg().
> 
> > }
> > 
> > /*
> >  * Perform a read/modify/write cycle on a register.
> >  *
> >  * This is a shorthand function, it reads the specified register, masks out the
> >  * bits in and_mask, applies bits in or_mask, then writes out the result to the
> >  * register.
> >  *
> >  * It returns the modified value; or a negative error code.
> >  */
> 
> There's a standard snd_soc_update_bits() function in ASoC.

I will have a look at that.  Out of interest, is there an up-to-date
guide on this information?  I'm finding it difficult to find all these
functions, much less understand what they do.

> > /*
> >  * All input lines are connected when !0xf and disconnected with 0xf bit field,
> >  * so we have to use specific dapm_put call for input mixer
> >  */
> 
> Could you explain in more detial what this is doing?  I'm not
> immediately seeing what this is doing but I suspect it might be a value
> mux?

That comment will disappear, once I know what the function it refers to
is updated (at the moment it's a stub).  The comment is one of many
left-overs from the TLV320AIC3x driver.

> > static const struct soc_enum aic3204_enum[] = {
> > 	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3204_left_dac_mux),
> 
> Use individually named variables rather than a table for legibility.

Again, this is a reminant of the old driver.  I do use separate
variables in the latest version.

> > 	/* Turn on ADC or DAC */
> > 	if ( substream->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
> > 		aic3204_write(codec, AIC3204_DACS1,
> > 				AIC3204_DACS1_LDAC_UP |
> > 				AIC3204_DACS1_RDAC_UP |
> > 				AIC3204_DACS1_LDACD_LEFT |
> > 				AIC3204_DACS1_RDACD_RIGHT |
> > 				AIC3204_DACS1_SOFT_DIS );
> 
> DAPM ought to be figuring this out for you...

Indeed, up the top of my TODO list is to figure out DAPM. :-)

> > void aic3204_set_headset_detection(struct snd_soc_codec *codec, int detect,
> > 				 int headset_debounce, int button_debounce)
> > {
> > #if 0
> 
> There's standard ASoC jack detection which this should integrate with.

I did see mention of this, and will have a look when I get closer to
that point.

> > #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> > /*
> >  * AIC3204 2 wire address can be up to 4 devices with device addresses
> >  * 0x18, 0x19, 0x1A, 0x1B
> >  */
> > 
> > /*
> >  * If the i2c layer weren't so broken, we could pass this kind of data
> >  * around
> >  */
> > static int aic3204_i2c_probe(struct i2c_client *i2c,
> > 			   const struct i2c_device_id *id)
> 
> Use standard device model registration - the driver you were basing this
> on has been converted now...

I shall have a look at that too.  For what it's worth, the comment about
the addresses is invalid... the AIC3x family were configurable, the
AIC3204 is *always* at 0x18.

I've put an updated version of the driver online... along with some
explanitory notes:

	<http://www.longlandclan.yi.org/~stuartl/asoc/>

The driver at this point plays audio fine, but won't record ... I just get
semi-random noise with a odd-looking square wave pattern.  (Not like
clipping; more like the quantisation you'd see if using 4-bit PCM.)

I'm working on the mixer interface at present... as the ADC won't record
anything useful unless the mixer is configured right.  My problem
though, is trying to understand what all the macros do.  Is there a good
reference on how to write these drivers?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
