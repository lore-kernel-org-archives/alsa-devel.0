From: Frank Neumann <beachnase@web.de>
Subject: Re: Rawmidi mystery
Date: Thu, 6 Feb 2003 23:00:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18gu3K-0000Hj-00@smtp.web.de>
References: <E18gVVU-0007zl-00@smtp.web.de>
	<Pine.HPX.4.33n.0302061000020.17923-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0302061000020.17923-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi again list,
Clemens Ladisch <clemens@ladisch.de> wrote:

[..]
> > No, I checked that. The M3r sends active sensing (0xfe), but I filtered that out.
> > In the data I get the only MIDI bytes > 0x7f are the F0 at the start and the
> > 0xF7 at the very end. Also, I think a SysEx message cannot be interrupted by
> > any other message, right?
> 
> Realtime messages can interrupt any other message, but it's unlikely that
> your device would send one.

Oh..yes, you're right. I just looked it up in the MIDI spec. Wow. I wonder
how many MIDI parsers are out there that do not handle this correctly :-).

> > I checked that - no overruns during the whole transfer.
> 
> Maybe some bytes have been ignored. Please try the following patch:

[patch removed]

No, that's not it. The resulting number of bytes was _smaller_ than expected,
so if there had been active sensing bytes, they would have enlarged the
file size. Also, I checked the stream and found no bytes > 0x7f between
F0 and F7.

> It may be possible that your program waits too long before starting to
> read data. (If some bytes come in before your first call to
> rawmidi_read(), they're simply ignored.)
> Please try removing the drain() in line 58.

And YES, that did the trick! Thanks a lot, Clemens. Looks like the drain()
takes a lot longer than I'd have expected (my thought was that it would
return right after the last "command" bytes have been sent out, and that
the incoming stream would be held by the buffer (4096 bytes, right) for
a little while, so I didn't expect any losses there.

I find this a little odd - especially since it was not the _beginning_ of
the stream that is missing, but a couple of bytes a little later. But, what
the heck - it works now, I learnt something - thanks! :-)

Greetings,
Frank

PS: I checked with gettimeofday(): The snd_rawmidi_drain() takes about 
47-49ms on my system..quite long, huh? I mean, the command sequence is
just 7 bytes, that's about 2.24ms of "raw" MIDI transfer time..


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
