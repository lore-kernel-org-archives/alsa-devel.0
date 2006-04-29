From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002080]: Card driver works incorrectly after resume
Date: Sat, 29 Apr 2006 05:03:03 +0200
Message-ID: <9035540b16d0fd87290e7dcb95f1085c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 704E618E
	for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2006 05:03:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2080> 
======================================================================
Reported By:                Alexey Morozov
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   2080
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ALT Linux
Kernel Version:             2.6.16.9 + extra patches
======================================================================
Date Submitted:             04-27-2006 18:35 CEST
Last Modified:              04-29-2006 05:03 CEST
======================================================================
Summary:                    Card driver works incorrectly after resume
Description: 
When I resume after hibernating to disk (performed by swsusp-2.2.5) sound
card driver seems to correctly load up (that is no errors reported) but
actually audio playback and other card manipulation such as mixer tuning
is impossible:

playback fails like this:

alex@localhost ~ $ aplay -v
/home/archives/Music/Bob_Marley/disk1/track05.cdda.wav
Playing WAVE '/home/archives/Music/Bob_Marley/disk1/track05.cdda.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: pcm_write:1257: write error: Input/output error

after several seconds of silence and manipluating mixer with alsamixer
becomes really slow.

After reloading just the driver (i.e. 

alex@localhost ~ $ sudo modprobe -r snd_au8830
alex@localhost ~ $ sudo modprobe snd_au8830

normal playback is restored.

The problem is 100% reproducible and actually it was reproducable in
previous (e.g. 1.0.10) versions of alsa-driver and previous kernels.

Here's output of lspci -vv for the card:

0000:00:0e.0 Multimedia audio controller: Aureal Semiconductor Vortex 2
(rev fe)
        Subsystem: Diamond Multimedia Systems Monster Sound II
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 3000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de800000 (32-bit, non-prefetchable)
        Region 1: I/O ports at b800 [size=8]
        Region 2: I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


I can provide any additional information about host/OS configuration upon
a request.
======================================================================

----------------------------------------------------------------------
 Raymond - 04-28-06 05:05 
----------------------------------------------------------------------
Power management is not yet supported by ALSA au88x0 driver

http://developer.intel.com/technology/iapc/involve.htm#audio

You need to implement

static int snd_vortex_suspend(struct pci_dev *pci, pm_message_t state)
int snd_vortex_resume(struct pci_dev *pci)


http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948

BTW, do you MX300 has this problem
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726



----------------------------------------------------------------------
 Raymond - 04-29-06 05:03 
----------------------------------------------------------------------
However ALSA only support CONFIG_PM, CONFIG_SOFTWARE_SUSPEND is most likely
not supported

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-27-06 18:35 Alexey Morozov New Issue                                    
04-27-06 18:35 Alexey Morozov Distribution              => ALT Linux       
04-27-06 18:35 Alexey Morozov Kernel Version            => 2.6.16.9 + extra
patches
04-28-06 03:58 Raymond        Note Added: 0009537                          
04-28-06 05:01 Raymond        Note Edited: 0009537                         
04-28-06 05:05 Raymond        Note Edited: 0009537                         
04-29-06 05:03 Raymond        Note Added: 0009540                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
