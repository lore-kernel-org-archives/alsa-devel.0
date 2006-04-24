From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002044]: How about adding __devinitdata to the PCI-IDs?
Date: Mon, 24 Apr 2006 16:01:22 +0200
Message-ID: <876dedd1e29a7e94019ab8fd25518305@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1797192
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 16:01:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2044> 
======================================================================
Reported By:                Henne
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2044
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.17-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-20-2006 17:44 CEST
Last Modified:              04-24-2006 16:01 CEST
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
 Henne - 04-24-06 15:49 
----------------------------------------------------------------------
You meant CONFIG_HOTPLUG, did you? :)

----------------------------------------------------------------------
 tiwai - 04-24-06 16:01 
----------------------------------------------------------------------
The patches are applied to Hg repo.  Thanks.

The CVS tree is broken and obsoleted now.  Use Hg instead.

And, it's CONFIG_HOTPLUG_PCI, more exactly :)

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
04-23-06 21:21 Henne          File Added: dev2.diff                        
04-23-06 21:22 Henne          File Added: wr2.diff                         
04-23-06 21:26 Henne          Note Added: 0009443                          
04-24-06 15:49 Henne          Note Added: 0009455                          
04-24-06 15:51 tiwai          Note View State: private: 9443                    
04-24-06 15:51 tiwai          Note View State: public: 9443                    
04-24-06 16:01 tiwai          Status                   new => resolved     
04-24-06 16:01 tiwai          Resolution               open => fixed       
04-24-06 16:01 tiwai          Assigned To               => tiwai           
04-24-06 16:01 tiwai          Note Added: 0009462                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
