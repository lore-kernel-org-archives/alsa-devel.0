From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001941]: pmac_old.c does not compile
Date: Sat, 18 Mar 2006 05:49:19 +0100
Message-ID: <9bd69a47bbe4bfe513b08fb89909cbbe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDF30181
	for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2006 05:49:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1941> 
======================================================================
Reported By:                ssinger_pg
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1941
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.12
======================================================================
Date Submitted:             03-18-2006 05:49 CET
Last Modified:              03-18-2006 05:49 CET
======================================================================
Summary:                    pmac_old.c does not compile
Description: 
When compiling on a 2.6.12 kernel the powermac driver does not compile

In file included from /usr/src/modules/alsa-driver/ppc/pmac.c:6:
/usr/src/modules/alsa-driver/ppc/pmac_old.c: In function `snd_pmac_free':
/usr/src/modules/alsa-driver/ppc/pmac_old.c:827: error: structure has no
member named `of_requested'
/usr/src/modules/alsa-driver/ppc/pmac_old.c: In function `snd_pmac_new':
/usr/src/modules/alsa-driver/ppc/pmac_old.c:1207: error: structure has no
member named `of_requested'
/usr/src/modules/alsa-driver/ppc/pmac_old.c:1228: error: structure has no
member named `of_requested'

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-18-06 05:49 ssinger_pg     New Issue                                    
03-18-06 05:49 ssinger_pg     File Added: pmac_old.c.diff                    
03-18-06 05:49 ssinger_pg     Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
