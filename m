From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Tue, 08 Oct 2002 08:06:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA27602.969C3174@libero.it>
References: <3D98769A00183382@ims5a.libero.it> (added by postmaster@libero.it)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Anders Torger <torger@ludd.luth.se>, alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >I'm not speaking about programming bugs. Suppose the PCM is stopped by
> >another thread: you're screwed.
> 
> why are you screwed? you're waiting (presumably) for data/space to be
> ready in the PCM device. there isn't any (or more precisely, you're
> waiting for changes in the state of data/space, and there are none). i
> don't see the problem.

The thread has no way to detect what's the cause of data/space lack
without busy loop or delaying.

> >> > As pointed by Clemens the current is the proper POSIX behaviour.
> >>
> >
> >Perhaps you should reread Single Unix Specification, I quote
> >http://www.opengroup.org/onlinepubs/007904975/functions/poll.html
> >
> >POLLIN
> >            Data other than high-priority data may be read without
> >blocking.
> >
> >
> >POLLOUT
> >            Normal data may be written without blocking.
> >
> >
> >No data may be read/written in current stream state in the case we are
> >discussing.
> 
> but nobody has suggested that poll(2) should return any flags with
> these bits set. the issue, i thought, was what should write(2) do ...

No, the issue was about poll and write.
The point is that stream is in bad state wrt read/write, this is the
reason why poll should return POLLERR.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
