From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000654]: After compiling the module wont load.
Date: Mon, 22 Nov 2004 14:43:07 +0100
Message-ID: <782343e35ab0e7e1d262302640c74ee4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1820B2B3
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 14:43:08 +0100 (MET)
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
Status:                     resolved
Distribution:               SuSE 9.0
Kernel Version:             (stock kernel) 2.4.26
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-18-2004 19:20 CET
Last Modified:              11-22-2004 14:43 CET
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
 henkie_ - 11-18-04 20:44 
----------------------------------------------------------------------
Works  :)

Thnx for the fast reply!

----------------------------------------------------------------------
 tiwai - 11-22-04 14:43 
----------------------------------------------------------------------
Closed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-04 19:20 henkie_        New Issue                                    
11-18-04 19:20 henkie_        Distribution              => SuSE 9.0        
11-18-04 19:20 henkie_        Kernel Version            => (stock kernel) 2.4.26
11-18-04 19:42 tiwai          Note Added: 0002464                          
11-18-04 20:44 henkie_        Note Added: 0002470                          
11-22-04 14:43 tiwai          Status                   assigned => resolved
11-22-04 14:43 tiwai          Resolution               open => not an issue
11-22-04 14:43 tiwai          Note Added: 0002503                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
