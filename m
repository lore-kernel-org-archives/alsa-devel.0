From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001121]: Very low volume through SPDIF (no master volume?)
Date: Sun, 23 Oct 2005 19:48:05 +0200
Message-ID: <34946f1944057627d8275bd04c48b8da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA0E0144
	for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2005 19:48:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1121> 
======================================================================
Reported By:                dacid
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1121
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo (vanilla kernel)
Kernel Version:             2.6.12-rc4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-21-2005 03:21 CEST
Last Modified:              10-23-2005 19:48 CEST
======================================================================
Summary:                    Very low volume through SPDIF (no master volume?)
Description: 
Hello - 
   I've been trying for a few weeks now to get SPDIF out working on my
Soundblaster 24bit card working.
   The issue is that the output to my receiver is very low, if I crank it
way up (-8db), I can hear some audio, but it is very muffled and
distored.
   I've tried various setting combinations in alsamixer, to no avail.
   I'm also a little curious as to why this soundcard has no master volume
or PCM controls.

======================================================================

----------------------------------------------------------------------
 jcdutton - 09-10-05 13:21 
----------------------------------------------------------------------
Please try the trouble shooter at: http://alsa.opensrc.org/TroubleShooting

The post the output of steps 1,2,3,4 here.
And also the output of:
amixer contents

----------------------------------------------------------------------
 jcdutton - 10-23-05 19:48 
----------------------------------------------------------------------
Closed due to lack of feedback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-21-05 03:21 dacid          New Issue                                    
05-21-05 03:21 dacid          Distribution              => Gentoo (vanilla
kernel)
05-21-05 03:21 dacid          Kernel Version            => 2.6.12-rc4      
05-24-05 01:54 dacid          Issue Monitored: dacid                       
05-28-05 12:13 jcdutton       Note Added: 0004763                          
05-28-05 12:30 jcdutton       Note Added: 0004772                          
05-28-05 12:30 jcdutton       Status                   assigned => feedback
05-29-05 03:27 dacid          Note Added: 0004778                          
05-29-05 12:23 jcdutton       Note Added: 0004783                          
05-30-05 15:35 dacid          Note Added: 0004819                          
09-10-05 13:21 jcdutton       Note Added: 0006121                          
10-23-05 19:48 jcdutton       Status                   feedback => closed  
10-23-05 19:48 jcdutton       Note Added: 0006517                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
