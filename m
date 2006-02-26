From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: vendor entry for cs46xx out of date
Date: Sun, 26 Feb 2006 14:27:48 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0602261427420.14755@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,


http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Cirrus_Logic#matrix

the cs46xx is missing (3)(hardware mixing), but at least mine does do it.
Care to update the table?

Please Cc: me.


Jan Engelhardt
-- 

(TerraTec DMX XFire1024)
`lspci -vv`:
00:0d.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: TERRATEC Electronic GmbH: Unknown device 112e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at cfff7000 (32-bit, non-prefetchable) [size=4K]
        Region 1: Memory at cfe00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk+ DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

`lspci -n`:
00:0d.0 Class 0401: 1013:6003 (rev 01)




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
