From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002021]: No sound from speakers (only headphone) after resume to suspend-to-ram
Date: Tue, 25 Apr 2006 23:54:03 +0200
Message-ID: <9c84181e7bf25e0ce15c10f56fe8522e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A2B8F130
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 23:54:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2021> 
======================================================================
Reported By:                tsaiming
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2021
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             suspend2-2.6.16-r2
======================================================================
Date Submitted:             04-15-2006 13:19 CEST
Last Modified:              04-25-2006 23:54 CEST
======================================================================
Summary:                    No sound from speakers (only headphone) after resume
to suspend-to-ram
Description: 
After suspend2-to-ram (but it happens also with the suspend kernel built
in) I have no more sound from speakers but only from headphones.
With suspend to disk all works good 
Also tried to stop alsasound and unload modules before suspending and
restart service after resume with no change.

======================================================================

----------------------------------------------------------------------
 mmp - 04-25-06 20:37 
----------------------------------------------------------------------
Yes, I did everything as you suggested, but one register just remained the
same; other one (I think it's 5e) used to change its values time to time
(maybe depending on if it was recently opened).
I'm sorry, I did not write previous note correctly, it was a bit in hurry
- I was able to write (and partially change) ac97#0-0+regs, but I wasn't
able to write via82xx.

----------------------------------------------------------------------
 tsaiming - 04-25-06 23:54 
----------------------------------------------------------------------
I have attached my diff regs (diff_via.diff, diff_ac.diff).
In via82xx I cannot restore (using echo ....) the value I had before
suspend (error is -su: /proc/asound/card0/via82xx: No such device). And
another issuse is that 04 value change during using sound device (when
speakers works), while 08 and 80 remain the same (but chance after a
suspend/resume cycle like showed in diff).
In ac97#0-0+regs I can change correctly only 60 value and no 5e.
I have compiled alsa-driver (1.0.11) with debug option.
Still only sound from headphone.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-06 13:19 tsaiming       New Issue                                    
04-15-06 13:19 tsaiming       File Added: codec97#0.txt                    
04-15-06 13:19 tsaiming       Distribution              => Gentoo          
04-15-06 13:19 tsaiming       Kernel Version            => suspend2-2.6.16-r2
04-22-06 15:12 mmp            Issue Monitored: mmp                         
04-22-06 15:14 mmp            Note Added: 0009435                          
04-22-06 15:15 mmp            File Added: regs.diff                        
04-24-06 16:44 tiwai          Note Added: 0009470                          
04-24-06 21:30 mmp            Note Added: 0009478                          
04-25-06 16:09 tiwai          Note Added: 0009491                          
04-25-06 20:37 mmp            Note Added: 0009495                          
04-25-06 23:40 tsaiming       Issue Monitored: tsaiming                    
04-25-06 23:41 tsaiming       Issue End Monitor: tsaiming                    
04-25-06 23:41 tsaiming       File Added: diff_via.diff                    
04-25-06 23:41 tsaiming       File Added: diff_ac.diff                     
04-25-06 23:54 tsaiming       Note Added: 0009497                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
