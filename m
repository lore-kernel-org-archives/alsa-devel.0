From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 10:27:34 +1000
Message-ID: <20100615002734.GB7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 897E32442C
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 02:27:53 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOK0H-0001SB-RP
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:27:47 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOK0C-0001R6-MJ
	for alsa-devel@alsa-project.org; Tue, 15 Jun 2010 10:27:45 +1000
Content-Disposition: inline
In-Reply-To: <20100611101803.GB12436@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 11:18:04AM +0100, Mark Brown wrote:
> On Fri, Jun 11, 2010 at 03:55:12PM +1000, Stuart Longland wrote:
> =

> > (1)	When using the SOC_DOUBLE_R_SX_TLV controls, I notice there's an
> > 	odd interaction between the mute switch associated with the
> > 	control, and its corresponding gain setting.
> =

> > 	Nothing changes in the actual registers (except the mute bit of
> > 	course) but the displayed gain shoots up to infinity if the mute
> > 	is toggled when the gain associated with that mute control is
> > 	set below 0dB.  When the gain is at 0dB or above, toggling the
> > 	mute has no effect on the displayed gain setting.
> =

> This is almost always due to having an overlap between the bitfield for
> the volume and the mute bit.

I'll have a closer look, perhaps there's some misunderstanding on my
part as to how the macros work.

I've started documenting some of this stuff on the ALSA Wiki at
<http://www.alsa-project.org/main/index.php/DAPM>.  I'm hoping this
might be a useful resource for others.  Was about to do it on an
intranet wiki here, but figured it'd be of benefit to others too.

> > (2)	On the TLV320AIC3204, the clocks used on the audio bus can either
> > 	be sourced from the ADC clocks, or the DAC clocks.  Naturally,
> > 	before you see any clocks on the bus, you must first power up
> > 	either the DAC or ADC (or both), and choose the appropriate
> > 	source.  I do this currently in the hw_params callback (right
> > 	where I *used* to power up the DACs/ADCs, DAPM does this now).
> =

> SND_SOC_DAPM_SUPPLY can help you here - you can have a conditional
> supply.

Is there an example of the supply doing something like this?  I'm
thinking a mux might be the way to represent it, but it's then a matter
of getting DAPM to switch the MUX over to the other source when the
current source gets shut down.

The DAC clocks disappear when the DAC powers down.  Likewise with the
ADC in this case.  I'm not sure how to represent this in terms of DAPM
widgets, but I'll have a closer look at the other CODEC drivers.

> > (3)	The sysfs interface of my driver still remains.  I had a look at
> > 	using the ASoC debugfs interface, however there are a *lot* of
> > 	registers on the 'AIC3204 in a sparse memory map.  When I try to
> > 	inspect the registers via
> > 	/sys/kernel/debug/asoc/tlv320aic3204.0-0018/codec_reg ... I
> > 	notice there are more registers in the device than are
> > 	accessible via this interface:
> =

> Provide a display_register() callback which filters out the undefined
> registers or otherwise improve the standard functionality.

I shall look into this... but a thought, is there any merrit in the
two-file (register select" and "register data") interface to the CODEC
registers?  The current interface looks great if you want to quickly get
a register dump, but the solution I have is easily used in scripts.

If there's some interest I can port my SYSFS interface over to DebugFS,
and move it into the DAPM core where it can be used by others.
Basically the interface I had come up with, was meant to directly
replace i2cset and i2cget which become unusable once a driver claims
control of an I=B2C device.

> > The driver is still using the registration model that was used in kernel
> > 2.6.34.  I've managed to backport the ALSA tree to 2.6.28 for our
> > project (since that's what's officially supported by Ka-Ro) and so far,
> > it's working, although things are still quite crude.
> =

> If you could convince Ka-Ro to work with mainline that'd be nice :/

Indeed, I'll start looking into that at a later date, as it was a major
thorn in our side not being able to grab the latest mainline kernel and
have it "just work".  That said, I can also understand the trouble it
might cause from a support point-of-view.  Hence the softly-softly
approach. :-)

I have a patch for 2.6.34 that adds support for the Ka-Ro TX27, but I'd
like to run it past Ka-Ro before I make it publically available ... to
prevent them getting a barrage of queries about a kernel they don't
support.

In any case, the move from 2.6.34 to git HEAD is not a big one, and I'll
do that as one of the final steps before submitting a patch of the
driver.

> > I cache more of the registers now, I tried doing something "clever" and
> > skipping the pages of registers that aren't used and trying to cache
> > just the pages that were meaningful, but I noticed that the rest of ALSA
> > more or less assumed the register address used with cache was the real
> > address.  Digging around on the mailing list about how to handle a
> > sparse register map lead me to the solution of just biting the bullet
> > and caching all 80-odd pages.  Wasteful on memory, but I won't miss
> > anything.
> =

> If the registers are mostly clustered at the starts of pages then an
> array of pointers to per-page arrays might do the trick.

As in this?

	static u8 aic3204_reg_page0[128];
	static u8 aic3204_reg_page1[128];
	static u8 aic3204_reg_page8[128];
	static u8 aic3204_reg_page9[128];
	/* ... */
	static u8* aic3204_reg_cache[81] =3D {
		aic3204_reg_page0,
		aic3204_reg_page1,
		NULL,
		NULL,
		NULL,
		/* ... */
		aic3204_reg_page8,
		aic3204_reg_page9,
		/* ... */
	};

I wasn't sure how compatible that would be with the rest of ALSA, but I
might give that a try shortly.

> > The driver still has an initialisation script facility, whereby custom
> > register settings can be made at init.  I'm still undecided as to
> > whether to keep this or not... it's not the "done thing", but if I leave
> > it there, it allows for custom adaptive filtering coefficients and other
> > parameters to be set by the machine driver, which may be useful in some
> > applications.  Is it worth cleaning this up, or should it be ditched
> > before the driver is submitted for inclusion?
> =

> If the data is stuff that's calculated off-line then it's reasonable to
> supply specific bits of data via platform data, several existing drivers
> do this for filter coefficients.  Providing completely arbatrary
> register writes is not suitable for mainline.

I didn't think it would be somehow. :-)  I'll have a look for a few
examples and see if I can convert this driver across.  For what it's
worth, I haven't yet looked at the adaptive filtering capabilities of
this CODEC -- it does have them.

> > The driver is accessible online at
> > <http://www.longlandclan.yi.org/~stuartl/asoc/> along with some comments
> > about how to add it to your kernel sources.  I'd appreciate any feedback
> > or advice on how the driver can be improved.
> =

> Please post to the mailing list if you want review - the standard
> workflow is to provide comments by replying to the patch.

No problems, I'll post the code to the list in a moment.  Last time I
tried this it got held for moderation because the email was too big.
Hence my posting it to a website and linking to it.  I'll post the files
up in my next email.  When things are a little more mature, I'll post
the patch for the driver.
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
