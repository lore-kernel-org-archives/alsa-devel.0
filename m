From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH] Add async support to ioplug
Date: Thu, 22 May 2008 00:16:43 +0200
Message-ID: <20080521221642.GA12214@tango.0pointer.de>
References: <s5hej7x9qok.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D09D245C0
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 00:16:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hej7x9qok.wl%tiwai@suse.de>
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

On Tue, 20.05.08 13:10, Takashi Iwai (tiwai@suse.de) wrote:

> Hi,
> 
> the patch below adds a framework to support async on ioplug.  Now
> an external ioplug plugin can implement appropriate async methods if
> possible.
> 
> The async callback is just a copy of snd_pcm_async().  When sig >= 0,
> activate the async, and with a negative value, deactivate async.
> 
> The test patch to alsa-plugins will follow.

Humm, I am not really happy about this. 

Firstly I thing that async is a really bad thing anyway. Signal handler
segmantics are very different from normal process semantics, i.e. a
lot of API functions are not reentrant and not signal handler
safe. Also, a lot of people implementing signal handlers don't
save/restore errno the way the should (libasound being one example
btw, as I just checked, this needs fixing). It's a fact: implementing
signal handlers is difficult, and people almost never get it right. I
mean, because it is so difficult there's even a valgrind module that
helps identifying problems with signal handlers!  

Also, signals are a shared resource where no reservation scheme
exists. If one library in a process takes posession of a signal then
it might overwrite the previous signal handler, there is no sane way
to detect that. Flash 9 for example registers an alsa async handler,
which causes SIGIO to be overwritten. It's sheer luck that noone else
in the Firefox process wants to use SIGIO, because that would clash
with Flash -- and this would not even be detected! And SIGIO is used
for a lot of stuff, among them the whole aio subsystem, dnotify alsa
and a few others. To emphasize this: if you use alsa async, you cannot
use aio or dnotify in the same process!

Signal delivery for usage in event loops on Linux is slow. Much slower
than poll() based event loop approaches (somewhere on the web is a detailed
comparison of poll() loops vs. RT sig based event loops in regards to
throughput, I can dig that up if someone wants to see that.)

In summary: async doesn't give any benefits. However, it creates quite
a few problems:

In the case of flash it just signals a semaphore from the async
handler which is slept on by the sound loop thread. This is really not
a clean design, anyway. They should directly sleep on the audio
fds. With Flash 10 they responded to criticism of mine. It doesn't use
async anymore and is those compatible with PA and other ioplug
modules.

What I want to say is: using signals is bad style. Don't use
signals. I do believe the best would be to remove async support from
ALSA entirely. Grepping through google code search I couldn't find a
single program using alsa async where using it was actually a good
idea. Adding even further async support to ALSA does not strike me as
a good idea. I believe the plan must be to remove async, not extend
its support. And such a plan I think would be perfectly in line with
what happens on the kernel front anyway. We now have stuff like
signalfd(), explicitly because signal handlers are so ugly. For aio
people are looking for alternatives without sig handlers, too. And
yes, one of the reasons dnotify got replaced by inotify is that it
used SIGIO.

What however strikes me particularly questionnable about this patch is
that this way ioplug async handlers are not called from signal handler
context, instead they are called directly from process context. This
is really problematic. Firstly, if people start to use async on ioplug
a lot they will very likely produce code that only runs fine from
normal process context and will break horribly from signal handler
process (e.g. use synchronization based on mutexes). More importantly
however, if a program uses signal masks to make sure that the async
handler is run from a very specific thread or temporarily disabled for
criticial sections this will be breaking for ioplug drivers. 

If you really think that extending async to iolpug is a good idea then
this should probably done by using sigqueue() to manually enqueue
SIGIO and thus make sure the async events pass the usual signal
delivery logic.

When I analyzed the Flash+PA incompatibility I though about extending
ioplug for async myself. But in the end I thought that enqueing SIGIOs
from userspace was so ugly it would never have a chance to go upstream.

Again, please let's drop async altogether. It's error-prone, easy
to misuse, and especially Flash 9 (which I assume is the reason you
came up with the patch) is a prominent misuser of it, so with Flash as
only reason to do this I think the whole idea is void.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
