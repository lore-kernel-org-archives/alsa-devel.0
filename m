From: Jason McMullan <jmcmullan@linuxcare.com>
Subject: VIA 8233 - Record works, playback nil.
Date: Mon, 13 May 2002 14:39:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020513183902.GA13557@jmcmullan.evillabs.net>
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


  I have a VIA 8233 based motherboard (AOpen AK77 Pro(A) 133)
which is based off of the VIA KT266 chipset pair.

  Anyhow, here's my problem. I can record all I want with
either 0.5.12a or 0.9.0r1, and I get interrupts, valid data,
etc.
 
  However, I can't play it back. I get no interrupt hits 
(I've checked /proc/interrupts) on playback. At all. I've
tried ALSA 0.5, ALSA 0.9, OSS, etc. To no avail.

  Needless to say, "It works great under Windows!".

  Any help would be appreciated. Or, even better, a pointer
to the VIA 8233 specs so I can fix this on my own...

------------- /proc/interrupts -----------------------------
           CPU0       
  0:     273115          XT-PIC  timer
  1:          1          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:         71          XT-PIC  VIA8233
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      19697          XT-PIC  usb-uhci, usb-uhci, eth0
 14:      17213          XT-PIC  ide0
 15:          6          XT-PIC  ide1
NMI:          0 
LOC:     273072 
ERR:         35
MIS:          0

------------- /proc/asound/cards -----------------------
0 [card0          ]: VIA8233 - VIA 8233
                     VIA 8233 at 0xe000, irq 5

------------- lspci -xxx -------------------------------
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 40)
00: 06 11 59 30 01 00 10 02 40 00 01 04 00 00 00 00
10: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 d4 11 60 53
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00
40: 01 cc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-------------- lspci -vvv ---------------------------
00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 40)
        Subsystem: Analog Devices: Unknown device 5360
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
