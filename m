From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000654]: After compiling the module wont load.
Date: Thu, 18 Nov 2004 19:42:16 +0100
Message-ID: <86edc17f5f5125e1e2b10fbc8148d38b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AA0131ED
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 19:42:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=654> 
======================================================================
Reported By:                henkie_
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   654
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               SuSE 9.0
Kernel Version:             (stock kernel) 2.4.26
======================================================================
Date Submitted:             11-18-2004 19:20 CET
Last Modified:              11-18-2004 19:42 CET
======================================================================
Summary:                    After compiling the module wont load.
Description: 
# modprobe snd
/lib/modules/2.4.26/kernel/sound/acore/snd.o: unresolved symbol
snd_compat_strlcpy
/lib/modules/2.4.26/kernel/sound/acore/snd.o: insmod
/lib/modules/2.4.26/kernel/sound/acore/snd.o failed
/lib/modules/2.4.26/kernel/sound/acore/snd.o: insmod snd failed

Compiling does succeed, so not sure if it is a compile error
======================================================================

----------------------------------------------------------------------
 tiwai - 11-18-04 19:42 
----------------------------------------------------------------------
Unload snd-page-alloc once.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 19:20 henkie_        New Issue                                    
11-18-04 19:20 henkie_        Distribution              => SuSE 9.0        
11-18-04 19:20 henkie_        Kernel Version            => (stock kernel) 2.4.26
11-18-04 19:42 tiwai          Note Added: 0002464                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
