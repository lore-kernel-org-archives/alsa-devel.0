From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001503]: snd_intel8x0 don't work
Date: Wed, 26 Oct 2005 12:57:44 +0200
Message-ID: <a23cd2de17961d71334edeea401cac8d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07FF9165
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 12:57:45 +0200 (MEST)
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
Last Modified:              10-26-2005 12:57 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 19:43 Trojanets      New Issue                                    
10-25-05 19:43 Trojanets      Kernel Version            => 2.6.13-fc4      
10-26-05 12:57 tiwai          Note Added: 0006555                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
