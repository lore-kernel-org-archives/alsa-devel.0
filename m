From: Martin Soto <soto@informatik.uni-kl.de>
Subject: Re: EMU10K1 DSP programs
Date: 17 Sep 2002 13:37:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1032262685.426.17.camel@diesel>
References: <Pine.LNX.4.33.0209171149030.537-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209171149030.537-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2002-09-17 at 11:49, Jaroslav Kysela wrote:
> On 16 Sep 2002, Martin Soto wrote:
> > Is it possible to load DSP programs to the EMU10K1 chip?  The alsa-tools
> > package contains a modified as10k1 that allows you to assemble such
> > programs, but there's no information about how to upload them to the
> > processor.
> 
> The work has not been finished at all. The changes in assembler are 
> incomplete and the user space linker/loader program is missing at all.

Thanks for the answer.  I actually discovered part of it yesterday after
I wrote my original mail, by looking directly at the driver code.  I'm
actually interested in writing a patch loader/manager, and as far as I
can see, the driver interface is already there.  I haven't tested it
thoroughly though, so I'm not sure it is completely operational.  But it
looks good.

And, by the way, I have a question regarding it.  In the hardware
dependant ioctl interface to the EMU10K1 there are two ioctls,
SNDRV_EMU10K1_IOCTL_CODE_PEEK and SNDRV_EMU10K1_IOCTL_CODE_POKE, that
allow you to read the DSP code and to actually upload new code.  Part of
what SNDRV_EMU10K1_IOCTL_CODE_POKE does is defining new (mixer) controls
and eventually deleting those that are not needed any more.

However, I didn't find a way to know which current mixer controls are
*actually* associated to general purpose registers in the FX8010.  Of
course, I could read the code in emufx.c and determine it from there,
but that would make my code very sensible to changes in the driver.  I
just though of using the mixer/control interface in alsalib to find all
controls, and try to delete them with CODE_POKE, hoping that the driver
will only delete those that are connected to GPRs, but that looks too
much like a hack.  Is there a more elegant way to handle that?

Cheers,

M. S.
-----------------------------------------------------------------
Martin Soto

AG Software Engineering
Universitaet Kaiserslautern              Tel:  +49 (631) 205-3449
Kaiserslautern, Germany         E-mail: soto@informatik.uni-kl.de
-----------------------------------------------------------------



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
