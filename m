From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [linux-audio-user] Re: Please explain Alsa Interface MIDI numbering PLEASE!
Date: Mon, 17 Feb 2003 13:07:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18kpeu-0008Rr-00@sc8-sf-list1.sourceforge.net>
References: <1045499343.1266.37.camel@Godzilla>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "17 Feb 2003 08:29:02 PST."
             <1045499343.1266.37.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Linux-Audio-User <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>[mark@Godzilla mark]$ aconnect -io
>client 0: 'System' [type=kernel]
>    0 'Timer           '
>    1 'Announce        '
>client 64: 'External MIDI 0' [type=kernel]
>    0 'MIDI 0-0        '
>   32 'MIDI 0-1        '
>client 72: 'External MIDI 1' [type=kernel]
>    0 'Midisport 2x2 Port 0'
>    1 'Midisport 2x2 Port 1'
>    2 'Midisport 2x2 Port 2'
>    3 'Midisport 2x2 Port 3'
>[mark@Godzilla mark]$
>
>
>   The above information is certainly a bit more readable, but it seems
>to still be, at the least, inconsistent.
>
>1) For client 64, which is an HDSP 9652, there are two rawmidi ports.
>However, the info above says they are labeled '0' and '32'. Should they
>not be 0 & 1? If this is an error, then what needs to be fixed? The HDSP
>9652 driver?

no, the port numbers are 0 and 32, but in the name, its 0 and 1.

>2) Why does the HDSP 9652 not tell me its name like the MidiSport does?

its using a copy of some generic ALSA code that just calls the ports
"MIDI C P" where C=card number and P=physical port number. i'll change
this when i add the fixes for the mixer and the h/w names.

--p




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
