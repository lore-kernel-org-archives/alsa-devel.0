From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: usr/include/linux/soundcard.h warnings for 'make headers_check'
Date: Wed, 04 Feb 2009 09:34:12 +0530
Message-ID: <1233720252.3595.5.camel@localhost.localdomain>
References: <1232465902.3088.31.camel@localhost.localdomain>
	 <s5h7i4psepm.wl%tiwai@suse.de> <20090121054138.GA26551@uranus.ravnborg.org>
	 <200902032127.24526.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755449AbZBDEFS@vger.kernel.org>
In-Reply-To: <200902032127.24526.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-02-03 at 21:27 +0100, Arnd Bergmann wrote:
> On Wednesday 21 January 2009, Sam Ravnborg wrote:
> > 
> > > No, these are declarations for OSS-lib.
> > > It doesn't belong to kernel, but it's better to keep it for
> > > compatibility in some way.
> > 
> > But not in the kernel for sure.
> > I just checked and for example: OSS_init is not used anywhere in the kernel.
> > The kernel headers are not a "dump all your stuff" ground anymore.
> > 
> > So I encourage you to find a better home for the user space library definitons.
> > We can let the definiton stay for a while - but eventually they have to
> > be dropped from the kernel.
> 
> The last free version of OSSlib that matches this header is from ~1997, and
> no current distro appears to be shipping it. All new OSSlib versions (the
> oldest I found was from ~2003) contain in their documentation:
> 
> "Older versions of some OSS include files are distributed
>  with various operating systems. There is no danger in
>  using them but applications written for more recent OSS
>  versions will not compile with older header files.
> 
>  The latest versions of these include files (such as
>  soundcard.h) are distributed in ../include/sys. Use
>  the -I/usr/lib/oss/include switch when compiling
>  programs. Alternatively copy these files to /usr/include/sys
>  so that they replace the original ones."
> 
> I think it's safe enough to assume that everyone that builds against
> OSSlib by now also has the correct version of the header installed.
> Consequently, we should just drop the #ifndef __KERNEL__ section
> of soundcard.h (all the macros in there depend on the extern
> declarations), and maybe add an
> 
> #ifdef OSSLIB
> #error need to use <sys/soundcard.h> from libOSSlib
> #endif
> 

sys/soundcard.h is also pointing to linux/soundcard.h, we need to move
all this stuff to sys/soundcard.h.

Sam also requested to move this stuff to other place.

We are waiting for Takashi reply.

--
JSR
