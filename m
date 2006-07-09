From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001820]: Noise scramble when playing
	any sound
Date: Sun, 9 Jul 2006 11:43:22 +0200
Message-ID: <48520beecca0bdedc46f60930048401e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3096B257
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 11:43:23 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1820> 
======================================================================
Reported By:                eIf
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1820
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Linux
Kernel Version:             Linux 2.6.14-1.1656_FC4 #1 Thu Jan 5 22:13:22 EST
2006
======================================================================
Date Submitted:             02-04-2006 22:58 CET
Last Modified:              07-09-2006 11:43 CEST
======================================================================
Summary:                    Noise scramble when playing any sound
Description: 
Each time I play a sound, even using "system-config-soundcard", I hear an
annoying noise that interfers with the expected playing sound. As a
particular aspect, if I try to low down the sound from the top-right
Volume Control icon, I won't be able to hear any sound until the next
restart of the PC.

======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-09-06 11:43 
----------------------------------------------------------------------
This might be fixed by a fix in ALSA 1.0.11.

Can you still reproduce it with ALSA 1.0.11?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-04-06 22:58 eIf            New Issue                                    
02-04-06 22:58 eIf            Distribution              => Linux           
02-04-06 22:58 eIf            Kernel Version            => Linux
2.6.14-1.1656_FC4 #1 Thu Jan 5 22:13:22 EST 2006
02-04-06 23:20 eIf            Issue Monitored: eIf                         
07-09-06 11:43 Adrian Bunk    Note Added: 0010944                          
07-09-06 11:43 Adrian Bunk    Category                 1_OTHERS => PCI -
hda-intel
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
