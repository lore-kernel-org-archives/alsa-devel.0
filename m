From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000959]: After S3 resume: ali_stimer_read: stimer is not ready
Date: Fri, 17 Mar 2006 16:06:16 +0100
Message-ID: <45aea7e31d41b593060c39badcc95aa8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C2551AD
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 16:06:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=959> 
======================================================================
Reported By:                avuton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   959
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-03-2005 18:41 CET
Last Modified:              03-17-2006 16:06 CET
======================================================================
Summary:                    After S3 resume: ali_stimer_read: stimer is not
ready
Description: 
After S3 resume, 'ali_stimer_read: stimer is not ready.' repeats until I
reset/power down the computer.

Workaround is to stop all audio activity and unload the driver, which
works fine.

This happens on my Libretto L5.
======================================================================

----------------------------------------------------------------------
 sluskyb - 02-17-06 18:09 
----------------------------------------------------------------------
No news is bad news... still broken as of driver 1.0.11rc2 or kernel
2.6.16-rc3.

----------------------------------------------------------------------
 sluskyb - 03-17-06 16:06 
----------------------------------------------------------------------
Same results with S4 suspend/resume (suspend to disk).

Is anyone reading this??

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-05 18:41 avuton         New Issue                                    
03-03-05 18:41 avuton         Distribution              => Gentoo          
03-03-05 18:41 avuton         Kernel Version            => 2.6.11          
05-02-05 02:22 avuton         Note Added: 0004583                          
06-27-05 03:52 avuton         Note Added: 0005270                          
07-08-05 14:59 tiwai          Note Added: 0005431                          
07-08-05 22:48 avuton         Note Added: 0005436                          
12-14-05 17:28 sluskyb        File Added: ali5451-S3.txt                    
12-14-05 17:38 sluskyb        Note Added: 0007038                          
12-14-05 18:13 sluskyb        Issue Monitored: sluskyb                     
02-17-06 18:09 sluskyb        Note Added: 0008109                          
03-17-06 16:06 sluskyb        Note Added: 0008647                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
