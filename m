From: Frank Barknecht <fbar@footils.org>
Subject: Re: vmalloc_to_page and building alsa 0.9.2 on kernel 2.4.18
Date: Tue, 22 Apr 2003 16:56:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030422145633.GA17186@fliwatut.scifi>
References: <20030422141031.GA9845@fliwatut.scifi> <s5hptneob7u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hptneob7u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, 190052@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Hallo,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:

> > I'm struggling with building alsa-0.9.2 on my trusted old kernel
> > 2.4.18. Here's some info, cc'ed to the Debian-ALSA team. Regardless of
> > what I do I always get unresolved symbols for snd-page-alloc:
> > 
> > # depmod -ae
> > depmod: *** Unresolved symbols in /lib/modules/2.4.18/alsa/snd-page-alloc.o
> > depmod:         vmalloc_to_page
> > 
> > 
> > This is a warning I get for this while compiling the modules with
> > gcc-3.2.3: 
> > 
> > sgbuf.c: In function `store_page_tables':
> > sgbuf.c:70: warning: implicit declaration of function `vmalloc_to_page'
> > sgbuf.c:70: warning: assignment makes pointer from integer without a cast
> > 
> > I'm using the sources from the Debian packages, but as I read about a
> > bug in the Makefiles, for which Clemens submitted a patch, I also
> > tried building with the (a)core Makefiles from CVS, but without
> > success.
> > 
> > Then I searched the web, what this "vmalloc_to_page" is, and I found,
> > that it should be defined in the Kernel-sources. But a "grep -rl
> > vmalloc_to_page /usr/src/linux/" returns no hits! So 2.4.18 doesn't
> > seem to have this function.
> > 
> > This also is, what the configure script detects. From "config.log":
> > 
> > configure:3735: checking for vmalloc_to_page
> > configure:3761: gcc -c -g -O2 -I/usr/src/linux/include  conftest.c >&5
> > configure: In function `main':
> > configure:3753: `vmalloc_to_page' undeclared (first use in this function)
> > configure:3753: (Each undeclared identifier is reported only once
> > configure:3753: for each function it appears in.)
> > 
> > 
> > Now alsa-driver/acore/sgbuf.c checks for a version number, before
> > using vmalloc_to_page, for example like this:
> > 
> > #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
> >                 page = vmalloc_to_page(vmaddr + (i << PAGE_SHIFT));
> > 
> > 
> > I don't know if that matters, though, it just raised my interest:
> > Could this be a wrong check? 
> > 
> > And more importantly to me: How can I get alsa-0.9.2 to work on
> > 2.4.18?
> 
> a vmalloc_to_page() wrapper is defined in the alsa-driver tree for the
> older kernels.  please make sure that you run "make clean" before
> building all.  

Well, I did that, and actually the debian-scripts force one to do it. 
I even removed the whole alsa-driver source tree. ;)

It seems, that this wrapper somehow isn't correctly called. At least I
get this unresolved symbols on my 2.4.18. 

> anyway, i would recommend you to try the cvs version.
> 
> also, please run "modprobe -r snd-page-alloc" manually after calling
> "/etc/init.d/alsasound stop".  this module will be retained even after
> alsa service is stopped.

But it didn't even load ;(

Anyway: following your advice I now built the cvs-modules, because I
just cannot be without sound for more than two days ;) 

So somehow _my_ problem is solved, but I suspect that it will bite
other users as well.

Thanks for your help.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
