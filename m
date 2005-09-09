From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001337]: AWE 32/64 driver crashes when using the skype program.
Date: Fri, 9 Sep 2005 02:42:16 +0200
Message-ID: <e59b51faf7052e2ee60753be1ed02cc0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDA7DE0
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 02:42:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1337> 
======================================================================
Reported By:                philneves
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1337
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Slackware 10, and Redhat 7.3
Kernel Version:             2.4 series.
======================================================================
Date Submitted:             08-15-2005 03:20 CEST
Last Modified:              09-09-2005 02:42 CEST
======================================================================
Summary:                    AWE 32/64 driver crashes when using the skype
program.
Description: 
This is a serious bug with the sb16/sbawe driver. It seems to crash when
running the skype program. Problem can be reproduced on a regular basis.
Although frequency of occurence is random. Once the driver crashes it
disables all sound on my system and I must restart the computer to get the
sound back. Reloading the driver doesn't work. Problem occurs on all
versions of alsa and all versions of the 2.4 kernel. 





======================================================================

----------------------------------------------------------------------
 philneves - 09-09-05 02:34 
----------------------------------------------------------------------
Problem occures in all versions of linux. Even 2.6. It took me a couple of
hours running skype but it finally crashed.

Once the initial crash happens the program crashes the driver more
frequently. Only a restart to the computer will get the sound back. No
other program requiring sound can access the sound system after the crash.
 

I've not been able to find any kernel logs that will highlight the problem
in 2.6.   

I've tried removing the lock files from the .Skype directory but it
doesn't seem to have any effect. I've also tried unloading the sound
driver and reloading it. No effect. The sound system won't start until I
restart the computer.



----------------------------------------------------------------------
 philneves - 09-09-05 02:42 
----------------------------------------------------------------------
Additional information about my system so that I can make the debugging
easier. I have a 

Celeron 400mhz. (please no comments on how bad my computer sucks I already
know. )
300MB of ram. 
20GB hard disk space (only half full)
P2-99 Motherboard (this MB has 2 ISA slots)
SBAwe 64 (ISA)
Nvidia Geforce 2 video card. 
10/100 Ethernet card. 

Currently I'm using the alsa drivers that are located in Linux Kernel
2.6.11 

I'm thinking this is a problem with the OSS emulation in ALSA. I've had
trouble with it before. Its never been 100% for me. Not even the earlier
versions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-05 03:20 philneves      New Issue                                    
08-15-05 03:20 philneves      Distribution              => Slackware 10, and
Redhat 7.3
08-15-05 03:20 philneves      Kernel Version            => 2.4 series.     
08-24-05 07:09 philneves      Note Added: 0005924                          
09-09-05 02:34 philneves      Note Edited: 0005924                         
09-09-05 02:42 philneves      Note Added: 0006086                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
