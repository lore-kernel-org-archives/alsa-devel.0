From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP 9652 MIDI - A timing disaster?
Date: Mon, 13 Jan 2003 08:15:58 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301131315.h0DDFrAk023523@spider.tela.com>
References: <Pine.HPX.4.33n.0301130954070.4019-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 13 Jan 2003 10:04:23 +0100."
             <Pine.HPX.4.33n.0301130954070.4019-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Mark Knecht <markknecht@attbi.com>, Alsa-List <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Mark Knecht wrote:
>>    I recently purchased an RME HDSP 9652 card. The card is working fine
>> for audio, but the MIDI interface is a timing disaster. The interface
>> works, but won't keep time. A 2 minute song is Rosegarden takes abut
>> 2:45 to play every time. You can hear how the HDSP isn't delivering
>> closely spaced MIDI events together, but is sort of smearing them out.
>
>The hdsp driver doesn't send more than one MIDI byte per timer tick.
>IMHO it should be modified to send in a loop until the FIFO is full

that's what this tried to do:

	if (hmidi->output) {
		if (!snd_rawmidi_transmit_empty (hmidi->output)) {
			if ((n_pending = snd_hdsp_midi_output_possible (hmidi->hdsp, hmidi->id)) > 0) {
				if (n_pending > sizeof (buf))
					n_pending = sizeof (buf);
				
				if ((to_write = snd_rawmidi_transmit (hmidi->output, buf, n_pending)) > 0) {
					for (i = 0; i < to_write; ++i) 
						snd_hdsp_midi_write_byte (hmidi->hdsp, hmidi->id, buf[i]);
				} else {
					clear_timer = 1;
				}
			}
		} else {
			clear_timer = 1;
		}

how does this end up writing only a single byte? unless n_pending is
always either 0 or 1, which on closer inspection, i see that it is
... yikes. 

>(however, I don't know if the HDSP has a FIFO at all). And it should start

it does have a FIFO.

>sending in output_trigger() instead of delaying it to the next timer tick.

hmm. i modelled this code on another PCI driver that had MIDI
support. is there an example you can point me to that starts from
within the equivalent output_trigger?

--p


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
