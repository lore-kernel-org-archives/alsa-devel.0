From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Using alsa-lib for timing
Date: Fri, 15 Nov 2002 15:16:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Cmqi-00030b-00@sc8-sf-list1.sourceforge.net>
References: <15829.12424.589673.766811@rls.cx>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 15 Nov 2002 09:36:08 PST."
             <15829.12424.589673.766811@rls.cx>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Spier <rspier@pobox.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>[Summary of this message:
>  I want to use alsa for timing of video frames, and want alsa to
>  trigger a wakeup every .01466 seconds.  But the documentation is
>  sparse in this area]
>
>
>I'm attempting to use alsa-lib as a timing tool for a specialized
>movie playback engine.  It _must_ tick/wakeup at 24fps (every .04166
>sec) and the input audio will be at 44.1khz/2 channel/16bit per chan.

you *cannot* do this with a stock linux kernel. its impossible. there
is no interrupt source that interrupts at that frequency. the firm
timers patch (probably only available for 2.4.16 at this point), or
the new POSIX clock stuff that is pending for 2.5/2.6 can do this
because they reprogram the system timer interrupt on an as-needed
basis. it provides u-sec level accuracy, in a highly efficient
fashion. 

>The general solution to this with other sound libraries (OSS and IRIX)
>is to use a rational period size and set a wakeup point.  In ALSA,
>this is done with snd_pcm_sw_params_set_avail_min, but it doesn't have
>the expected effect. 
>
>Because it's only a _minimum_ the wakeup can be delayed (usually until
>a multiple of the period size) is reached.  This screws up the
>timing.  

correct. thats why real time processes need to run:

	 * with SCHED_FIFO priority
	 * with mlockall() called
	 * on a kernel with the morton low latency patches or
	     equivalent applied.

even all these will not provide a solution that works the way you want.

	  I saw something in the alsa-devel archives that wakeup points
>(avail_min) settings can only be powers of two... which is different
>than OSS.)

no, its not different than OSS, even if the API appears to make it
so. there are almost no soundcards that interrupt at anything other
than periods-of-2 frames, and hence no matter what you set it to, the
kernel is only going to notice when the interrupt comes in, regardless
of what the API says. "why can't it notice because of the elapsed
time?" the kernel is interrupt-driven. in order to realize that a
certain amount of time has passed, it needs receive an interrupt (or
be finishing up a system call, in some cases) that give it a chance to
say "hmmm, looks like i need to service some pending tasks". that
requires an interrupt source with the desired periodicity or one that
is programmed on an as-needed ("one shot") basis. your kernel almost
certainly contains neither.

the basic problem is that you are going about this in the wrong
way. there have been many discussions here and on LAD about how to do
this sort of thing. its not easy. your first and most basic problem is
that you are trying to sync two clocks (the video frame clock and the
audio frame clock) that do *not* run in sync. any solution that starts
with this as its approach is going to fail, for better or for worse.

--p






-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
