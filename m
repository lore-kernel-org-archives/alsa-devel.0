From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000678]: Fail to compile driver
Date: Mon, 27 Dec 2004 15:51:02 +0100
Message-ID: <591b09e5db1ccaafa44d2022fd6603f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9460522B
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:51:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=678> 
======================================================================
Reported By:                josephtyson
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   678
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               driver 1.0.7
Kernel Version:             2.4.20
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-25-2004 08:46 CET
Last Modified:              12-27-2004 15:51 CET
======================================================================
Summary:                    Fail to compile driver
Description: 
Several error messages are reported when running make:

"make[3]: Entering directory
`/home/josephlei/ALSA_DRV/alsa-driver-1.0.7/pcmcia/pdaudiocf'
/home/josephlei/ALSA_DRV/alsa-driver-1.0.7/include/sndversions.h was
updated
copying file alsa-kernel/pcmcia/pdaudiocf/pdaudiocf.c
patching file pdaudiocf.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 succeeded at 29
with fuzz 1.
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 FAILED at 62.
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 succeeded at 80
(offset -4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6 succeeded at 279
(offset -7 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8 succeeded at 448
(offset -7 lines).
1 out of 8 hunks FAILED -- saving rejects to file pdaudiocf.c.rej
make[3]: *** [pdaudiocf.c] Error 1
make[3]: Leaving directory
`/home/josephlei/ALSA_DRV/alsa-driver-1.0.7/pcmcia/pdaudiocf'
make[2]: *** [_sfdep_pdaudiocf] Error 2
make[2]: Leaving directory
`/home/josephlei/ALSA_DRV/alsa-driver-1.0.7/pcmcia'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/josephlei/ALSA_DRV/alsa-driver-1.0.7'
make: *** [include/sndversions.h] Error 2

======================================================================

----------------------------------------------------------------------
 tiwai - 11-25-04 15:52 
----------------------------------------------------------------------
Already fixed in the CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-25-04 08:46 josephtyson    New Issue                                    
11-25-04 08:46 josephtyson    File Added: make.log                         
11-25-04 08:46 josephtyson    Distribution              => driver 1.0.7    
11-25-04 08:46 josephtyson    Kernel Version            => 2.4.20          
11-25-04 15:52 tiwai          Status                   assigned => resolved
11-25-04 15:52 tiwai          Resolution               open => fixed       
11-25-04 15:52 tiwai          Note Added: 0002591                          
12-27-04 15:51 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
