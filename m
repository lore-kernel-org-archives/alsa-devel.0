From: Luca <kronos@people.it>
Subject: [2.6.3] snd_intel8x0: playing to fast
Date: Wed, 10 Mar 2004 22:21:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040310212125.GA17864@dreamland.darkstar.lan>
Reply-To: kronos@people.it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,
I'm using linux 2.6.3 with alsalib 1.0.2c. When using alsa output plugin
of XMMS or mplayer the song is played too fast. Using OSS emulation
works fine.

This is from bootlog:

intel8x0_measure_ac97_clock: measured 49482 usecs
intel8x0: clocking to 48000

And this is the sound card (chiset is SiS740):

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
        Subsystem: Asustek Computer, Inc.: Unknown device 1653
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at a800 [size=256]
        Region 1: I/O ports at a400 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I RTFM and tried passing ac97_clock, but:

a) I don't know what value to pass. Tried some random numbers between
40000 and 49000
b) It doens't make any difference

I also tried without powernow-k7 (the machine is a laptop) but without success.

Any idea?

Luca
-- 
Home: http://kronoz.cjb.net
Do, or do not. There is no try.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
