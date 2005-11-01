From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001503]: snd_intel8x0 don't work
Date: Tue, 1 Nov 2005 15:34:21 +0100
Message-ID: <838edbd6a750af21bfb2d6f6db4334c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82573156
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:34:21 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             2.6.13-fc4
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-25-2005 19:43 CEST
Last Modified:              11-01-2005 15:34 CET
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
 Trojanets - 10-31-05 07:52 
----------------------------------------------------------------------
The problem is:

I didn't do nothing only update kernel from 2.6.11 (Sound Card work
properly) to 2.6.13-1FC4-1532 (Sound Card not work, aRTS say " No such
device /dev/dsp")

How solve this problem ?

----------------------------------------------------------------------
 jdthood - 11-01-05 15:34 
----------------------------------------------------------------------
>  The problem is:
>  I didn't do nothing only update kernel from 2.6.11 (Sound Card work
properly)
> to 2.6.13-1FC4-1532 (Sound Card not work, aRTS say " No such device
/dev/dsp")
> How solve this problem ?

Please file a bug report with your GNU/Linux distributor.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 19:43 Trojanets      New Issue                                    
10-25-05 19:43 Trojanets      Kernel Version            => 2.6.13-fc4      
10-26-05 12:57 tiwai          Note Added: 0006555                          
10-26-05 21:55 xblahallo      Issue Monitored: xblahallo                    
10-26-05 21:55 xblahallo      Issue End Monitor: xblahallo                    
10-31-05 07:49 Trojanets      Note Added: 0006583                          
10-31-05 07:52 Trojanets      Note Added: 0006584                          
11-01-05 15:34 jdthood        Note Added: 0006593                          
11-01-05 15:34 jdthood        Status                   new => closed       
11-01-05 15:34 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
