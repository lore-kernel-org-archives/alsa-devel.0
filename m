From: Martin Soto <soto@informatik.uni-kl.de>
Subject: Re: EMU10K1 DSP programs
Date: 17 Sep 2002 18:38:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1032280728.408.23.camel@diesel>
References: <Pine.LNX.4.33.0209171357540.537-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209171357540.537-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2002-09-17 at 16:38, Jaroslav Kysela wrote:
> On 17 Sep 2002, Martin Soto wrote:
> > And, by the way, I have a question regarding it.  In the hardware
> > dependant ioctl interface to the EMU10K1 there are two ioctls,
> > SNDRV_EMU10K1_IOCTL_CODE_PEEK and SNDRV_EMU10K1_IOCTL_CODE_POKE, that
> > allow you to read the DSP code and to actually upload new code.  Part of
> > what SNDRV_EMU10K1_IOCTL_CODE_POKE does is defining new (mixer) controls
> > and eventually deleting those that are not needed any more.
> > 
> > However, I didn't find a way to know which current mixer controls are
> > *actually* associated to general purpose registers in the FX8010.  Of
> > course, I could read the code in emufx.c and determine it from there,
> > but that would make my code very sensible to changes in the driver.  I
> > just though of using the mixer/control interface in alsalib to find all
> > controls, and try to delete them with CODE_POKE, hoping that the driver
> > will only delete those that are connected to GPRs, but that looks too
> > much like a hack.  Is there a more elegant way to handle that?
> 
> I've added gpr_list_control* variables to emu10k1_fx8010_code_t.
> The SNDRV_EMU10K1_IOCTL_CODE_PEEK will fill these variables for you. Note 
> that all this code in emufx.c is mostly untested, so give me feedback, 
> what features/functions need to be corrected.

That was exactly what I was looking for, thanks!  I'll try to write at
least a simple loader in the following days to see if everything works
properly.

Cheers,

M. S.
-----------------------------------------------------------------
Martin Soto

AG Software Engineering
Universitaet Kaiserslautern              Tel:  +49 (631) 205-3449
Kaiserslautern, Germany         E-mail: soto@informatik.uni-kl.de
-----------------------------------------------------------------



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
