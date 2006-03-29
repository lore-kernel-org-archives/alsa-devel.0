From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001961]: I get many warnings compiling the asihpi-driver
Date: Wed, 29 Mar 2006 19:01:28 +0200
Message-ID: <4e4c7908ea5a10e12126bfa785a6b3ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97432172
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 19:01:29 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1961> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1961
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.15-rc1-kj1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2006 21:09 CET
Last Modified:              03-29-2006 19:01 CEST
======================================================================
Summary:                    I get many warnings compiling the asihpi-driver
Description: 
My screen is flooded if I compile the asihpi-driver.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 19:01 
----------------------------------------------------------------------
The driver is most likely buggy for 64bit architecture.  I'll enable it
only for i386.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 21:09 Henne          New Issue                                    
03-24-06 21:09 Henne          File Added: asihpi-warnings.txt                   

03-24-06 21:09 Henne          Distribution              => Suse 10.0 x86_64
03-24-06 21:09 Henne          Kernel Version            => 2.6.15-rc1-kj1  
03-29-06 19:01 tiwai          Status                   assigned => resolved
03-29-06 19:01 tiwai          Resolution               open => fixed       
03-29-06 19:01 tiwai          Note Added: 0009006                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
