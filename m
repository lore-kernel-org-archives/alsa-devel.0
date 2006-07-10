From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001886]: Problems on reboot
Date: Mon, 10 Jul 2006 18:06:03 +0200
Message-ID: <1a16bcc75e61134bb4e86e99c1b936f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5242A244
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 18:06:03 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1886> 
======================================================================
Reported By:                eric
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1886
Category:                   PCI - via82xx
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-01-2006 17:59 CET
Last Modified:              07-10-2006 18:06 CEST
======================================================================
Summary:                    Problems on reboot
Description: 
Hi, i have little problem with my alsa configuration,

i use kernel 2.6.15 and alsa release 10RC3

on my configuration i use 

1 X snd-via82xx and 2 X snd-ice1724

sometime when i reboot i card as inverted and i have this udev message:

 VIA 82xx Audio: probe of 0000:00:11.5 failed with error -12

======================================================================

----------------------------------------------------------------------
 tiwai - 03-02-06 12:49 
----------------------------------------------------------------------
You have two definitions of snd-ice1724 options, and the latter one
overrides.
Combine the options for ice1724 into a single line.

----------------------------------------------------------------------
 eric - 03-02-06 18:49 
----------------------------------------------------------------------
Problem solved !!! thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-06 17:59 eric           New Issue                                    
03-01-06 18:01 eric           Note Added: 0008285                          
03-02-06 12:49 tiwai          Note Added: 0008299                          
03-02-06 15:50 eric           Note Added: 0008312                          
03-02-06 18:49 eric           Note Deleted: 0008312                        
03-02-06 18:49 eric           Note Added: 0008326                          
03-04-06 10:03 eric           Issue Monitored: eric                        
03-04-06 10:04 eric           Issue End Monitor: eric                      
07-10-06 18:06 Adrian Bunk    Status                   new => closed       
07-10-06 18:06 Adrian Bunk    Resolution               open => not an issue
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
