From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002044]: How about adding __devinitdata to the PCI-IDs?
Date: Fri, 21 Apr 2006 12:50:54 +0200
Message-ID: <ea478f26248c119640a429e804fdec54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9880A16C
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 12:50:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2044> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2044
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.17-rc2
======================================================================
Date Submitted:             04-20-2006 17:44 CEST
Last Modified:              04-21-2006 12:50 CEST
======================================================================
Summary:                    How about adding __devinitdata to the PCI-IDs?
Description: 
I found a way to save GBs of Memory. Like in 
<kernelsources>/Documentation/pci.txt  mentioned, the definiton of PCI
drivers device-IDs can be marked as __devinitdata.

This can be interesting, cause from 394 definitions of pci_device_ids in
kernel 2.6.17-rc2, only 37 have it.
That are 28Bytes/line on 32bit machines and 32Bytes/line on 64 bit
machines.
So I found the reason why the kernel is so resoucehungry. ;)
I'll contact the kerneljanitors to add it in their TODO.

I've added a patch for "writing an alsa driver".
======================================================================

----------------------------------------------------------------------
 Henne - 04-20-06 19:00 
----------------------------------------------------------------------
The second patch "dev.diff" is for adding that to all ALSA-PCI-drivers.

----------------------------------------------------------------------
 tiwai - 04-21-06 12:50 
----------------------------------------------------------------------
Usually __devinitdata is appended after the variable name, such as

  static struct pci_device_id foo_ids[] __devinitdata = {
  ...

Although the position doesn't matter in practice, it's better to follow
the majority.

Could you regenerate the patchs in that style?  Thanks.

(BTW, we would save likely no GB space because __devinitdata has no effect
when PCI_HOTPLUG is enabled :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-06 17:44 Henne          New Issue                                    
04-20-06 17:44 Henne          File Added: wr.diff                          
04-20-06 17:44 Henne          Distribution              => Suse 10.0 x86_64
04-20-06 17:44 Henne          Kernel Version            => 2.6.17-rc2      
04-20-06 19:00 Henne          Note Added: 0009396                          
04-20-06 19:00 Henne          File Added: dev.diff                         
04-21-06 12:50 tiwai          Note Added: 0009411                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
