From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB fix (debian bug#100041)
Date: Wed, 12 Mar 2003 10:37:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303121027050.11828-100000@studcom.urz.uni-halle.de>
References: <200303112105.02149.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200303112105.02149.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Jordi Mallach <jordi@debian.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
> On Tuesday 11 March 2003 18:36, Clemens Ladisch wrote:
> > Jordi Mallach wrote:
> > > any comment on the last "stacatto" bug I reported after the big
> > > report?
> >
> > I couldn't reproduce it on my machine (current CVS instead of 0.9.0beta8,
> > 2.4.18 instead of 2.4.2, Roland Sound Canvas connected with USB instead of
> > SB MIDI port).
> >
> > I have noticed that calling SNDCTL_SEQ_RESET (as well as close()ing the
> > handle to /dev/music) sends "all notes off", "controller reset" and
> > pitch-bend messages to all channels on all ports, but that should result
> > in a delay of at most 40ms before the first note, and not in a timing
> > problem at a later note.
>
> After that messages, there is a 0xfe (Active Sensing) message (the rawmidi
> close() default policy). Running the test program with a Roland SC-88
> (connected with a MIDI cable to some  interface drived by ALSA) it shows this
> effect (first long note is clearly shortened). After the program reachs a
> delay of about 300ms the problem is solved, so i think that the Active
> Sensing can be guilty here.

Yes, that's it! My SC-8820 doesn't care for Active Sensing because the
connection status is handled by the USB protocol.

> I have to say that with my other external synth (an old Roland JV-80) the test
> program runs fine (every note with the right length), but shows a "Midi
> Communication Error" in it's LCD display. The SC-88 shows another error
> message saying "Midi Off Line" every time a program close()s a rawmidi or OSS
> device.

One could say "This behaviour is by design", but that's a Microsoft quote.
;-)

> I know that using ALSA rawmidi API, there is a function to prevent this, doing
> something like this:
> 		snd_rawmidi_params_set_no_active_sensing(handle_out, params, 1);
> But, how to do something like that for OSS programs? (without fixing the OSS
> program itself, of course)

Neither OSS nor ALSA sequencer ports can change parameters of the
underlying rawmidi port. Maybe there should be a module parameter for
this.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
