From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/4] ASoC SST: Add msic codec driver
Date: Tue, 28 Dec 2010 15:54:39 +0000
Message-ID: <20101228155439.GA905@opensource.wolfsonmicro.com>
References: <1293538176-31853-1-git-send-email-vinod.koul@intel.com>
	<20101228144805.GC31883@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C104CF80@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40B7A24333
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 16:54:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C104CF80@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 09:06:28PM +0530, Koul, Vinod wrote:
> On Tue, Dec 28, 2010 at 08:18:27PM +0530, Mark Brown wrote:

> > >  sound/soc/codecs/msic.h |  102 +++++++
> > >  2 files changed, 823 insertions(+), 0 deletions(-)

> > Makefile and Kconfig too please.

> We added all make and kconfig changes in patch4, if you want this to be per
> driver basic, next time I will do that way

Certainly for the CODEC driver.  For the platform stuff that's fine.

> Along with read and write the platform provides update bits api. So internally I
> call this when I want to update a bit (instead of soc_update which does and read
> and then write)

It'd still be easier to read the code if you used the standard APIs.

> On this I have a proposal if system provides a modify api can we add one more 
> function and use that in update bits. Like:
> snd_soc_update_bits()
> {
> 	if (codec->modif)
> 		codec->modify(....)
> 	rest of current update logic...
> }

I'm not sure it's worth it; I'd be more worried about the drivers
implementing this badly than anything else.  It's also not going to play
well with the register cache stuff.

> > > +		/*adding pcm 2 here for a while*/
> > > +		msic_modify(codec, MSIC_PCM2C2, BIT(0), BIT(0));
> > > +		break;

> > Hrm?

> This is PCM enable which I initially added in codec map and caused problems,
> hence the comment. Does this look apt in this place?

At least explain what the code is doing and why it's temporary.  The
comment isn't terribly clear.
 
> > Most of these look like they're just plain mute controls which would
> > more normally be represented as regular sound controls not related to
> > power, leaving these controls as PGAs (which is what they mostly appear
> > to be).  That would make the sequencing better, I expect, and would give
> > stereo controls to the application layer which is more normal. 

> So what you are proposing is to add these playback switches as PGAs?
> These are actually the output driver enable switches which should be turned on
> only when stream is active, hence added these as DAPM_SWITCH.

If they're power controls they shouldn't be user visible switches at all
and should be PGA widgets.

> > > +	/*fix the initial volume at 0dB*/
> > > +	msic_write(codec, MSIC_HSLVOLCTRL, 0x08);
> > > +	msic_write(codec, MSIC_HSRVOLCTRL, 0x08);
> > > +	msic_write(codec, MSIC_IHFLVOLCTRL, 0x08);
> > > +	msic_write(codec, MSIC_IHFRVOLCTRL, 0x08);

> > Leave these at the hardware defaults; 0dB may not be appropriate for
> > other systems (it seems rather loud for a headphone output...).

> The h/w default is +9dB hence setting it to 0.

Fail; I'm assuming this is extremely loud - if it is then please add a
comment explaining what the problem with the hardware defaults is and
why you're working around it.  It may be worth considering going to the
other extreme and muting by default.

> > > +	/*dac mode and lo w/a*/
> > > +	msic_write(codec, MSIC_SSR2, 0x10);
> > > +	msic_write(codec, MSIC_SSR3, 0x40);

> > "lo w/a"?

> Lineout w/a, unless we program these they don't work as intended :(

"w/a" isn't very clear.
