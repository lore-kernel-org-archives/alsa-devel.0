From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000936]: AM_PATH_ALSA does not set prefix properly
Date: Wed, 23 Feb 2005 22:39:35 +0100
Message-ID: <e17606b7fcf7f4daf30262f32ec071da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 94369204
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 22:39:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=936> 
======================================================================
Reported By:                starling
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   936
Category:                   aconnect
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-23-2005 22:39 CET
Last Modified:              02-23-2005 22:39 CET
======================================================================
Summary:                    AM_PATH_ALSA does not set prefix properly
Description: 
When configure calls AM_PATH_ALSA, it wrongly assumes that
--with-alsa-prefix specifies the location of the library, not the prefix
of alsa.  In addition, --with-alsa-inc-prefix does not properly modify
CFLAGS.  The result is that every configure where alsa-lib is installed
outside the hardcoded include/lib paths fails unconditionally.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-05 22:39 starling       New Issue                                    
02-23-05 22:39 starling       File Added: alsa.diff                        
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
