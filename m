From: "Wallace, Brooke" <brookew@qualcomm.com>
Subject: Re: trouble compiling alsa-drivers
Date: Tue, 7 Aug 2007 18:20:00 -0700
Message-ID: <C7A98C6EB85FFF4FAE03BD695D68EC76012A2ADB@NAEX05.na.qualcomm.com>
References: <C7A98C6EB85FFF4FAE03BD695D68EC760123970A@NAEX05.na.qualcomm.com><s5hbqdorb6w.wl%tiwai@suse.de><C7A98C6EB85FFF4FAE03BD695D68EC7601239941@NAEX05.na.qualcomm.com>
	<s5hfy2wq2q1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from numenor.qualcomm.com (numenor.qualcomm.com [129.46.51.58])
	by alsa0.perex.cz (Postfix) with ESMTP id 73097103819
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 03:20:09 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5hfy2wq2q1.wl%tiwai@suse.de>
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

Ok, it seems that the issue was that my kernel header linux/spinlock.h
was using "rw_lock_t" instead of "rwlock_t". I searched for both and
didn't find any other instances of "rw_lock_t", but found many
"rwlock_t". My guess is that someone changed the name recently and this
one header did not get updated properly.

After making this fix I was able to compile alsa drivers, lib and utils.

What do you think, should I post this on the Wiki somewhere, or perhaps
notify someone at RedHat?

Now I'm looking at the utils I compiled and they seem to be referencing
ALSA0.9 instead of 1.0.14 (nm aplay) which is the version I compiled.
I'm also finding that Redhat installed alsa stuff in different
directories than the 1.0.14 drop does. Is there a list of installed
components and locations I can reference? I guess what I'm looking for
now is some guide so that I can properly install my newly compiled ALSA
software and test it. Aplay is still working, but I know its not using
the new driver I compiled, and I'm pretty sure its not even using the
new lib I compiled.

Also, any idea why my Redhat installation might be running snd_azx and
snd_hda_codec modules instead of snd_hda_intel, I know my hardware is
Intell HDA? 

-Brooke


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Monday, August 06, 2007 5:15 AM
> To: Wallace, Brooke
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] trouble compiling alsa-drivers
> 
> At Fri, 3 Aug 2007 15:34:33 -0700,
> Wallace, Brooke wrote:
> > 
> > Ok, I think I see what the problem is...
> > 
> > Adriver.h is including <linux/spinlock.h>. This file defines
> > DEFINE_SPINLOCK, but CONFIG_SMP is defined so 
> RW_LOCK_UNLOCKED nerver
> > gets defined which DEFINE_SPINLOCK uses.
> 
> You mean DEFINE_RWLOCK?  Is it anywhere defined at all?
> 
> > Seems like asm/spinlock.h gets
> > included for SMP, but this file is empty on my system. Has anyone
> > compiled with SMP before? Or is my kernel just hacked badly 
> by Redhat?
> > Still, it makes me wonder because they have some version of Alsa
> > compiled in already...
> > 
> > /usr/src/kernels/2.6.9-34.EL-smp-i686/include/linux/spinlock.h
> > 
> > /*
> >  * If CONFIG_SMP is set, pull in the _raw_* definitions
> >  */
> > #ifdef CONFIG_SMP
> > #include <asm/spinlock.h>
> > 
> > [brooke] Stuff Omitted...
> > 
> > #else
> > 
> > [brooke] *********** NEVER GETS HERE ******************
> > 
> > /* RW spinlocks: No debug version */
> > 
> > #if (__GNUC__ > 2)
> >   typedef struct { } rwlock_t;
> >   #define RW_LOCK_UNLOCKED (rwlock_t) { }
> > #else
> >   typedef struct { int gcc_is_buggy; } rwlock_t;
> >   #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
> > #endif
> > 
> > [brooke] More stuff ...
> > 
> > #endif /* !SMP */
> > 
> > /*
> >  * Define the various spin_lock and rw_lock methods.  Note we define
> > these
> >  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The
> > various
> >  * methods are defined as nops in the case they are not required.
> >  */
> > #define spin_trylock(lock)      _spin_trylock(lock)
> > #define write_trylock(lock)     _write_trylock(lock)
> > 
> > [brooke] Now RW_LOCK_UNLOCKED is not defined.
> > 
> > #define DEFINE_SPINLOCK(x)      spinlock_t x = SPIN_LOCK_UNLOCKED
> > #define DEFINE_RWLOCK(x)        rw_lock_t x = RW_LOCK_UNLOCKED
> > 
> > 
> > Can I just fix this by defining RW_LOCK_UNLOCKED in 
> adriver.h or am I
> > going to get into trouble down the line? Maybe a better 
> route would be
> > to switch to a known working kernel and not use SMP for my 
> test system?
> 
> First check whether DEFINE_RWLOCK is defined any place in
> include/linux and include/asm-*.  If yes, that header file should be
> included.  If it's defined nowhere, we'll need cook up by ourselves.
> 
> 
> Takashi
> 
