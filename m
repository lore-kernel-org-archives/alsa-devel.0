From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 08:55:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301111355.h0BDtUX8028055@spider.tela.com>
References: <20030110113711.06e8ee2d.rpav@nwlink.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 10 Jan 2003 11:37:11 PST."
             <20030110113711.06e8ee2d.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>That is, of course, not an acceptable solution, and it also doesn't
>work when you're using the ALSA sequencer interface (at least from the
>API calls I've seen).  Fixing it in the driver requires interpreting
>much MIDI, possibly buffering, and has some problems (what if someone
>writes an incomplete message and dies?).

its not a solution to the problem, but i think its important to note
the behaviour of write(2) for FIFOs. if the byte count argument is
below the size of the pipe, the write(2) is atomic - that is, either
the entire write completes and the data is delivered to the pipe as a
continuous byte stream, or it does not and none of it is delivered.

i would hope that ALSA implemented similar semantics for MIDI
devices. the question would still remain: what is the equivalent to
the "size of the FIFO" (which is 5kB by the way).

if ALSA does supply these semantics, then you just need to make sure
that the messages are below the size limit and that they are delivered
in a single call.

i know this doesn't work for super-large sysex messages.

however, back to the core question:

>The userland solution, when writing raw midi, is to just put a mutex
>on the device and never write an incomplete message.
>
>That is, of course, not an acceptable solution, and it also doesn't

i'm afraid its an entirely acceptable solution, and its the same one
required by many other non-audio, non-MIDI device types. if you have
multiple threads writing to a disk-file, for example, and they
interleave their calls to write(2), you will get mixed up data on
disk.

>work when you're using the ALSA sequencer interface (at least from the
>API calls I've seen). 

why not?

--p




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
