From: Richard Olsson <flame@home.se>
Subject: CS46xx woes.
Date: Fri, 15 Nov 2002 12:10:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021115121043.67b5c0af.flame@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi.

I just upgraded my ALSA from 0.9.0rc2 to 0.9.0rc5 and my sound went from
"ok" to "very bad".  I've got a Hercules Gametheater XP with the CS4630
chip.  The volume (with same mixer settings before, including PCM at max
74% due to disorted sound at higher settings) is generally lower, and
also weaker, and sounds quite a bit worse too.  I also tried the
2002-11-15 CVS snapshot with the same results.

One strange thing is that in alsamixer the chipset line is "Cirrus Logic
CS4294 rev 5,Cirrus Logic CS4294 rev 5" which seems a bit wrong.

Kernel used is 2.4.19; compiled with GCC 3.2 etc in Gentoo 1.4,
shouldn't matter I guess.

"lspci -vv" says:
00:0d.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: Unknown device 1681:0050
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at db200000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: Memory at db100000 (32-bit, non-prefetchable)
[size=1M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Anyone else noticed this?

Thanks, and keep up the good work:)

-- 
Richard Olsson
home: flame@home.se
WWW: http://www.nyo-box.net/


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
