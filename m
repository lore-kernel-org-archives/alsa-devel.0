From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000804]: asoundlib.h doesn't #include time.h, which is needed for struct timespec
Date: Mon, 14 Feb 2005 19:31:16 +0100
Message-ID: <97e8abb13311fe5b48cf2e927e8d42a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D487A248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:31:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=804> 
======================================================================
Reported By:                yosh
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   804
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-10-2005 22:39 CET
Last Modified:              02-14-2005 19:31 CET
======================================================================
Summary:                    asoundlib.h doesn't #include time.h, which is needed
for struct timespec
Description: 
http://bugzilla.gnome.org/show_bug.cgi?id=163593

This was a build failure from including asoundlib.h, and struct timespec
wasn't defined, which is needed for the snd_htimestamp_t typedef. Simple
fix is to add an #include <time.h> in asoundlib.h.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-11-05 16:19 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 22:39 yosh           New Issue                                    
01-11-05 16:19 tiwai          Status                   new => resolved     
01-11-05 16:19 tiwai          Resolution               open => fixed       
01-11-05 16:19 tiwai          Assigned To               => tiwai           
01-11-05 16:19 tiwai          Note Added: 0003153                          
01-11-05 16:19 tiwai          Assigned To              tiwai =>            
02-14-05 19:31 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
