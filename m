From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 17:48:38 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.56.0308271730380.398158@kosh.hut.fi>
References: <200308271407.h7RE7PVN015845@oud>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308271407.h7RE7PVN015845@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> >> I'm planning to use arecord for serious harddisk recording, but it can't
>
> that's a non-starter :) at the very least, you'd better make sure you
> always use a period size larger than the maximum scheduling delay you
> think you might encounter, since arecord writes to disk from the same
> thread as one audio I/O is done from.

Yes it doesn't sound sexy at all. But I tested arecord to perform nicely
with 96khz 24channels 32bit data, on a ext2 filesystem (I found ext2 to be
the best filesystem for this kind of writing). As I'm going to record max
12 channels, this seemed like a reasonable solution.

After all, I didn't know ecasound can handle 96khz and I didn't have very
promising results with ardour&jack, but the bottleneck was almost
certainly my full ide-hd at the end of the disk (physically also at the
end) and reiserFS, which causes overhaul to the process due journaling (I
think, not 100% sure about this).

> ecasound would be a much better idea, much, much better.

I think I'll give ardour an another try and fall back to ecasound, which
seems to be the right tool for now.


Tommi Uimonen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
