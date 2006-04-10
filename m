From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001934]: make problem
Date: Mon, 10 Apr 2006 16:46:12 +0200
Message-ID: <283cb72d8b36114ed5fd1c8f7f38a4ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A914E184
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 16:46:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1934> 
======================================================================
Reported By:                kvo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1934
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               RHEL4 Update 3
Kernel Version:             2.6.9-34.EL
======================================================================
Date Submitted:             03-17-2006 12:19 CET
Last Modified:              04-10-2006 16:46 CEST
======================================================================
Summary:                    make problem
Description: 
./configure works OK. running make give error during compilation: module
'include/asound.h' (line 210) has some 'typedef' that doesn't match with
(probably) OS include. As a result, compilation stops and driver can not
be produced.
======================================================================

----------------------------------------------------------------------
 kvo - 04-09-06 19:05 
----------------------------------------------------------------------
Please look at new info and possible reason.

----------------------------------------------------------------------
 tiwai - 04-10-06 16:46 
----------------------------------------------------------------------
Sigh, it's a modified kernel by RedHat that not supported officially by
alsa package.
I don't know how to detect it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 12:19 kvo            New Issue                                    
03-17-06 12:19 kvo            Distribution              => RHEL4 Update 3  
03-17-06 12:19 kvo            Kernel Version            => 2.6.9-34.EL     
03-17-06 12:25 tiwai          Note Added: 0008643                          
03-19-06 22:26 kvo            Note Added: 0008697                          
03-21-06 17:33 tiwai          Note Added: 0008749                          
03-25-06 20:47 kvo            File Added: config.log                       
03-25-06 22:19 kvo            Note Added: 0008952                          
04-09-06 18:47 kvo            File Added: info.zip                         
04-09-06 18:56 kvo            Note Added: 0009181                          
04-09-06 19:05 kvo            Issue Monitored: tiwai                       
04-09-06 19:05 kvo            Note Added: 0009182                          
04-10-06 16:46 tiwai          Note Added: 0009196                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
