From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001503]: snd_intel8x0 don't work
Date: Mon, 31 Oct 2005 07:49:07 +0100
Message-ID: <615363dd05ead20784af5dece81a22a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF3871A0
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 07:49:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1503> 
======================================================================
Reported By:                Trojanets
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1503
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13-fc4
======================================================================
Date Submitted:             10-25-2005 19:43 CEST
Last Modified:              10-31-2005 07:49 CET
======================================================================
Summary:                    snd_intel8x0 don't work
Description: 
modprobe snd_intel8x0 :
sh: -c: line 0: syntax error near unexpected taken '&'
sh: -c: line 0: /sbin/modeprobe --ignore-install snd-intel8x0 && 
/usr/sbin/alsactrl restore > /dev/nul 2 > &1
FATAL: Error running install command for snd_intel8x0

======================================================================

----------------------------------------------------------------------
 tiwai - 10-26-05 12:57 
----------------------------------------------------------------------
It's the problem of your module configuration.

----------------------------------------------------------------------
 Trojanets - 10-31-05 07:49 
----------------------------------------------------------------------
The problem is:

I didn't do nothing only update kernel from 2.6.11 (Sound Card work
properly) to 2.6.13-1FC4-1532 (Sound Card not work, aRTS say " No such
device /dev/dsp")

How solve this problem ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 19:43 Trojanets      New Issue                                    
10-25-05 19:43 Trojanets      Kernel Version            => 2.6.13-fc4      
10-26-05 12:57 tiwai          Note Added: 0006555                          
10-26-05 21:55 xblahallo      Issue Monitored: xblahallo                    
10-26-05 21:55 xblahallo      Issue End Monitor: xblahallo                    
10-31-05 07:49 Trojanets      Note Added: 0006583                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
