From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sun, 12 Jan 2003 10:57:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301121051560.611-100000@pnote.perex-int.cz>
References: <20030111203709.20df5ff0.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030111203709.20df5ff0.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Jan 2003, Ryan Pavlik wrote:

> On Sat, 11 Jan 2003 20:50:49 -0500
> Paul Davis <paul@linuxaudiosystems.com> wrote:
> > 
> > i would have thought that the mtpav driver should do the same
> > thing. if you want to access all 8 ports, you should have 8 access
> > points (whether this is via the sequencer or the rawmidi interface),
> > and write to each one of them. the use of the "Dn" byte(s?) to switch
> > output ports shouldn't be exported to user space. 
> 
> It does, and you do... except the driver has the problems with parallel
> access of ports I mentioned in the original message.  When you access
> them with the sequencer API, the driver/library doesn't seem to properly
> send entire messages.  Thus the problem arises.

If the device needs full midi messages a stream parser must be implemented 
in the mtpav driver. There is no guarantee, that the MIDI message is 
complete in the rawmidi implementation. It behaves like a char stream 
device (something like tty).

Example:

port #2 received three bytes from an application: 0x80 0x10 0x15
port #3 received three bytes from an application: 0x90 0x20 0x00

So the mtpav driver might send this sequence in this order:

0xf5 0x02 0x80 0xf5 0x03 0x90 0xf5 0x02 0x10 0x15 0xf5 0x03 0x20 0x00

Where 0xf5 0xXX are port addresses. There is guarantee (using spinlocks) 
that the port will receive the right values but not whole midi message at 
once.

I think that the problem might be in another code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
