From: Mark Knecht <markknecht@attbi.com>
Subject: Re: [linux-audio-user] Re: Please explain Alsa
	Interface MIDI numbering PLEASE!
Date: 17 Feb 2003 08:29:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045499343.1266.37.camel@Godzilla>
References: <Pine.HPX.4.33n.0302170958470.29300-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0302170958470.29300-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linux-Audio-User <linux-audio-user@music.columbia.edu>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens,
   Thanks. This is helpful, although questions remain. FYI - my machine
doesn't have pmidi, so I cannot run that now.

[mark@Godzilla mark]$ aconnect -io
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
client 64: 'External MIDI 0' [type=kernel]
    0 'MIDI 0-0        '
   32 'MIDI 0-1        '
client 72: 'External MIDI 1' [type=kernel]
    0 'Midisport 2x2 Port 0'
    1 'Midisport 2x2 Port 1'
    2 'Midisport 2x2 Port 2'
    3 'Midisport 2x2 Port 3'
[mark@Godzilla mark]$


   The above information is certainly a bit more readable, but it seems
to still be, at the least, inconsistent.

1) For client 64, which is an HDSP 9652, there are two rawmidi ports.
However, the info above says they are labeled '0' and '32'. Should they
not be 0 & 1? If this is an error, then what needs to be fixed? The HDSP
9652 driver?

2) Why does the HDSP 9652 not tell me its name like the MidiSport does?

   The MidiSport info above is with the Win2K firmware installed as per
your extraction program. It actually didn't change from the way Fernando
had me install it, so I suppose that his installation had the real
Midiman firmware and not the open source firmware. Apparently I'll
continue to get the wrong number of ports on that device until I can get
Alsa itself upgraded.

Thanks,
Mark


On Mon, 2003-02-17 at 01:21, Clemens Ladisch wrote:
> Mark Knecht wrote:
> > 1) In the screen shot "without_2x2.png" I see two read ports and two
> > write ports. Please explain why they are called
> >
> > 64:0 External MIDI 0
> > 64:32 External MIDI 0
> >
> > Why is my HDSP given the apparent name '64'?
> 
> This isn't the name, it's the sequencer client number. In theory, it
> should not be necessary to identify devices by this.
> 
> 0-63 are reserved for the ALSA core. 64-127 are used by sound cards, with
> each card getting 8 (64-71, 72-79, etc.). 128-255 are for use by
> applications.
> 
> > Why the :0 and :32? I would have thought :0 and :16 would make more
> > sense from a channel numbering point of view, or :0 and :1 from an
> > interface point of view. What's going on?
> 
> These ports are not native sequencer ports implemented directly by the
> driver but are emulated on top the rawmidi ports. There can be 256 ports
> per sequencer client, and 8 rawmidi devices per card, so each rawmidi
> device (which can have an unspecified number of subdevices=ports) is
> mapped to a group of 32 (256/8) sequencer ports.
> 
> If the two rawmidi ports would have been subdevices of one device, they
> would have been mapped to port numbers :0 and :1.
> 
> >    How can I change the names that are displayed so that
> > "64:0 External MIDI 0" shows the name "HDSP 9652 Port 1"
> > "64:32 External MIDI 0" shows the name "HDSP 9652 Port 2"
> > "72:0 External MIDI 1" shows the name "MidiSport 2x2 Port A"
> > "72:1 External MIDI 1" shows the name "MidiSport 2x2 Port B"
> 
> "External MIDI x" is the client name, which is the same for all ports of
> the same client. It seems that kaconnect doesn't show the port name, which
> would be what you want. Please complain to the author of kaconnect. :-)
> 
> To show the port names, run "aconnect -io" or "pmidi -l".
> 
> 
> HTH
> Clemens
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
