From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: USB fix (debian bug#100041)
Date: Tue, 11 Mar 2003 21:05:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303112105.02149.plcl@telefonica.net>
References: <E18sngu-0000w3-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18sngu-0000w3-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jordi Mallach <jordi@debian.org>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 11 March 2003 18:36, Clemens Ladisch wrote:
> Jordi Mallach wrote:
> > any comment on the last "stacatto" bug I reported after the big
> > report?
>
> I couldn't reproduce it on my machine (current CVS instead of 0.9.0beta8,
> 2.4.18 instead of 2.4.2, Roland Sound Canvas connected with USB instead of
> SB MIDI port).
>
> I have noticed that calling SNDCTL_SEQ_RESET (as well as close()ing the
> handle to /dev/music) sends "all notes off", "controller reset" and
> pitch-bend messages to all channels on all ports, but that should result
> in a delay of at most 40ms before the first note, and not in a timing
> problem at a later note.

After that messages, there is a 0xfe (Active Sensing) message (the rawmidi 
close() default policy). Running the test program with a Roland SC-88 
(connected with a MIDI cable to some  interface drived by ALSA) it shows this 
effect (first long note is clearly shortened). After the program reachs a 
delay of about 300ms the problem is solved, so i think that the Active 
Sensing can be guilty here. 

There is a description of ActiveSensing messages here:
http://www.midi.org/about-midi/table1.shtml
			Active Sensing.
                              Use of this message is optional.  When
                              initially sent, the receiver will expect
                              to receive another Active Sensing message
                              each 300ms (max), or it will be assume
                              that the connection has been terminated.
                              At termination, the receiver will turn off
                              all voices and return to normal (non-
                              active sensing) operation.

I have to say that with my other external synth (an old Roland JV-80) the test 
program runs fine (every note with the right length), but shows a "Midi 
Communication Error" in it's LCD display. The SC-88 shows another error 
message saying "Midi Off Line" every time a program close()s a rawmidi or OSS 
device.

I know that using ALSA rawmidi API, there is a function to prevent this, doing 
something like this:

		snd_rawmidi_t *handle_out;
		snd_rawmidi_params_t *params;
		[...]
		snd_rawmidi_params_malloc(&params);
		snd_rawmidi_params_current(handle_out, params);
		snd_rawmidi_params_set_no_active_sensing(handle_out, params, 1);
		snd_rawmidi_params(handle_out, params);
		snd_rawmidi_params_free(params);

But, how to do something like that for OSS programs? (without fixing the OSS  
program itself, of course)

Another way that i have tried to workaround the problem is redirect some 
source of Active Sensing events (using ALSA's aconnect, for instance) to the 
same output port (72:0) of the test program. This works, but is not a 
definitive solution at all.

BTW: my ALSA client 72 is a Midisport2x2. I can use it with a GPL firmware and 
also with the Midiman's propietary firmware, as you know.  Modifying the GPL 
firmware, i can block all the ActiveSensing events if i want. Isn't free 
software great? :-) 

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
