From: Jason McMullan <jmcmulla@linuxcare.com>
Subject: VIA 8233 - Interrupt problems w/KT266 Aopen AK77 Pro(A) 133
Date: Tue, 14 May 2002 09:43:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020514134335.GA18019@jmcmullan.evillabs.net>
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


  Hi there. I have the wackiest problem with my VIA 8233.
I can record just fine, but playback does nothing. 

  I have a KT266 based Aopen AK77 Pro(A) 133 motherboard,
and 'Everything works great under Windows(tm)', but 
under linux (ALSA 0.5 and 0.9) I can only get interrupts
to happen on record. No interrupts whatsoever on playback.

  I have all the mixers unmuted, volumes set, etc. etc.

  I've tried (by forcing PNP settings in the bios) the 
VIA 8233 on IRQs 12 & 5, with no change.

  Any ideas? 

  Anyone know where I can find the VIA 8233 specs so I can
figure this out?

--------- lspci -xxx -------------------------------------
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

------- lspci -vvv ------------------------------------
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

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
