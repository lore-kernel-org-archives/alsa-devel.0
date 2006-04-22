From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001733]: Intel HDA Modem ?
Date: Sun, 23 Apr 2006 01:04:28 +0200
Message-ID: <a3c4b3cf088da552d43ac8d83722d530@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E9D7614F
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 01:04:28 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733> 
======================================================================
Reported By:                chrmue
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1733
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 10.0
Kernel Version:             2.6.13-15
======================================================================
Date Submitted:             01-11-2006 07:23 CET
Last Modified:              04-23-2006 01:04 CEST
======================================================================
Summary:                    Intel HDA Modem ?
Description: 
I want to use my HDA Softmodem in Linux, is there any development on a HDA
Modem Module ?

cat /proc/asound/card0/codec#1 gives me:
Codec: Generic 11c1 ID 3026
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x70500

In Windows it is called "Agere Systems HDA Modem" (Conexant ?)

If there is development on this i would like to participate to get it
going, because i dont't want to have a windows-installation on my Notebook
(Acer TravelMate 8104) just for getting my mails at my parents house,
where there is only analog telephone.
======================================================================

----------------------------------------------------------------------
 kratz00 - 03-16-06 19:44 
----------------------------------------------------------------------
i tried slmodem-2.9.11-20051101 but still the same if i have a little more
time i will have a close look at this but maybe somebody has an idea what
could be wrong in the mean time

----------------------------------------------------------------------
 fdoffizi01 - 04-23-06 01:04 
----------------------------------------------------------------------
Same question for different hardware.

Here lspci output:
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Sony Corporation Unknown device 81ef
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 10
        Interrupt: pin A routed to IRQ 66
        Region 0: Memory at d2300000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

And as you can see current hda modules can't see modem functions:

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

Hardware is a Sony Vaio FE11x series notebook

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 07:23 chrmue         New Issue                                    
01-11-06 07:23 chrmue         Distribution              => SuSE Linux 10.0 
01-11-06 07:23 chrmue         Kernel Version            => 2.6.13-15       
01-11-06 07:42 rlrevell       Note Added: 0007559                          
01-11-06 23:32 sashak         File Added: hda-modem-si3054-11c13026.patch       
            
01-11-06 23:35 sashak         Note Added: 0007571                          
01-12-06 00:00 sashak         Note Added: 0007574                          
01-12-06 00:02 sashak         Issue Monitored: sashak                      
01-12-06 05:35 chrmue         Note Added: 0007581                          
01-13-06 00:16 sashak         Note Added: 0007598                          
01-16-06 20:19 chrmue         Note Added: 0007692                          
01-16-06 20:22 chrmue         Issue Monitored: chrmue                      
03-03-06 15:43 lrupn          Note Added: 0008341                          
03-03-06 15:44 lrupn          Issue Monitored: lrupn                       
03-10-06 23:44 kratz00        Note Added: 0008413                          
03-11-06 15:19 kratz00        Note Added: 0008416                          
03-11-06 19:03 rlrevell       Note Added: 0008421                          
03-11-06 19:23 kratz00        Note Added: 0008423                          
03-11-06 19:33 rlrevell       Note Added: 0008424                          
03-11-06 23:08 sashak         Note Added: 0008427                          
03-12-06 11:22 kratz00        Note Added: 0008431                          
03-15-06 00:42 chrmue         Note Added: 0008525                          
03-15-06 11:35 tiwai          Note Added: 0008530                          
03-15-06 21:42 kratz00        Note Added: 0008573                          
03-15-06 21:42 kratz00        Issue Monitored: kratz00                     
03-16-06 02:17 sashak         Note Added: 0008581                          
03-16-06 19:44 kratz00        Note Added: 0008619                          
04-23-06 01:04 fdoffizi01     Note Added: 0009436                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
