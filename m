From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rawmidi mystery
Date: Fri, 7 Feb 2003 09:38:15 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302070937040.1141-100000@pnote.perex-int.cz>
References: <E18gu3K-0000Hj-00@smtp.web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18gu3K-0000Hj-00@smtp.web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Neumann <beachnase@web.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Feb 2003, Frank Neumann wrote:

> And YES, that did the trick! Thanks a lot, Clemens. Looks like the drain()
> takes a lot longer than I'd have expected (my thought was that it would
> return right after the last "command" bytes have been sent out, and that
> the incoming stream would be held by the buffer (4096 bytes, right) for
> a little while, so I didn't expect any losses there.
> 
> I find this a little odd - especially since it was not the _beginning_ of
> the stream that is missing, but a couple of bytes a little later. But, what
> the heck - it works now, I learnt something - thanks! :-)
> 
> Greetings,
> Frank
> 
> PS: I checked with gettimeofday(): The snd_rawmidi_drain() takes about 
> 47-49ms on my system..quite long, huh? I mean, the command sequence is
> just 7 bytes, that's about 2.24ms of "raw" MIDI transfer time..

It looks like a serious bug in the driver. Could you resend me privately 
your utility again? Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
