From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 10:30:10 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111103010.2d9588cd.rpav@nwlink.com>
References: <20030110113711.06e8ee2d.rpav@nwlink.com>
	<200301111355.h0BDtUX8028055@spider.tela.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301111355.h0BDtUX8028055@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(I'm checking out CVS again after Jaroslav Kysela's note, but I thought
I'd reply to this and clear up my statements.)

On Sat, 11 Jan 2003 08:55:10 -0500
Paul Davis <paul@linuxaudiosystems.com> wrote:

> its not a solution to the problem, but i think its important to note
> the behaviour of write(2) for FIFOs. <snip>

True, except the MTPAV driver writes byte-by-byte. ;)

<snip> 
>
> >The userland solution, when writing raw midi, is to just put a mutex
> >on the device and never write an incomplete message.
> >
> >That is, of course, not an acceptable solution, and it also doesn't
> 
> i'm afraid its an entirely acceptable solution, and its the same one
> required by many other non-audio, non-MIDI device types. if you have
> multiple threads writing to a disk-file, for example, and they
> interleave their calls to write(2), you will get mixed up data on
> disk.

Actually, I mean it's not an acceptable solution because (at least till
recent CVS I suppose) it's been the _only_ solution: things which (have)
used the sequencer interface to talk to the MTPAV on multiple outputs
simply didn't work.  It can't be expected that everyone specially code
mtpav code, or that defeats the point of having ALSA.

But, of course, if you're writing to rawmidi, you'll probably have to
deal with this.

> >work when you're using the ALSA sequencer interface (at least from
> >the API calls I've seen). 
> 
> why not?

I have seen no ALSA API calls for "binding" devices together.  You queue
up messages and they get sent... but putting a mutex around queue calls
doesn't do anything for you.  (At least, I'm looking at this from what
the code said, and I very well could have been missing something.)

Anywayt, all of this should be moot if it's fixed now... off to compile.
;)

-- 
Ryan Pavlik <rpav@users.sf.net>

"DEPLOY THE ROCKET BOAT!"


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
