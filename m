From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002215]: Agere softmodem attached to
	Intel HDA does not work
Date: Mon, 3 Jul 2006 13:58:33 +0200
Message-ID: <517b0b874dc87a67e212b852580e4e3f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFBAA21B
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 13:58:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2215> 
======================================================================
Reported By:                bluebottle
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2215
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             
======================================================================
Date Submitted:             06-17-2006 07:45 CEST
Last Modified:              07-03-2006 13:58 CEST
======================================================================
Summary:                    Agere softmodem attached to Intel HDA does not work
Description: 
I have an MSI 1057 notebook with an Agere winmodem attached to the Intel
HDA device. It does not function with the latest release of ALSA
(currently 1.0.11). I attempted to modify patch_si3054.c and changed the
last device ID from 3026 to 3055 so that it loads and IDs the modem
(incorrectly) as a Si3054. That was just to prove that it *could* be
identified. When dialling via slmodemd though, nothing happens. KPPP or
any other app just gets no response from slmodemd after an ATDT.

# cat /proc/asound/card0/codec#1
Codec: Generic 11c1 Si3054        (before my hack, "Si3054" was "ID
3055")
Address: 1
Vendor Id: 0x11c13055
Subsystem Id: 0x11c11601
Revision Id: 0x100700

I have a .INF from the windows drivers CD with lots of device command
codes in it, if that would help. I'm not sure about license issues so I
won't post it initially. Windows is not installed on this machine so I
can't test it with Windows without swapping out the disk, sorry.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-30-06 13:46 
----------------------------------------------------------------------
To be sure, turn on "Off-hook" switch via alsamixer manually, then try
slmodem again.

----------------------------------------------------------------------
 alexhemp - 07-03-06 13:58 
----------------------------------------------------------------------
Same problem on MSI MegaBook S425 (Gentoo on Kernel 2.6.17 with in-kernel
ALSA)

I'm trying same patch, and follow the notes (using modem:0 for slmodemd,
turn on Off-hook in alsamixer) but nothing helps...

slmodemd version is 2.9.11

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-06 07:45 bluebottle     New Issue                                    
06-17-06 07:45 bluebottle     Distribution              => Ubuntu          
06-17-06 07:46 bluebottle     File Added: ModemData.txt                    
06-17-06 07:50 bluebottle     Issue Monitored: bluebottle                    
06-29-06 18:35 tiwai          Note Added: 0010687                          
06-30-06 13:19 bluebottle     Note Added: 0010730                          
06-30-06 13:46 tiwai          Note Added: 0010733                          
07-03-06 13:58 alexhemp       Note Added: 0010798                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
