From: Sean McNamara <smcnam@gmail.com>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 12:57:40 -0400
Message-ID: <CAPAActdwvYh+RYwk=wD1qvZKQV24bZZE-bMh6jhzp1GH-m_nzA@mail.gmail.com>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
	<4E70C260.3040001@ladisch.de>
	<CA+jNppnG5UbUOuxqDc-kmR5-pO1n7BX4922d109XV66jXyR-Jg@mail.gmail.com>
	<CAPAActeAqyEW_YtYm-aK8u-c=Ej9qsc4o5QHaj-nM9i9LX8+hQ@mail.gmail.com>
	<CA+jNppm327XnUPQ85XSE9NAWkuyD5KeUxoEZc=r0pxZcQzz=ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E76B410380B
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 18:57:41 +0200 (CEST)
Received: by yie16 with SMTP id 16so1305485yie.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 09:57:41 -0700 (PDT)
In-Reply-To: <CA+jNppm327XnUPQ85XSE9NAWkuyD5KeUxoEZc=r0pxZcQzz=ig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Sep 14, 2011 at 12:20 PM, Mike Crowe <drmikecrowe@gmail.com> wrote:
> Sean,
>
>> Right, but if you're using the in-kernel OSS emulation, it bypasses
>> the userspace ALSA-lib plug layer! You'll have to resample it in
>> userspace within the OSS application, probably.
>>
>> Or, you can use osspd (sometimes referred to as ossp or oss-proxy):
>> http://sourceforge.net/projects/osspd/
>
> I had started to look at aoss. =A0Any thoughts on comparing the two?
> Memory is tight, so I'm looking for the smallest memory footprint
> possible.

aoss is a terrible hack. From what I understand (after glancing at the
code years ago), it seems that it intercepts libc system calls to the
standard functions, and overrides them with an LD_PRELOADed library,
so that when you call open() or write() or ioctl() on a device, it
checks the device path for string equality with "/dev/dsp" or similar
and reacts accordingly (e.g. by translating your written data buffer
into an alsa-lib call).

Downside 1 is that binaries that don't allow themselves to be
LD_PRELOADed (I think that applies to binaries that are setuid root)
can't use aoss at all. Downside 2 is that it's an ugly hack, and it
doesn't work with a lot of programs, even those that allow LD_PRELOAD.

That is to say, for any given OSS program, the probability of it
working with aoss is somewhere around 35% (based on my having
previously tested this in ~2008-9 with about a dozen OSS apps, each
from distinct proprietary and free software development teams). The
probability of it working *properly*, with low latency and playing
nicely with your alsa-lib plug layer (dmix, resampling, etc) is
somewhere lower around 20%.

If you have the source and ability to change the OSS program(s) you
need to run, and have direct control over their release cycle, you may
be able to code them up so that they work properly with aoss... but
it's a pretty restrictive environment to be doing sound I/O. If I
heard of a production device on the market that was shipped to rely on
aoss (or the in-kernel OSS emulation, for that matter), my face would
be stuck to my palm for several weeks. ;-)

I don't think anything out there is quite like osspd, both in terms of
robustness and compatibility with existing OSS applications. If you
can handle the added overhead of user -> kernel -> user, you should
definitely use it.

Here's the path laid out for you in full, so you can decide for
yourself. Here I'm going to walk you through the layers that the audio
will be passed through for a simple case of playback only (no capture)
for osspd.

1. An OSS application uses the OSS "API" to syscall open("/dev/dsp",
...) which is a real character device, owned by the CUSE kernel module
(more info: http://lwn.net/Articles/308445/ )

2. The open() call goes through the native libc library (no userspace
hacks like aoss, so it works with setuid binaries), which ultimately
results in a syscall, and a context switch to the kernel.

3. The kernel routes the call to CUSE, which owns the character
device, and receives the notification that someone in userspace is
trying to open() its device.

4. CUSE reacts to the open() call mostly as you'd expect: it sets up
some state, allocates some memory, and reaches out to userspace to
tickle the *userspace* osspd daemon (running as a child of pid 1,
usually) to let it know that it has a client.

5. The userspace daemon establishes a connection with its "backend",
whatever that might be. Right now osspd has two supported backends:
alsa-lib (regular old userspace ALSA, which goes through the plug
layer via libasound2), and the native pulseaudio protocol via
libpulse. The backend itself is a separate process in userspace.

6. The backend itself does whatever's necessary to get at the
hardware. Understanding the functionality of alsa-lib or pulseaudio is
a separate discussion, but once the backend is created, it is just an
ordinary alsa-lib or pulseaudio client.

7. This whole process repeats itself when you call write() or ioctl()
on the /dev/dsp device, but depending on what exactly you're doing
(compliant with the OSS API, of course!), your call follows this path
again, doing the right thing at each layer. So a write() call would
pass a data buffer to the kernel through a syscall, then back to
userspace to osspd, then from osspd to its backend, then from the
backend it'd go back into the kernel eventually for playback against
your driver.

You may be thinking that this is an ugly process, but it's not much of
a CPU hog even on a dual core laptop with 2006 specs. I can imagine
that it would have a larger footprint relative to certain small
embedded devices though. The best way to know for sure is to test it
out :)

>
>
> Otherwise, thanks for all your comments. =A0Very helpful. =A0A next task
> on my list was tackling mixing, and it sounds like removing OSS
> Emulation and moving to one of the above is a better solution.
>
> Thanks!
> Mike
>
