From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001200]: rmedigicontrol error: Assertion `obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed
Date: Tue, 21 Jun 2005 14:55:55 +0200
Message-ID: <f47e1e838f64508178d15153bfd2367d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D4D21F6
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 14:55:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1200> 
======================================================================
Reported By:                dmaley
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1200
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-17-2005 19:17 CEST
Last Modified:              06-21-2005 14:55 CEST
======================================================================
Summary:                    rmedigicontrol error: Assertion `obj->type ==
SND_CTL_ELEM_TYPE_ENUMERATED' failed
Description: 
I'm running into a problem w/ the latest FC3 kernel (2.6.11-1.27_FC3).  The
problem occurs when I try to run rmedigicontol from alsa-tools.  This was
working just fine w/ the 2.6.9 and 2.6.10 based FC3 kernels, however now
with 2.6.11-1.14_FC3 I'm getting the following error:

[dave@homer tunes]$ rmedigicontrol
rmedigicontrol: control.c:1686: snd_ctl_elem_info_get_items: Assertion
`obj->type == SND_CTL_ELEM_TYPE_ENUMERATED' failed.
Aborted
[dave@homer tunes]


In looking at the attached strace output it appears that it's unable to
find some needed ioctls:

ioctl(3, USBDEVFS_CONNECTINFO, 0x807daf8) = -1 ENOENT (No such file or
directory)
ioctl(3, USBDEVFS_IOCTL, 0x807dc10)     = -1 ENOENT (No such file or
directory)
write(2, "rmedigicontrol: control.c:1686: "..., 123) = 123
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
tgkill(4714, 4714, SIGABRT)             = 0
--- SIGABRT (Aborted) @ 0 (0) ---
+++ killed by SIGABRT +++


Any thoughts as to what's changed that could be causing this problem?
======================================================================

----------------------------------------------------------------------
 dmaley - 06-19-05 07:39 
----------------------------------------------------------------------
This bug should be filed against alsa-tools however I can't see how to
change the catagory.  Also I just noticed the policy about providing email
addresses.  Martin Langer <martin-langer@gmx.de> provided me w/ this fix.

----------------------------------------------------------------------
 tiwai - 06-21-05 14:55 
----------------------------------------------------------------------
Appled to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-17-05 19:17 dmaley         New Issue                                    
06-17-05 19:17 dmaley         File Added: rmedigicontrol.bad.trace              
     
06-17-05 19:17 dmaley         File Added: rmedigicontrol.good.trace             
      
06-17-05 19:20 dmaley         Note Added: 0005077                          
06-17-05 19:20 dmaley         Issue Monitored: dmaley                      
06-18-05 20:55 dmaley         Note Added: 0005084                          
06-18-05 20:56 dmaley         File Added: rme_getinteger.patch                  
 
06-19-05 07:39 dmaley         Note Added: 0005085                          
06-21-05 14:55 tiwai          Status                   new => resolved     
06-21-05 14:55 tiwai          Resolution               open => fixed       
06-21-05 14:55 tiwai          Assigned To               => tiwai           
06-21-05 14:55 tiwai          Note Added: 0005111                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
