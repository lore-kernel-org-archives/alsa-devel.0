From: Michal Seta <mis@creazone.com>
Subject: Re: MIDI+USB - back on track
Date: Mon, 5 Aug 2002 09:22:58 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020805092258.41ae0bfd.mis@creazone.com>
References: <Pine.LNX.4.33.0208042048550.951-100000@pnote.perex-int.cz>
	<3D4E3AB0.563AB976@ladisch.de>
	<s5hn0s1ehzp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0s1ehzp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

So, my MIDI-in is working now.
I don't know why, I don't know why it didn't work before and I'm not sure it will work the next time I need to reboot or reconnect my MIDI interface.

Thanks everyone for suggestions but here's what was happening:

My MIDI cables were OK.
I don't use any other usb-audio devices.
When I was sending MIDI from the synth to the computer the light on the interface was blinking so I assume it was getting into the interface but for some reason not into the computer.  

I was away for the weekend so I turned off the computer.  This morning, when I booted up, loaded the firmaware, loaded the snd-usb-midi stuff it still didn't work. Then, I noticed, my synth (Roland GR-50) was displaying an error message (MIDI buffer overflow) but I haven't seen any lights on the interface.  I disconnected the MIDI cables, turned the synth off, reconnected MIDI cables, turned the unit on and voilà.  Everything works.  Now, I'm not sure if I really want to try to reproduce it.  But I think it's unrelated to the drivers (unless some initialization causes some kind of MIDI jam).

rawmidi works as expected
dd bs=1 </dev/snd/midiCxDx works, too.
cat does not (as reported earlier)

thanks.
-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
