From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000973]: Errors in headers
Date: Tue, 8 Mar 2005 03:08:33 +0100
Message-ID: <3c8366cde541977df7045946750b57c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2EA951B7
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2005 03:08:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=973> 
======================================================================
Reported By:                subbia
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   973
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Hoary
Kernel Version:             2.6.10
======================================================================
Date Submitted:             03-08-2005 03:08 CET
Last Modified:              03-08-2005 03:08 CET
======================================================================
Summary:                    Errors in headers
Description: 
I've tried to make alsa driver, but errors during compiling comes out.

1)on file core.h (sound_core)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=166 error on free_workq:
incomplete
statemente 

2)on file aio.h (kernel/include/linux)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=151 same of above

p.s.: I've bypassed the first errore 'cause i'm thinking free_workq is a
pointer, but in the second error don't goes this solution, so.....I don't
know
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 03:08 subbia         New Issue                                    
03-08-05 03:08 subbia         Distribution              => Ubuntu Hoary    
03-08-05 03:08 subbia         Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
