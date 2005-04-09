From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000448]: System hangs up
Date: Sat, 9 Apr 2005 14:23:48 +0200
Message-ID: <12a52cfc00aa39c1159bd6d4d7e0a49d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 910CB217
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 14:23:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=448> 
======================================================================
Reported By:                zadnica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   448
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-17-2004 13:02 CEST
Last Modified:              04-09-2005 14:23 CEST
======================================================================
Summary:                    System hangs up
Description: 
Systems hangs up, when modules snd-via82xx is loaded. When I using OSS
module via82cxxx_audio everything works fine.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-06-04 18:29 
----------------------------------------------------------------------
Hmm, then I'd say it's a bug of BIOS.

We can add a workaround code, of course, although it's really
ugly and I'd like to avoid it as much as possible...

----------------------------------------------------------------------
 jdthood - 04-09-05 14:23 
----------------------------------------------------------------------
sventura: Was this bug fixed or worked around in a later ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-04 13:02 zadnica        New Issue                                    
08-22-04 09:51 sventura       Note Added: 0001607                          
08-22-04 09:52 sventura       File Added: myvia82xx.tar.gz                    
08-23-04 14:59 tiwai          Note Added: 0001611                          
08-23-04 14:59 tiwai          File Added: via-crash-fix.dif                    
09-06-04 18:25 sventura       Note Added: 0001700                          
09-06-04 18:26 sventura       Note Edited: 0001700                         
09-06-04 18:27 sventura       Note Edited: 0001700                         
09-06-04 18:29 tiwai          Note Added: 0001701                          
09-06-04 18:40 sventura       File Added: via-bug448-fix.diff                   

04-09-05 14:23 jdthood        Note Added: 0004395                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
