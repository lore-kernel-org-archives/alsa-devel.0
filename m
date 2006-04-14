From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding a new architecture to alsa-driver
Date: Fri, 14 Apr 2006 18:56:36 +0100
Message-ID: <1145037396.9434.1.camel@localhost.localdomain>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
	 <1144545416.22490.184.camel@mindpipe>
	 <1144706767.9278.11.camel@localhost.localdomain>
	 <1144718017.18918.6.camel@mindpipe>  <s5hu0902zyr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0902zyr.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-11 at 12:01 +0200, Takashi Iwai wrote:
> At Mon, 10 Apr 2006 21:13:36 -0400,
> Lee Revell wrote:
> > 
> > On Mon, 2006-04-10 at 23:06 +0100, Adrian McMenamin wrote:
> > > On Sat, 2006-04-08 at 21:16 -0400, Lee Revell wrote:
> > > > c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200
> > > > -mdisable-fpregs"
> > > 
> > > 
> > > I have tried this patch and it doesn't work. Essentially the aica card
> > > isn't picked up. I think this has something to do with aclocal.m4 or
> > > something similar.
> > > 
> > > To be honest I've hit a brick wall and any help at all would be welcome.
> > > 
> > > 
> > 
> > Adrian,
> > 
> > OK, here's the working (I think) patch against ALSA CVS.
> > 
> > I could not figure out how to add a new arch while leaving the driver in
> > alsa-driver, so this adds it to alsa-kernel.
> 
> As I wrote in another post, it's not possible cleanly right now.
> You can include sh/Kconfig from acore/Kconfig, for example, but better
> to fix alsa-driver/utils/mod-deps.c, which generates acinclude.m4 and
> toplevel config.
> 
> > diff -Nru alsa-kernel/Makefile alsa-kernel2/Makefile
> > --- alsa-kernel/Makefile	2005-03-22 03:50:46.000000000 -0500
> > +++ alsa-kernel2/Makefile	2006-04-10 19:08:32.000000000 -0400
> > @@ -4,7 +4,7 @@
> >  obj-$(CONFIG_SOUND) += soundcore.o
> >  obj-$(CONFIG_SOUND_PRIME) += oss/
> >  obj-$(CONFIG_DMASOUND) += oss/
> > -obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
> > +obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ sh/
> >  
> >  ifeq ($(CONFIG_SND),y)
> >    obj-y += last.o
> 
> This change is not necessary.  Only the changes to Kconfigs are
> required in alsa-kernel tree.  Others can be gracefully put solely in
> alsa-driver tree.
> 
> 
> > diff -Nru alsa-kernel/sh/Makefile alsa-kernel2/sh/Makefile
> > --- alsa-kernel/sh/Makefile	1969-12-31 19:00:00.000000000 -0500
> > +++ alsa-kernel2/sh/Makefile	2006-04-10 18:59:59.000000000 -0400
> > @@ -0,0 +1,2 @@
> > +  snd-aica-objs := aica.o
> > +  obj-$(CONFIG_SND_AICA) += snd-aica.o
> 
> This should go to alsa-driver/sh/Makefile.
> 
> 
> > diff -Nru alsa-kernel/sh/aica.c alsa-kernel2/sh/aica.c
> > --- alsa-kernel/sh/aica.c	1969-12-31 19:00:00.000000000 -0500
> > +++ alsa-kernel2/sh/aica.c	2006-04-10 18:59:59.000000000 -0400
> 
> I don't comment on driver code here.
> Many things I pointed are not fixed yet...
> 
> 
> > diff -Nru alsa-driver/sh/Makefile alsa-driver2/sh/Makefile
> > --- alsa-driver/sh/Makefile	1969-12-31 19:00:00.000000000 -0500
> > +++ alsa-driver2/sh/Makefile	2006-04-10 19:01:28.000000000 -0400
> > @@ -0,0 +1,10 @@
> > +ifndef SND_TOPDIR
> > +SND_TOPDIR=..
> > +endif
> > +
> > +include $(SND_TOPDIR)/toplevel.config
> > +include $(SND_TOPDIR)/Makefile.conf
> > +
> > +include $(SND_TOPDIR)/alsa-kernel/sh/Makefile
> > +
> > +include $(SND_TOPDIR)/Rules.make
> 
> The following should be in this file in replace of
>   include $(SND_TOPDIR)/alsa-kernel/sh/Makefile
> snd-aica-objs := aica.o
> obj-$(CONFIG_SND_AICA) += snd-aica.o
> 
> 
> > diff -Nru alsa-driver/sh/aica.c alsa-driver2/sh/aica.c
> > --- alsa-driver/sh/aica.c	1969-12-31 19:00:00.000000000 -0500
> > +++ alsa-driver2/sh/aica.c	2006-04-10 19:02:31.000000000 -0400
> > @@ -0,0 +1,3 @@
> > +#include "../alsa-kernel/sh/aica.c"
> > +EXPORT_NO_SYMBOLS;
> > +
> 
> Also, aica.c and aica.h should be directly here.
> 
This worked - in the sense that the alsa setup now tries to compile the
driver. Yes, lots of things weren't fixed, but that was because I
couldn't compile the driver against the alsa sources - I can now do that
so will get on with fixing the driver.

However, I note the alsa anon cvs still seems to be shipping out code
that was meant to be fixed 10 days ago.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
