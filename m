From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001323]: MIC jack not supported
Date: Thu, 15 Sep 2005 06:44:58 +0200
Message-ID: <c4cbf7a4f61ce9638249541be2cf5b99@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C921016A
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 06:44:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1323> 
======================================================================
Reported By:                submax82
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1323
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               debian 3.1 sarge
Kernel Version:             linux 2.6.12.4
======================================================================
Date Submitted:             08-08-2005 22:10 CEST
Last Modified:              09-15-2005 06:44 CEST
======================================================================
Summary:                    MIC jack not supported
Description: 
The problem is simple but important! The alsamixer do not show the volume
of the MIC therefore this do not work!
======================================================================

----------------------------------------------------------------------
 jcdutton - 09-10-05 10:39 
----------------------------------------------------------------------
the snd-ca0106 does not yet have a capture volume. It is hardcoded at 0dB
attenuation at the moment, which basically means, almost at max volume.

Please post the output of steps 1 to 4 of
http://alsa.opensrc.org/TroubleShooting.

----------------------------------------------------------------------
 qqtortqq - 09-15-05 06:44 
----------------------------------------------------------------------
1) Check that the ALSA drivers are compiled as modules

Check

2) Check the ALSA driver version

Advanced Linux Sound Architecture Driver Version 1.0.10rc1.
Compiled on Sep 14 2005 for kernel 2.6.12.2.

3) Check the ALSA library version

#define SND_LIB_VERSION_STR     "1.0.10rc1"

4) Check the sound drivers for your card are active

They are.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 22:10 submax82       New Issue                                    
08-08-05 22:10 submax82       Distribution              => debian 3.1 sarge
08-08-05 22:10 submax82       Kernel Version            => linux 2.6.12.4  
08-08-05 22:59 submax82       Issue Monitored: submax82                    
08-08-05 23:00 submax82       Note Added: 0005714                          
08-10-05 05:21 rlrevell       Note Added: 0005746                          
08-12-05 23:09 jcdutton       Note Added: 0005790                          
08-12-05 23:09 jcdutton       Status                   assigned => feedback
08-13-05 14:28 submax82       Note Added: 0005804                          
08-13-05 14:33 submax82       Issue End Monitor: submax82                    
08-17-05 17:02 submax82       Note Added: 0005839                          
09-10-05 10:39 jcdutton       Note Added: 0006109                          
09-15-05 06:44 qqtortqq       Note Added: 0006194                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
