From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 18:31:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301112332.h0BNW6X8017892@spider.tela.com>
References: <20030111103010.2d9588cd.rpav@nwlink.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 11 Jan 2003 10:30:10 PST."
             <20030111103010.2d9588cd.rpav@nwlink.com>
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

>> i'm afraid its an entirely acceptable solution, and its the same one
>> required by many other non-audio, non-MIDI device types. if you have
>> multiple threads writing to a disk-file, for example, and they
>> interleave their calls to write(2), you will get mixed up data on
>> disk.
>
>Actually, I mean it's not an acceptable solution because (at least till
>recent CVS I suppose) it's been the _only_ solution: things which (have)
>used the sequencer interface to talk to the MTPAV on multiple outputs
>simply didn't work.  It can't be expected that everyone specially code
>mtpav code, or that defeats the point of having ALSA.

not really. the mtpav is a "non-standard" device that uses special
values in the datastream to switch its output port. the ALSA sequencer
can't know this, and so it can't have any idea that strange things are
happening at the hardware level.

another example of this that i know a bit more about is on the
tropez+. this has two MIDI output ports, and you can switch between
them with 2 "unused" MIDI bytes. what should ALSA do if you deliver
those bytes in a data stream? how can it know what they will do? why
should it pay any attention at all to them?

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
