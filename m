From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 10:12:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251512.i1PFCrlK026485@dhin.linuxaudiosystems.com>
References: <20040225145020.GI8820@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 25 Feb 2004 15:50:20 +0100."
             <20040225145020.GI8820@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>On Wed, Feb 25, 2004 at 09:17:54AM -0500, Paul Davis wrote:
>> There are only 2 differences associated with running the code you are
>> talking about in the kernel:
>> 
>> 	a) it runs deterministically in interrupt context
>> 	b) it avoids a context switch back into user space
>It could be more optimized too.

how can it be more optimized? code is code is code. there is no
difference (for the purposes under discussion) between kernel code and
user space code. oh, except that user space code can use the FPU which
for mixing can sometimes be pretty useful (though not essential).

>> Linux is designed to make the context switch code very, very fast - if
>> it wasn't, then a system like JACK just could not work because it too
>> relies on context switches to make things happen.
>Next userspace daemon, then alsa-oss lib which could be swapped too.

look, *any* process can be swapped, but any process can also lock all
its memory in place just like the kernel. admittedly, some priviledges
are required for this, and we (the linux audio community) are working
on ways to make this happen more easily. JACK already supports this -
when you run JACK in realtime mode, you (JACK and its clients)
*cannot* be swapped, ever.

>> drivers). When this happens, it becomes apparent just how non-realtime
>> friendly most application designs are.
>Yes that's true. So some kernel support for time critical apps
>should appear - not quite RT.

no, RT. audio interfaces are real-time devices. there is no fallback
if the s/w fails to keep up. and unlike with video, the human
perceptual system detects failures to keep up very easily.

>> sigh. of course! because the kernel has no idea that your audio
>> application needs to run with real-time priority, and is instead
>> treating all apps as if they are normal interactive programs. if you
>> tell the kernel that your app needs to run with RT priority (there are
>So why I think about some api to tell the kernel that some app nedds CPU
>in more deterministic manner. Generally if we could do this by /proc too

there is already such an API. its consists of:

      sched_setparam (2)
      mlock (2)
      mlockall (2)

this API is portable to any POSIX operating system. its not a deadline
scheduler, which OS X has because of its Mach roots, but its a
suitable alternative IMHO.

>like tunnig ALSA for particular programs it would be good for old
>proprietary programs which we couldn't improve.

"man run" [ it exists on fedora core 1, but is an old program]. 

there are new versions of the same idea, givertcap and others.

>It's not RT but some sheduler modification to treat some programs
>specially.

it *IS* RT.

>> OSS cannot affect this in any way - its a function of the kernel
>> scheduler and not the audio device API.
>OK but we could have some kernel RT thread which is doing mixing
>or MIDI emulation.

there are no kernel RT threads. there is interrupt context, and there
is everything else, in which kernel threads are scheduled in just the
same way as all other threads.

--p


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
