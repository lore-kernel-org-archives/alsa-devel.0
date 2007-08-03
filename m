From: "Wallace, Brooke" <brookew@qualcomm.com>
Subject: Re: trouble compiling alsa-drivers
Date: Fri, 3 Aug 2007 15:34:33 -0700
Message-ID: <C7A98C6EB85FFF4FAE03BD695D68EC7601239941@NAEX05.na.qualcomm.com>
References: <C7A98C6EB85FFF4FAE03BD695D68EC760123970A@NAEX05.na.qualcomm.com>
	<s5hbqdorb6w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from numenor.qualcomm.com (numenor.qualcomm.com [129.46.51.58])
	by alsa0.perex.cz (Postfix) with ESMTP id 41367103874
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Aug 2007 00:34:38 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5hbqdorb6w.wl%tiwai@suse.de>
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

Ok, I think I see what the problem is...

Adriver.h is including <linux/spinlock.h>. This file defines
DEFINE_SPINLOCK, but CONFIG_SMP is defined so RW_LOCK_UNLOCKED nerver
gets defined which DEFINE_SPINLOCK uses. Seems like asm/spinlock.h gets
included for SMP, but this file is empty on my system. Has anyone
compiled with SMP before? Or is my kernel just hacked badly by Redhat?
Still, it makes me wonder because they have some version of Alsa
compiled in already...

/usr/src/kernels/2.6.9-34.EL-smp-i686/include/linux/spinlock.h

/*
 * If CONFIG_SMP is set, pull in the _raw_* definitions
 */
#ifdef CONFIG_SMP
#include <asm/spinlock.h>

[brooke] Stuff Omitted...

#else

[brooke] *********** NEVER GETS HERE ******************

/* RW spinlocks: No debug version */

#if (__GNUC__ > 2)
  typedef struct { } rwlock_t;
  #define RW_LOCK_UNLOCKED (rwlock_t) { }
#else
  typedef struct { int gcc_is_buggy; } rwlock_t;
  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
#endif

[brooke] More stuff ...

#endif /* !SMP */

/*
 * Define the various spin_lock and rw_lock methods.  Note we define
these
 * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The
various
 * methods are defined as nops in the case they are not required.
 */
#define spin_trylock(lock)      _spin_trylock(lock)
#define write_trylock(lock)     _write_trylock(lock)

[brooke] Now RW_LOCK_UNLOCKED is not defined.

#define DEFINE_SPINLOCK(x)      spinlock_t x = SPIN_LOCK_UNLOCKED
#define DEFINE_RWLOCK(x)        rw_lock_t x = RW_LOCK_UNLOCKED


Can I just fix this by defining RW_LOCK_UNLOCKED in adriver.h or am I
going to get into trouble down the line? Maybe a better route would be
to switch to a known working kernel and not use SMP for my test system?

-Brooke 

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org 
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> Sent: Friday, August 03, 2007 6:37 AM
> To: Wallace, Brooke
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] trouble compiling alsa-drivers
> 
> At Thu, 2 Aug 2007 16:53:23 -0700,
> Wallace, Brooke wrote:
> > 
> > The alsa-drivers INSTALL file tells me:
> >  
> >    On 2.6 kernels, the build directory has to be given via
> > --with-build=<kernel_build_dir> option additionaly, too.
> >  
> > What exactly is mean by kernel_build_dir? I should not have 
> to recompile
> > my kernel because I already have the sourcecore module.
> 
> It's usually the directory /lib/modules/$VERSION/build points.
> --with-kernel is the directory /lib/modules/$VERSION/source points.
> In most cases they are same, but they can be different.
> 
> > Configure seems to work fine and locates my kernel source code:
> >  
> > ./configure --with-cards=hda-intel --with-sequencer=yes
> >  
> > But when I compile, it fails in acore/pcm_native.c line #75,
> > acore/pcm_native.c line #75 uses the macro DEFINE_RWLOCK which
> > apparently has not been defined yet.
> >  
> > Searching thu the alsa-drivers source, I find that include/adriver.h
> > defines this macro.
> >  
> > What am I doing wrong? Why doesn't adriver.h get included 
> when I compile
> > acore/pcm_native.c?
> >  
> >  
> > I'm using the latest release - alsa-driver-1.0.14rc4
> >  
> > My Kernel sources are: 2.6.9-34.EL-smp-i686
> 
> Maybe it's the problem.  It's a modified kernel, and many pieces are
> backported (even sometimes wrongly).  We don't guarantee that the
> driver would work with any modified kernels.
> 
> Check whether DEFINE_SPINLOCK is defined in the kernel header file,
> and wheter it lacks DEFINE_RWLOCK.  If so, the fix would be easy.
> Add DEFINE_RWLOCK under #ifndef DEFINE_RWLOCK in adriver.h.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
