From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: using the sequencer with raw byte streams?
Date: Mon, 21 Jul 2003 13:18:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19eeDR-0007hP-00@sc8-sf-list1.sourceforge.net>
References: <s5hvftwhrck.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 21 Jul 2003 16:44:27 +0200."
             <s5hvftwhrck.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> own sophisticated parser that includes heavy use of libsigc++ to allow
>> anonymous notification of many more event types than the sequencer
>> code currently defines. 
> 
>"arbitrary" includes non-MIDI byte streams?

no, MIDI definitely, but its dominated by sysex stuff (MTC, MMC, dump,
load requests, etc) that the sequencer knows nothing about.

>> i'd like to find a way to connect these two abstractions together
>> somehow, since it would make Ardour play "nice" in the set of
>> sequencer clients that already exist. i can see the "RAW" event type
>> flag, which looks as if it might work for delivery data to the
>> sequencer, but i can't see any mechanism for retrieving unparsed data
>> from the system. can it be done?
>
>to send/receive raw (non-MIDI) byte streams, you can use app-dependent
>type (SND_SEQ_EVENT_USRx or SND_SEQ_EVENT_USR_VARx).
>in this case, both the receiver and the sender clients must know the
>type.  the default event encoder/decoder wouldn't handle such events
>(ignored).

no, i want to send real MIDI but I don't want to force the client of
libmidi++ to use structured events when it already has reasonably
optimized methods for its MIDI output. actually, output is not the
hard part (i could hack in some code to deal with this, even though it
would a bit ugly), its input that is problematic. i need to run the
libmidi++ parser over the raw MIDI data that is received by the Port
abstraction. as far as i can tell, the sequencer doesn't make this
available, only the structured event. for sysex, thats relatively easy
to hack around, but in general, its a problem. having the parser
handle the sysex data but using the sequencer's pre-parsed events for
non-sysex will break MIDI parsing in some cases.

basically, as i've said so many times before, i'd really like the
sequencer to be useful for routing (which implies queuing in some
cases), but to be able to turn off the parser or at least bypass it,
and receive raw MIDI streams on a sequencer port.

--p



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
