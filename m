From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 19:33:11 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308271903020.9988-100000@ecabase.localdomain>
References: <Pine.OSF.4.56.0308271730380.398158@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.56.0308271730380.398158@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Aug 2003, Tommi Sakari Uimonen wrote:

> Yes it doesn't sound sexy at all. But I tested arecord to perform nicely
> with 96khz 24channels 32bit data, on a ext2 filesystem (I found ext2 to be
> the best filesystem for this kind of writing). As I'm going to record max
> 12 channels, this seemed like a reasonable solution.

Try issuing "find /" and/or "dd if=/dev/zero of=/tmp/bigfile 
bs=4096 count=10000" in another console while running arecord.

Normally you don't run these kinds of processes while recording, but
similar disk i/o blocking can happen even on a relatively unloaded 
system  (cronjobs, worst-cases in disk i/o job scheduling, swapping,
etc, etc).

And this is just disk i/o scheduling. Spikes in task scheduling latency
form another set of problems. On my laptop, running a 2.4.19 - low-latency
patched - kernel I can cause upto 5 second (!) scheduling delays to normal
user processes using 'find' and 'dd'. Ecasound can fight against this by
setting its scheduling priority to realtime (the SCHED_FIFO mode); this
requires that you run it as root. The same technique is used by many other 
apps, including JACK.

Linux kernel does perform quite nicely most of the time (kernel developers
seem to like their XMMS ;)), but with recording you also need to worry
about the 0.1XX% of cases where things go wrong.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
