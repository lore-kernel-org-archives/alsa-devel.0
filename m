From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000158]: Device not detected
Date: Mon, 14 Nov 2005 10:38:35 +0100
Message-ID: <6dbde930a1d8a1a0202021ff2aa1213f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9CF2A19E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:38:35 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=158> 
======================================================================
Reported By:                stst
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   158
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2004 22:02 CET
Last Modified:              11-14-2005 10:38 CET
======================================================================
Summary:                    Device not detected
Description: 
when loading the module it crashes with this errormessage:
/lib/modules/2.4.21-144-athlon/kernel/sound/pci/cs46xx/snd-cs46xx.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.21-144-athlon/kernel/sound/pci/cs46xx/snd-cs46xx.o:
insmod /lib/modules/2.4.21-144-athlon/kernel/sound/pci/cs46xx/snd-cs46xx.o
failed

======================================================================

----------------------------------------------------------------------
 jdthood - 09-22-05 15:23 
----------------------------------------------------------------------
Submitter: Were you able to fix the problem?  Are you sure that your sound
hardware is functioning properly?

----------------------------------------------------------------------
 perex - 11-14-05 10:38 
----------------------------------------------------------------------
No response from reporter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 22:02 stst           New Issue                                    
03-24-04 22:04 stst           Issue Monitored: stst                        
03-24-04 22:06 stst           Note Added: 0000702                          
03-19-05 09:35 jdthood        Note Added: 0004021                          
09-22-05 15:23 jdthood        Note Added: 0006350                          
09-22-05 15:23 jdthood        Severity                 crash => major      
09-22-05 15:23 jdthood        Summary                 
/lib/modules/2.4.21-144-athlon/kernel/sound/pci/cs46xx/snd-cs46xx.o:
init_module: No such device => Device not detected
11-14-05 10:38 perex          Status                   new => resolved     
11-14-05 10:38 perex          Resolution               open => fixed       
11-14-05 10:38 perex          Assigned To               => perex           
11-14-05 10:38 perex          Note Added: 0006710                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
