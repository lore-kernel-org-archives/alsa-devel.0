From: Spirilis <spirilis@scitus.dyn.dhs.org>
Subject: Ensoniq ES1373
Date: Fri, 17 May 2002 22:40:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020517224017.A770@scitus.abs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,
    I bought this Creative Labs Ensoniq AudioPCI card about a year ago, and couldn't get it to work
with Linux back then (ALSA or OSS/Free).  I just decided to pop it in and try it out in Windows first,
then Linux using the latest alsa-driver-0.9.0rc1.  I AM ECSTATIC.  IT WORKS! :)

Excellent work, whoever worked on the driver.  I am using the snd-ens1371 module, and here's the lspci -vv
readout for my card:
00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

This is on Linux kernel 2.4.18, BTW, on an AMD Athlon 900MHz with VIA chipset.  Slackware 8.0.

My only question is, is the BASS/TREBLE mixer supported?

In Windows under the Master Volume in the "Advanced" tab there are settings for BASS/TREBLE and they
do work, however in 'amixer' and 'amixer contents' I see no settings related to BASS or TREBLE boost...

TIA

_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
