From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000520]: [PATCH] 91_debian_alsaconf_noclear
Date: Fri, 18 Feb 2005 22:03:00 +0100
Message-ID: <4176df0689a1415d42aca862244d9328@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 714FC242
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2005 22:03:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=520> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   520
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-21-2004 20:03 CEST
Last Modified:              02-18-2005 22:02 CET
======================================================================
Summary:                    [PATCH] 91_debian_alsaconf_noclear
Description: 
This is a patch for alsaconf which makes it not clear the
screen, but print a newline instead.  The advantage is that
error messages are not cleared.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-04 13:02 
----------------------------------------------------------------------
Overriding clear for all places is not a good idea.
If clear isn't appropriate in some places, let's remove them
instead of killing clear globally.

----------------------------------------------------------------------
 jdthood - 02-18-05 22:02 
----------------------------------------------------------------------
This report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 20:03 jdthood        New Issue                                    
09-21-04 20:03 jdthood        File Added: 91_debian_alsaconf_noclear.dpatch     
              
09-22-04 18:24 tiwai          Note Added: 0001816                          
09-22-04 22:37 jdthood        Note Added: 0001820                          
09-23-04 13:02 tiwai          Note Added: 0001823                          
02-18-05 22:02 jdthood        Note Added: 0003665                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
