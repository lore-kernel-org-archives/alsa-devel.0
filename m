From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Which API for MIDI?
Date: Thu, 11 Dec 2003 12:14:42 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0312111119080.1515-100000@studcom.urz.uni-halle.de>
References: <200312101450.hBAEoXeN019193@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200312101450.hBAEoXeN019193@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> >Sending/receiving sysex has always been possible AFAIK.  It's
> >certainly possible now.
>
> its bounded by size limits that have to (re)set in advance. when i
> tried to download new firmware (1MB+) via SYSEX to an Alesis ADAT, it
> was very difficult to discover this limitation.

Yes; it's a problem that ALSA wants to handle each sysex as one large
chunk.

This problem occurs in another situation, too: in Standard MIDI files,
a sysex command can be split into multiple parts to be sent at
specific times, but it's impossible to do this with the ALSA
sequencer.  (Well, it's possible, but the documentation says that each
SYSEX event must contain a complete sysex command.)

I think the sequencer should be changed to allow splitting of sysex
commands.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
