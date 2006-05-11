From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002080]: Card driver works incorrectly after resume
Date: Thu, 11 May 2006 03:45:56 +0200
Message-ID: <5dae048dd5c30d79d6a2945644b699b1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26E5C1A9
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2006 03:45:57 +0200 (MEST)
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
Last Modified:              05-11-2006 03:45 CEST
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
 Raymond - 05-04-06 11:20 
----------------------------------------------------------------------
fix typo in doc

---
alsa-driver-1.0.11/alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl.orig	2006-05-04
12:46:33.000000000 +0800
+++
alsa-driver-1.0.11/alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	2006-05-04
12:47:43.000000000 +0800
@@ -5562,7 +5562,7 @@
 	  power status.</para></listitem>
         <listitem><para>Call <function>snd_pcm_suspend_all()</function>
to suspend the running PCM streams.</para></listitem>
 	<listitem><para>If AC97 codecs are used, call
-	<function>snd_ac97_resume()</function> for each
codec.</para></listitem>
+	<function>snd_ac97_suspend()</function> for each
codec.</para></listitem>
         <listitem><para>Save the register values if
necessary.</para></listitem>
         <listitem><para>Stop the hardware if
necessary.</para></listitem>
         <listitem><para>Disable the PCI device by calling


----------------------------------------------------------------------
 Raymond - 05-11-06 03:45 
----------------------------------------------------------------------
> Actually, I don't need a proper suspend/resume. If the card will be reset
after 
> resume (i.e. zero volume or muted channels etc) but will remain
functioning 
> without driver reload, of if the driver can be reloaded without stopping
every 
> application which accesses the card one way or another, it's all
acceptable for me.

Refer to the above URL, Vortex 1 and Vortex 2 only passed the test of
S3(Suspend to Ram), you should not expect it support S4(Suspend to Disk)

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
04-30-06 09:36 Raymond        Note Edited: 0009540                         
05-02-06 08:18 Alexey Morozov Note Added: 0009557                          
05-02-06 08:28 Alexey Morozov Note Added: 0009558                          
05-02-06 14:14 Raymond        Note Added: 0009559                          
05-03-06 18:55 Raymond        Note Added: 0009597                          
05-04-06 11:18 Raymond        Note Deleted: 0009597                        
05-04-06 11:20 Raymond        Issue Monitored: tiwai                       
05-04-06 11:20 Raymond        Note Added: 0009608                          
05-11-06 03:45 Raymond        Note Added: 0009757                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
