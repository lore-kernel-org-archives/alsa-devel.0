From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 09:17:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251417.i1PEHsZQ025905@dhin.linuxaudiosystems.com>
References: <20040225133759.GH8820@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 25 Feb 2004 14:37:59 +0100."
             <20040225133759.GH8820@sunrise.pg.gda.pl>
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

>I don't think so. If an sound app is swapped out or another app is doing
>intensive disk IO we could observe - hear - the difference.

and how can OSS help with that? ok, so we know that non-SCHED_FIFO
apps (and occasionally, even them) can be delayed by kernel-side
issues. but not keeping up with the device is not keeping up with the
device, no matter what the cause or API in use. OSS cannot mix in the
kernel unless user space has provided the data to mix. 

>aoss app can even stop and crash, some native ALSA apps too.
>Maybe they are badly designed. Generally if the kernel know about time
>critical app it can schedule them at appropriate time.
>And this could be done only by kernel. Some apps colud run slower
>and it should be acceptable - compilation or file copying for example.

There are only 2 differences associated with running the code you are
talking about in the kernel:

	a) it runs deterministically in interrupt context
	b) it avoids a context switch back into user space

Linux is designed to make the context switch code very, very fast - if
it wasn't, then a system like JACK just could not work because it too
relies on context switches to make things happen.

The linux kernel community has long seen the kernel as a place to
avoid putting any functionality that can be provided in user
space. And the evidence is there that it *can* be provided in user
space. 

The problems that you describe with existing apps is because many,
many, many existing apps are incorrectly designed. This is (IMHO)
because the APIs historically in use for Unix have encouraged
developers to ignore the real time nature of the devices they are
interacting with. They have done so by providing lots and lots of
buffering which has, till recently, been an adequate way to gloss over
the programs' problematic design. But it has now become a desirable
thing to be able to deliver audio with low latency, and this requires
a significant reduction in the buffering offered by the both the
hardware and the software layers above it (including the device
drivers). When this happens, it becomes apparent just how non-realtime
friendly most application designs are.

You can see exactly the same thing on Windows, where the MME model for
audio programming tends to produce programs that click and pop,
whereas those designed around ASIO and similar APIs do not (until
there is no alternative). 

There are no shortcuts to click-free audio: either you do a lot of
buffering or you design your application so that it is RT-safe, or at
the very least based on an RT-friendly model. 
 
>I have low latency option on and some disk io optimiztions turned on too
>but can easily observe buffer underrun and ALSA aoss app failure
>by doing high CPU and disk IO operation - opening 500MB tar.gz file
>for example.

sigh. of course! because the kernel has no idea that your audio
application needs to run with real-time priority, and is instead
treating all apps as if they are normal interactive programs. if you
tell the kernel that your app needs to run with RT priority (there are
various ways to do so), this doesn't happen (unless you so overload
the system that there is no way to keep up, but that requires quite a
lot). On a reasonable system (i.e. no interference from the video
card, sensible disk drivers etc), you can totally saturate the CPU and
disk subsystem with absolutely no audio dropouts.

OSS cannot affect this in any way - its a function of the kernel
scheduler and not the audio device API.

--p


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
