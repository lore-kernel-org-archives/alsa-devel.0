From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002248]: Sounds stops and continue
Date: Fri, 7 Jul 2006 17:32:24 +0200
Message-ID: <1b7c60e5e421104fd81ca3430d188c19@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57624284
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 17:32:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2248> 
======================================================================
Reported By:                gwagner
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2248
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-30-2006 06:05 CEST
Last Modified:              07-07-2006 17:32 CEST
======================================================================
Summary:                    Sounds stops and continue
Description: 
Every sounds "music movies" are having little pauses, it's pausing for few
miliseconds and continue. It's happen on every kind of aplication.
My matherborad is an Asus-A8V-Deluxe, chipset Via VT8237, Athlon 64 3000,
that should work with snd_via82xx. I have an soud blaster card too, but
that work fine.
======================================================================

----------------------------------------------------------------------
 gwagner - 07-07-06 01:21 
----------------------------------------------------------------------
Yes, I already heard this history about BIOS of ASUS A8V Deluxe too.
The output of "lspci -vvxxx" and bootdmesg both with and without sound
blaster pci board is attached.

----------------------------------------------------------------------
 vsu - 07-07-06 17:32 
----------------------------------------------------------------------
Unfortunately, the kernel version number is not visible in the dmesg
output; I presume that you are using either 2.6.17 or a recent 2.6.16.x
version.

Also seems that you have grabbed the "lspci -vvxxx" output without the PCI
sound card when the snd-via82xx module was not loaded.

But I see the important difference anyway - when the PCI sound card is
present, the PCI_INTERRUPT_LINE register of the builtin audio device is
not set properly, which is important for VIA southbridges.  For testing,
you can try to set this register manually:

  setpci -s 00:11.5 INTERRUPT_LINE=05

(before doing this, double check the "lspci -s 00:11.5 -vv" output to make
sure that Linux assigned IRQ 5 to the device).

If this command fixes the sound problem, then the broken VIA IRQ quirk
patches which have gone into 2.6.17 and 2.6.16.17 are the culprit.  Try to
revert (patch -p1 -R <file.patch) these patches:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=a7b862f663d81858531dfccc0537bc9d8a2a4121

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=75cf7456dd87335f574dcd53c4ae616a2ad71a11

After reverting these patches the kernel will set the PCI_INTERRUPT_LINE
register for all VIA devices, and interrupt routing will work properly
without that setpci command.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-30-06 06:05 gwagner        New Issue                                    
06-30-06 16:36 rlrevell       Note Added: 0010740                          
07-05-06 15:40 gwagner        Note Added: 0010841                          
07-05-06 16:48 rlrevell       Note Added: 0010842                          
07-06-06 19:31 gwagner        Note Added: 0010871                          
07-06-06 19:37 rlrevell       Note Added: 0010872                          
07-06-06 19:57 vsu            Note Added: 0010875                          
07-06-06 19:57 vsu            Issue Monitored: vsu                         
07-06-06 19:58 vsu            Note Edited: 0010875                         
07-07-06 00:49 gwagner        File Added: bootdmesg_without_sbpci               
    
07-07-06 00:50 gwagner        File Added: bootdmesg_with_sbpci                  
 
07-07-06 00:51 gwagner        File Added: lspci_without_sbpci                   

07-07-06 00:51 gwagner        File Added: lspci_with_sbpci                    
07-07-06 01:21 gwagner        Note Added: 0010888                          
07-07-06 17:32 vsu            Note Added: 0010917                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
