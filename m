From: Pavel Vondricka <wanthalf@centrum.cz>
Subject: Re: Novation X-Station: mostly success, but...
Date: Fri, 18 Mar 2005 00:43:30 +0100
Message-ID: <200503180043.30727.wanthalf@centrum.cz>
References: <Pine.HPX.4.33n.0503171359590.7260-100000@studcom.urz.uni-halle.de>
Reply-To: wanthalf@centrum.cz
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0503171359590.7260-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Additional information about the functionality of the whole device:

- now I managed to record/capture from the device at least on the command line 
in this way only: arecord -D hw:1,0 -r 44100 -f S24_3LE -c 2 text.wav (the 
plug device does not work when recording - is autoconversion not possible?)

- the mixer (none of the controllers) has absolutely no effect - either on the 
playback or when recording

- there are light random clicks (at least 1-3 per minute) in the playback, 
even when I do not touch the computer. there are no clicks when playing the 
same sound through the integrated VIA82C682 sound device. I have not tried 
long recording to test possible clicks when recording.

I have also tried the device under Windows2000 (warning: according to the 
manual the only supported version is WinXP - for me: audio works, MIDI 
template editor has problems, and I haven't tested more of MIDI...). 
Results:

- there are no clicks in the playback (as far as I have heard)

- recording is possible
1) either from the synthesizer only (in stereo on both channels),
2) or from the mic/line-input1 (mono) on left channel and synthesizer (mono!) 
on the right channel, 
3) or (probably) from both two mono mic/line-inputs on both channels (but 
without the synth: the keyboard must not be in KS-synth mode, or the second 
input is not available, but it's channel is occupied by the synth!)

- the Windows mixer shows two controls for playback:
1) "Master Volume" - works as expected (even balance)
2) "SW Synth" - I don't know what it should do, but it did nothing for me, 
even not to the playing synth mixed with the playback

- the Win mixer shows two controls for recording:
1) "Capture" - doesn't change volume except when pulled completely down to 
zero (then it mutes the capture completely)
2) "Line In" - stays always in the middle position and cannot be moved by the 
mouse up or down! the mute checkbox can be checked, however, it is completely 
connected to the first control's ("Capture") MUTE checkbox (both get changed 
when one of them selected)

Regards,
Pavel


-- 
###########################################################################
# mailto:wanthalf@centrum.cz 
# ICQ:143159880 
# Jabber:wanthalf@jabber.cz
###########################################################################


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
