From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000158]: /lib/modules/2.4.21-144-athlon/kernel/sound/pci/cs46xx/snd-cs46xx.o: init_module: No such device
Date: Sat, 19 Mar 2005 09:36:00 +0100
Message-ID: <e2fd59073a7a794726e212d91b76cd67@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 882691F9
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:36:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=158> 
======================================================================
Reported By:                stst
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   158
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-24-2004 22:02 CET
Last Modified:              03-19-2005 09:35 CET
======================================================================
Summary:                   
/lib/modules/2.4.21-144-athlon/kernel/sound/pci/cs46xx/snd-cs46xx.o:
init_module: No such device
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
 stst - 03-24-04 22:06 
----------------------------------------------------------------------
Sorry, I forgot to mention that this happens with a Terratec DMX XFire
1024.

----------------------------------------------------------------------
 jdthood - 03-19-05 09:35 
----------------------------------------------------------------------
So I take it the problem is that the message suggests "reloading" the
driver,
but this cannot be done because the init routine exits with an error
status?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 22:02 stst           New Issue                                    
03-24-04 22:04 stst           Issue Monitored: stst                        
03-24-04 22:06 stst           Note Added: 0000702                          
03-19-05 09:35 jdthood        Note Added: 0004021                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
