From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allow codecs to override register
	display
Date: Fri, 18 Jul 2008 21:38:49 +0100
Message-ID: <20080718203849.GA16900@opensource.wolfsonmicro.com>
References: <1216378642-14987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807180823o1ec3e735y55b4d847467770b7@mail.gmail.com>
	<s5hsku7fbrx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA3672457C
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 22:38:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsku7fbrx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2008 at 05:32:50PM +0200, Takashi Iwai wrote:
> Jon Smirl wrote:

> > My address space is sparse like Grant's. How about display_register()
> > returning -1 to skip the register address. The part printing the

> > address would need to be suppressed too.
> > count += sprintf(buf + count, "%2x: ", i);

If we want to do sparse register maps I'd really much rather we did it
by providing the core with explicit information about it and providing
guarantees that only specified registers will be read rather than by
adding it separately to each interface.  This would make review easier
and makes it easier to add new features like...

> > This loop needs to be protected to not write over the sysfs limit of

> > Alternatively you could just make the entire codec_reg_show() overridable.

> Yes, I agree.  For non-standard register maps, provide its own
> codec_reg_show().

I'd really like a way to just display the value of a register anyway for
some other work I've been thinking of.  

One of the issues that users run into is that it can be difficult to go
from the datasheet to the ALSA controls and back again, especially on
more complex chips.  The scenario API is one part of dealing with this
but that doesn't help the people doing the initial system setup and
generatig the scenarios.  They could be helped by exporting more
information to user space about the mappings and the register values
seem like they could be a useful part of that.  It's likely that at
least some of this will done by user space but even then it still
becomes more important to keep the format of the sysfs files regular.
Right now I'm not working on this since we've been focused on the v2
merge.

The underlying thing here is that the more code we keep in the core the
easier it is to maintain the subsystem and the less redundant code we
have in individual drivers.

> > Might want to add another parameter for cached/uncached. Then we could
> > make a debug option to add the non-cached display.

> That makes sense, too.

I've considered doing that myself - I'd say just via a second sysfs file
that's always there, there doesn't seem much win from making it a debug
only option and it'd be a pain to have to enable it when you do need it.
This would need to be optional (conditional on having a hardware read
function, I imagine) since a lot of devices don't actually provide any
register read capability in hardware so couldn't support it.

> > PAGE_SIZE in the result. I think you will corrupt memory if PAGE_SIZE
> > is exceeded.

> Right.  So far, it's been OK since the number of registers is
> relatively small.

This is a good point, and will likely be an issue for some of the debug
interfaces I have been considering.  A separate patch, though...
