From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rawmidi mystery
Date: Fri, 7 Feb 2003 09:49:32 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302070947220.1141-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0302070924260.24516-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0302070924260.24516-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Frank Neumann <beachnase@web.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Feb 2003, Clemens Ladisch wrote:

> Frank Neumann wrote:
> > PS: I checked with gettimeofday(): The snd_rawmidi_drain() takes about
> > 47-49ms on my system..quite long, huh? I mean, the command sequence is
> > just 7 bytes, that's about 2.24ms of "raw" MIDI transfer time..
> 
> There are two possibilities how the _drain() can be implemented:
> 1) The driver knows when the FIFO is empty, and waits until then, or
> 2) Nothing is known, so ALSA simply waits for 50 ms.
> 
> Currently, there isn't any driver which implements 1).  :-(

Yes, you got it. I forgot this algorithm. Unfortunately, the most of cards 
don't allow us to read the FIFO size / state, so it's a bit problematic to
determine the real time when all data are flushed to device.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
