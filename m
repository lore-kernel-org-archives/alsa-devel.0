From: Pavel Kysilka <goldenfish@bsys.cz>
Subject: via82xx & acpi -> freeze bug
Date: Sat, 20 Nov 2004 02:52:25 +0100
Message-ID: <20041120015224.GA1795@prog3>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

	Hi all,

i have via82xx based onboard soundcard.
i test toady new kernel 2.6.1-rc2 with suspend to disk (echo 4 > sleep).
my computer totally freeze with loaded module snd-via82xxx. if this
module not loaded, suspend to disk working with no problem.
kernel 2.6.10-rc1 working with this feature ok.

i rewrite by hand this lines (no information in log).

PM: writing image
PCI: Enablinkg device 0000:00:07.5 (0000 -> 0001)
ASCPI: PCI interrupt 0000:00:07.5[C] -> GSI11 (level, low)
PCI: VIA IRQ fixup for 0000:00:07.5, from 0 to 11
ALSA sound/pci/via82xxx.c:1837:AC'97 codec is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:523:coded_ready:codec 0 is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:523:coded_ready:codec 0 is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:585:coded_read:codec 0 is not valid [0xffffff]
ALSA sound/pci/via82xxx.c:523:coded_ready:codec 0 is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:523:coded_ready:codec 0 is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:523:coded_ready:codec 0 is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:523:coded_ready:codec 0 is not ready [0xffffff]
ALSA sound/pci/via82xxx.c:585:coded_read:codec 0 is not valid [0xffffff]


and computer is totally freeze.....

relevant output from lspci:

0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 21)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at cc00 [size=256]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at d400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
	Subsystem: Creative Labs: Unknown device 8067
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at dc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



and i have 1 question: how about support emu10k1 chips and acpi ? is
this support planned ?

if you need any information or testing, contact me.

bye
  pavel kysilka
  programmer http://www.bsys.cz/


________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Server.

http://www.nod32.com


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
