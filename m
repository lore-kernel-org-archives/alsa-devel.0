From: Lee Revell <rlrevell@joe-job.com>
Subject: some docs for the new emu10k1 multichannel functionality
Date: Wed, 30 Mar 2005 06:29:09 -0500
Message-ID: <1112182150.11752.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Not complete, or even spell checked, but in case I don't get a chance to
work on it again before 1.0.9, here is what i have so far.  It should go
in alsa-kernel/Documentation/emu10k1-jack.txt.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee

This document is a guide to using the emu10k1 based devices with JACK for low
latency, multichannel recording functionality.  All of my recent work to allow
Linux users to use the full capabilities of their hardware has been inspired 
by the kX Project.  Without their work I never would have discovered the true
power of this hardware.

	http://www.kxproject.com
						- Lee Revell, 2005.03.30

Low latency, multichannel audio with JACK and the emu10k1/emu10k2
-----------------------------------------------------------------

Until recently, emu10k1 users on Linux did not have access to the same low
latency, multichannel features offered by the "kX ASIO" feature of their
Windows driver.  As of ALSA 1.0.9 this is no more!

For those unfamiliar with kX ASIO, this consists of 16 capture and 16 playback
channels.  With a post 2.6.9 Linux kernel, latencies down to 64 (1.33 ms) or
even 32 (0.66ms) frames should work well.

The configuration is slightly more involved than on Windows, as you have to
select the correct device for JACK to use.  Actually, for qjackctl users it's
fairly self explanatory - select Duplex, then for capture and playback select
the multichannel devices, set the in and out channels to 16, and the sample
rate to 48000Hz.  The command line looks like this:

/usr/local/bin/jackd -R -dalsa -r48000 -p64 -n2 -D -Chw:0,2 -Phw:0,3 -S

This will give you 16 input ports and 16 output ports.

The 16 output ports map onto the 16 FX buses (or the first 16 of 64, for the
Audigy).  The mapping from FX bus to physical output is described in
SB-Live-mixer.txt (or Audigy-mixer.txt).

The 16 input ports are connected to the 16 physical inputs.  Contrary to
popular belief, all emu10k1 cards are multichannel cards.  Which of these
input channels have physical inputs connected to them depends on the card
model.  Trial and error is highly recommended; the pinout diagrams
for the card have been reverse engineered by some enterprising kX users and are 
available on the internet.  Meterbridge is helpful here, and the kX forums are
packed with useful information.

Each input port will either correspond to a digital (SPDIF) input, an analog
input, or nothing.  The one exception is the SBLive! 5.1.  On these devices,
the second and third input ports are wired to the center/LFE output.  You will
still see 16 capture channels, but only 14 are available for recording inputs.

This chart, borrowed from kxfxlib/da_asio51.cpp, describes the mapping of JACK
ports to FXBUS2 (multitrack recording input) and EXTOUT (physical output)
channels.

/*JACK (& ASIO) mappings on 10k1 5.1 SBLive cards:
--------------------------------------------
JACK		Epilog		FXBUS2(nr)
--------------------------------------------
capture_1	asio14		FXBUS2(0xe)
capture_2	asio15		FXBUS2(0xf)
capture_3	asio0		FXBUS2(0x0)	
~capture_4	Center		EXTOUT(0x11)	// mapped to by Center
~capture_5	LFE		EXTOUT(0x12)	// mapped to by LFE
capture_6	asio3		FXBUS2(0x3)
capture_7	asio4		FXBUS2(0x4)
capture_8	asio5		FXBUS2(0x5)
capture_9	asio6		FXBUS2(0x6)
capture_10	asio7		FXBUS2(0x7)
capture_11	asio8		FXBUS2(0x8)
capture_12	asio9		FXBUS2(0x9)
capture_13	asio10		FXBUS2(0xa)
capture_14	asio11		FXBUS2(0xb)
capture_15	asio12		FXBUS2(0xc)
capture_16	asio13		FXBUS2(0xd)
*/

TODO: describe use of ld10k1/qlo10k1 in conjunction with JACK




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
