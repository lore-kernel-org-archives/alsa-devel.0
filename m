From: Rick B <zajelo3@cfl.rr.com>
Subject: Alsa Nvidia APU support
Date: Sat, 11 Dec 2004 22:30:08 -0500
Message-ID: <41BBBB40.8080206@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
    I wanted to get some guidance and suggestions regarding the 
possibility of support for the Nvidia NForce2 APU. I use the AC97 chip 
under Alsa, but I realize at this time the Nforce2 APU is not supported 
under Alsa. However, I'm wondering if there was any possibility that I 
could somehow modify either the snd_intel8x0 module that the AC97 uses 
or the snd_via82xx module, since that's what the Nforce2 APU is 
recognised as, to use the APU and AC97 at the same time? As I have some 
extra time on my hands, I am willing to try indepth to get the Nvidia 
APU working under Alsa. If this simply isn't possible for one reason or 
another, please let me know. If it is possible but with considerable 
effort, please point me in the right direction. If you reply to this 
post from the alsa-devel list please "reply to all" as I'm not 
subscribed to that list. Below is the output of lspci that shows how 
each chip appears on my system:

00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
    Subsystem: Asustek Computer, Inc.: Unknown device 0c11
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (250ns min, 3000ns max)
    Interrupt: pin A routed to IRQ 3
    Region 0: Memory at e4000000 (32-bit, non-prefetchable)
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
    Subsystem: Asustek Computer, Inc.: Unknown device 8095
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (500ns min, 1250ns max)
    Interrupt: pin A routed to IRQ 5
    Region 0: I/O ports at e000
    Region 1: I/O ports at e400 [size=128]
    Region 2: Memory at e4080000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks in advance for any suggestions.

                   Rick B


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
