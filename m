From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 15:46:15 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301111543330.613-100000@pnote.perex-int.cz>
References: <20030110113711.06e8ee2d.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030110113711.06e8ee2d.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Jan 2003, Ryan Pavlik wrote:

> Basically, the problem is this.  The MTP/AV protocol takes messages
> like this:
> 
>    Dn B1 ... Bn
> 
> Where Dn is the device number, and B1..Bn are the midi message bytes.
> This, at least, is what I gather from talking to Michael Mayers, the
> original driver developer.
> 
> You may see the problem now.  When multiple threads talk to the device
> at once, you have a problem:
> 
> A:  Dn B1 ,, ,, B2 ...
> B:        Dn B1 ,, ...
> 
> The userland solution, when writing raw midi, is to just put a mutex
> on the device and never write an incomplete message.

ALSA driver should handle this correctly (at least current CVS code).
The write sequence is locked.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
