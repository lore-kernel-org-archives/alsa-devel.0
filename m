From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001934]: make problem
Date: Fri, 17 Mar 2006 12:19:50 +0100
Message-ID: <9f127bbf6d3bf9c13dd882d9b754010f@85.132.177.35>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from 85.132.177.35 (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0434A1C0
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 12:19:50 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://85.132.177.35/alsa-bug/view.php?id=1934> 
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
Last Modified:              03-17-2006 12:19 CET
======================================================================
Summary:                    make problem
Description: 
./configure works OK. running make give error during compilation: module
'include/asound.h' (line 210) has some 'typedef' that doesn't match with
(probably) OS include. As a result, compilation stops and driver can not
be produced.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 12:19 kvo            New Issue                                    
03-17-06 12:19 kvo            Distribution              => RHEL4 Update 3  
03-17-06 12:19 kvo            Kernel Version            => 2.6.9-34.EL     
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
