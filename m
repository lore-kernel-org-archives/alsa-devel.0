From: Ian Forde <ian@duckland.org>
Subject: Broken nforce3 support in ALSA on amd64?
Date: Sat, 26 Feb 2005 17:47:10 -0800
Message-ID: <1109468831.11523.21.camel@colgate3.iforde.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

Hi -

I've posted to alsa-devel about a problem I'm having in getting PCM and
AC3 working on FC3-x86_64.

My motherboard is a DFI Lanparty UT 250GB nforce3.  I can get PCM audio
to route through the spdif correctly with ALSA.  But with AC3
audio, the blue light on my Sony receiver lights up but plays no sound.

lspci -v output from the chip:

00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb
AC'97 Audio Controller (rev a1)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 177
        I/O ports at d300 [size=256]
        I/O ports at d400 [size=128]
        Memory at e9000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

Here's the weird bit:  Following these steps in order allows me to play
AC3 through the SPDIF but no longer PCM audio:

1. Load ALSA modules
2. Play (successfully) PCM audio via:
        /usr/bin/mplayer -vo null -ao alsa:device=hw=0.2
somemoviefile.avi
3. Unload ALSA modules
4. Load nvsound module
5. Play (successfully) AC3-enabled audio via:
        /usr/bin/mplayer -vo null -ao oss -ac hwac3, someothermovie.vob
6. Unload nvsound module
7. Load ALSA modules
8. Play (successfully) AC3-enabled audio via:
        /usr/bin/mplayer -vo null -ao alsa:device=hw=0.2 -ac hwac3,
someothermovie.vob

And no - at this point, redoing step 2 at this point does *NOT* work.
Unless I unload alsa, load oss, play something PCM, unload oss, and load
alsa again... just tested that.

Kernel is FC3 2.6.10-1.760_FC3 with ALSA 1.0.8 from atrpms on a x86_64
platform.

Note - in alsamixer, the only IEC958-related controls I see are "IEC958"
and "IEC958 Playback AC97-SP5A", neither of which allow themselves to be
muted...

It seems that because there's already a binary driver out there that can
set the control bits correctly, all I should need to do is dump the
registers after loading nvsound and playing both PCM and AC3 audio
streams, then comparing them to what they look like when the
corresponding ALSA module (snd-intel8x0) is loaded.  How would I go
about doing that in a way that would be useful to get this driver
working for me and included in the next ALSA release?

	-Ian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
