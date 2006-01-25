From: Hadmut Danisch <hadmut@danisch.de>
Subject: intel8x0: Driver does not recognize card
Date: Wed, 25 Jan 2006 14:38:37 +0100
Message-ID: <20060125133837.GA11527@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sklave3.rackland.de (sklave3.rackland.de [213.133.101.23])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BEDF717A
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 14:38:37 +0100 (MET)
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
To: perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a FUjitsu-Siemens Celsius Workstation, 
and Linux 2.6.15.1, but it does not recognize the sound card:

# lspci -vv -s 0:1b.0
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)
        Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 1083
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
	<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f0000000 (64-bit, non-prefetchable)
	[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
		PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+
	Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] #10 [0091]


# lspci -n -s 0:1b.0
0000:00:1b.0 0403: 8086:27d8 (rev 01)



When inserting snd-intel8x0 just nothing happens.

I saw that 8086:27d8 is not listed in sound/pci/intel8x0.c and added 
        { 0x8086, 0x27d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
        DEVICE_INTEL_ICH4 }, /* ICH7 */

to snd_intel8x0_ids[], but it still does not work. 

Kernel then says: 

ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1b.0 to 64
codec_ready: codec is not ready [0xa0a0a0a0]
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Intel ICH: probe of 0000:00:1b.0 failed with error -5



regards
Hadmut



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
