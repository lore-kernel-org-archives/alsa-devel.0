From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000536]: Sound no longer works on IBM ThinkPad 600x after waking from sleep
Date: Fri, 30 Dec 2005 05:16:17 +0100
Message-ID: <23d61b29093f9b47d007d3981e5b5333@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18373193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:16:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=536> 
======================================================================
Reported By:                bkendig
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   536
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC2
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-24-2004 16:23 CEST
Last Modified:              12-30-2005 05:16 CET
======================================================================
Summary:                    Sound no longer works on IBM ThinkPad 600x after
waking from sleep
Description: 
After booting this laptop, sound works fine; but after putting the system
to sleep and waking it, sound will no longer work until the system is
rebooted.  No error messages are displayed.

This is an IBM ThinkPad 600x, which has a feature where it will cut power
to the PCI bus to save battery when the bus is not being used.  I believe
this is what's killing ALSA.

This system is running Fedora Core 2 with kernel version 2.6.9-rc2, but
the problem has occurred with every version of 2.6 since its release.

The sound modules can not be unloaded because the system believes they're
still in use. "/sbin/rmmod snd_cs46xx" returns "ERROR: Module snd_cs46xx
is in use".


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000226 Sound hangs after APM resume
======================================================================

----------------------------------------------------------------------
 sboehler - 03-28-05 15:49 
----------------------------------------------------------------------
I have the same problem with a Thinkpad T22, ACPI and kernel 2.6.11.2. Even
though reloading the module after ACPI resume works, it is a pain because
all the applications using sound have to be killed. I'm willing to assist
in solving this problem, is anybody working on this? Do you guys have data
books for this soundcard?

Soundcard:

0000:00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM: Unknown device 0153
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8122000 (32-bit, non-prefetchable) [size=4K]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:16 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 16:23 bkendig        New Issue                                    
09-24-04 16:23 bkendig        Distribution              => FC2             
09-24-04 16:23 bkendig        Kernel Version            => 2.6.9-rc2       
10-01-04 17:07 tiwai          Note Added: 0002002                          
01-17-05 11:01 jdthood        Note Added: 0003228                          
03-22-05 15:02 jdthood        Relationship added       has duplicate 0000226
03-28-05 15:49 sboehler       Note Added: 0004241                          
06-20-05 02:00 tromer         Issue Monitored: tromer                      
12-12-05 11:11 bheung         Issue Monitored: bheung                      
12-30-05 05:16 rlrevell       Note Added: 0007238                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
