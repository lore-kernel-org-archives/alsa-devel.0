From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [linux-audio-dev] Quick question regarding raw midi access via
 alsa sequencer
Date: Fri, 18 Mar 2005 10:50:32 -0500
Message-ID: <200503181550.j2IFoWvj011640@localhost.localdomain>
References: <20050318153559.WEAT9404.gx6.fuse.net@64BitBadass>
In-reply-to: Your message of "Fri, 18 Mar 2005 10:40:17 EST."
 <20050318153559.WEAT9404.gx6.fuse.net@64BitBadass>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I did a bit of hacking on my app trying to make it alsa sequencer compatible
>but did not want to do too much changing in terms of how it deals with raw
>MIDI data. From looking at the API reference it seems that I have 2 choices:

libmidi++ in the ardour source tree has what you need. at least as a
model. ardour writes raw MIDI, never uses the sequencer API. libmidi++
provides "port" objects which support that, regardless of whether they
correspond to a raw MIDI port, a FIFO (literally), CoreMIDI or ALSA sequencer.

see alsasequencer_midiport.cc for details.

--p


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
