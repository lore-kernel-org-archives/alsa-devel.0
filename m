From: Paul Davis <pbd@Op.Net>
Subject: Re: Rawmidi bug or missed feature?
Date: Fri, 01 Mar 2002 15:30:06 -0500
Message-ID: <200203012030.PAA15212@renoir.op.net>
In-reply-to: Your message of "Fri, 01 Mar 2002 20:22:27 +0100."
             <3C7FD4F3.BFDA1791@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>This is the configuration:
>
>Roland MCR-8->midi-device->alsa-seq->user_code->alsa-seq->raw_midi

this is a crazy, wierd setup! but i'll try to just let that be. i
suspect you don't mean "raw MIDI" the way its meant in ALSA.

>So how far back should I need to reset? The communication roland and
>alsa-seq is in sync and my user-land code is sending
>snd_seq_event_t. 

you need to get this figured out. how is your user-land code sending
snd_seq_event_t if you're using the raw MIDI interface? i think you're
using the sequencer interface, and referring to "raw" MIDI just
because you're looking at MIDI messages.

		  I guess that my problem will disapear if I turn
>active-sening-on and that is what I going to try.

no, that will not get rid of it. 

all MIDI devices are allowed to use running status any time they want.
if something hooks into an ongoing MIDI data exchange, and it needs to
be able to understand what is going on, there is absolutely zero
choice: a MIDI reset is required so that the transmitter stops using
running status for at least one message and the data stream becomes
parseable. 

now, as to what should issue that reset - thats a different
question. one might suggest that the ALSA sequencer should do so as
soon as it connects to an inbound port. but how can it? its ports are
uni-directional - it has no way of knowing that it should issue a MIDI
reset on a different port so that the input data stream on *this* port
becomes parseable again.

thats why many good MIDI devices have a way to do a "MIDI reset" at
the user's request, precisely to deal with this kind of situation. its
certainly present on my Miditemp Matrix MIDI router. 

i don't understand what your application is doing, but if you plan on
connecting to an ongoing data stream, be prepared to reset.

>That will not help my reading. The device is in sync with alsaseq and
>there shuld not be needed to reset the transmitter. And even if I
>do. The merge of midi streams could be smart enough to see that it is
>of the same type.

I don't understand any of this. "sync" and "type" have nothing to do
with what is going on. You need to force the transmitting device to
stop using running status for at least one message so that correct
parsing can begin.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
