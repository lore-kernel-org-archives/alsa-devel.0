From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002181]: HDA modem SI3054 identified
	but not working
Date: Mon, 5 Jun 2006 13:54:17 +0200
Message-ID: <e30e086d28e3e454341d365b94c9526e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4ABD613F
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jun 2006 13:54:17 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2181> 
======================================================================
Reported By:                support-at-eeos
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2181
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva 2006.0
Kernel Version:             2.6.12 / 2.6.16
======================================================================
Date Submitted:             06-02-2006 19:47 CEST
Last Modified:              06-05-2006 13:54 CEST
======================================================================
Summary:                    HDA modem SI3054 identified but not working
Description: 
LAPTOP TARGA 856 WA MT34
SOUNDCARD: ATI HDA SB 450 with integrated modem Agere Systems HDA
(identified as SI3054)
Alsa: 1.0.11 both on kernel 2.6.12 and 2.6.16.
Module: snd_hda_intel, properly identified, sound works well.
Slmodem: 2.9.11 last stable.
Wvdial: 1.54.0
Wvdial.conf: tried both with and without adding parameters X3 and Carrier
Check = no
ATTACHED: lspci -vv of sound device, aplay -l, cat
/proc/asound/card0/codec#1, uname -a

Modem properly identified as SI 3054 card 0 device 6 (see aplay -l output
here below).

PROBLEM:
1) wvdial does not connect. wvdial tries to dial, without any audible
effect, but always returns message  no carrier. 
2) Modem volume cannot be controlled.
3) alternative attempt with kppp return the same results

aplay -l gives

card 0: SB [HDA ATI SB], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

and 

cat /proc/asound/card0/codec#1

[eeos@localhost ~]$ cat /proc/asound/card0/codec#1
Codec: Generic 11c1 Si3054
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x100700

LSPCI -VV

[root@localhost eeos]# lspci -vv -s 00:14.2
00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
0369
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin ? routed to IRQ 17
        Region 0: Memory at febf8000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000

UNAME -A

[root@localhost eeos]# uname -a
Linux localhost 2.6.16-1mdk #1 Fri May 19 19:49:05 CEST 2006 i686 AMD
Turion(tm) 64 Mobile Technology MT-34 unknown GNU/Linux
======================================================================

----------------------------------------------------------------------
 support-at-eeos - 06-05-06 13:54 
----------------------------------------------------------------------
Microsoft Windows XP Home identifies the modem as AGERE SYSTEMS HDA MODEM

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-06 19:47 support-at-eeosNew Issue                                    
06-02-06 19:47 support-at-eeosDistribution              => Mandriva 2006.0 
06-02-06 19:47 support-at-eeosKernel Version            => 2.6.12 / 2.6.16 
06-02-06 19:48 support-at-eeosIssue Monitored: support-at-eeos                  
 
06-05-06 13:54 support-at-eeosNote Added: 0010069                          
======================================================================
