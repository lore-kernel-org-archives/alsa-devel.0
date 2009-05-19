From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Add AIC3106 support.
Date: Tue, 19 May 2009 22:36:28 +0100
Message-ID: <20090519213627.GA4742@sirena.org.uk>
References: <200905091720.n49HKTSx020571@localhost.localdomain>
	<A24693684029E5489D1D202277BE89443E39393F@dlee02.ent.ti.com>
	<20090513161829.GA3629@sirena.org.uk>
	<A24693684029E5489D1D202277BE89443E661419@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD6732434F
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 23:36:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89443E661419@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ambrose, Martin" <martin@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2009 at 03:17:19PM -0500, Ambrose, Martin wrote:
> On Wed, May 13, 2009 at 11:18:30, Mark Brown wrote:

> > You should really provide a changelog explaining what's going on with
> > the chip here, especially with regard to the effect on the 
> > other devices
> > that are supported.

> My primary intent is to enable all AIC3106 functionality since my current 
> focus is on platforms which use this codec. My first patch set, which 
> admittedly was basically just a diff with the MV5 tree, added more than just 
> AIC3106 specifics. It added controls for effects, de-emphasis, and 
> attenuation coefficients which are common between the AIC33 and AIC3106 and 
> lie in the page 1 register set. To digress, I'm curious why these don't 
> already exist for the AIC33 since the source file indicates " It supports 
> full aic33 codec functionality." 

I suspect the comment is just wrong or is a non-native English error and
that the intention is to say that the driver supports everything up to
the 33 rather than everything that the 33 supports.

> add controls for the new AIC3106 page 0 registers. So, to get to my point, I 
> propose three sets of patches. The first would add page 1 register support 
> to AIC33 then a follow on patch would add the AIC3106 high pass coeff 
> support. The concept/variable of a codec variant would only be introduced in 
> the second patch set. A third patch, further out in time when I understand 
> better ALSA AGC and power management, would add support for the new page 0 
> registers.

This sounds like a good approach.

> Regarding the firs patch set, one concern I have is that this file is also 
> compatible with AIC31 and AIC32. The addition of controls without 
> qualification would result in these appearing in amixer but not actually 
> present. On the other hand this seems to be the general strategy of this 
> file. For example the AIC32 does not have register 73 but the 
> LINE2L_2_MONOLOPM_VOL control is added for all devices since it is on the 
> AIC33. Of course everything could be restructured to be more accurate on a 
> device by device basis but this seems too severe and far reaching.

Once you add support for structuring things by device variant you could
start putting the hooks in there for handling the currently supported
variants but not migrate the controls.  The controls could then be
handled in subsequent patches as people have time.

If you do convert the driver to use normal device probes (see wm8731 for
a simple example of a completed transition) then you can use the I2C
support for device variants to look up the device you're running on.

> I may subsume the new function into the old. However I do like the
> convention of leading underscore (_) to represent local/private helper
> functions. I guess this is frowned upon in the kernel source.

I can't think of many other examples - it's part of one of the reserved
namespaces in non-freestanding implementations too.

> > > +	err = snd_soc_update_bits(codec, reg_msb, 0xff, val_msb);
> > > +	if (err < 0)
> > > +		return err;

> > Just do the register write?

> Steve's response but I need to also review:
> -- Hardware values are in 2's complement and software values are in
> unsigned int.  When a value of '0' is passed in, it translated to the
> smallest possible value that should be written to hardware (which is
> 0x80000000).

I was referring to the use of snd_soc_update_bits() rather than the
value that was being written - snd_soc_update_bits() makes it look like
you're updating a bitfield when you are in fact writing the entire
register.  It seemed a bit odd, especially given the assumption about
register contents that the info function made.  Normally drivers would
just call the register write function directly, bypassing the core
(there's no benefit from going through it and the cache is internal to
the codec driver anyway).

> > > +#define TLV320AIC3X_PG1_DUAL_R(xname, reg_msb, reg_lsb) \
> > > +	TLV320AIC3X_DUAL_R(xname, AIC3X_GEN_PG1_BEG, reg_msb, reg_lsb)

> > Given that your register write code hides the register pages is there
> > any need for this to know anything about them?

> Steve's response but I need to also review:
> -- The registers 0-100 are mapped to register 0-100 of page 0, and
> registers 128 - 204 are mapped to registers 0-76 of page 1.  This macro
> adds the page 1 offset so that the write functions can tell the
> registers are for page 1.

Given that you're going to have to manually add the offset for anything
not handled by these controls are you sure that it adds any clarity to
have a special way of doing it for this one control type?

> > It'd be nice to convert the driver to use the standard I2C probing
> > stuff, though this is not essential to the patch.

> Agreed and think this should be a separate stand-alone patch for othogonality purposes.

Yes, it should be a separate patch.
