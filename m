From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000620]: Pb with chorus and reverb gestion
Date: Tue, 16 Nov 2004 16:42:26 +0100
Message-ID: <48d8381b2957dfc0f735bd581df94b6a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 236B01C2
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2004 16:42:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=620> 
======================================================================
Reported By:                hg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   620
Category:                   CORE - sequencer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-31-2004 12:25 CET
Last Modified:              11-16-2004 16:42 CET
======================================================================
Summary:                    Pb with chorus and reverb gestion
Description: 
Pb with chorus and reverb gestion with driver as emu8000
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 19:00 
----------------------------------------------------------------------
The patch looks fine.
Please create a patch file with a summary and a signed-off-by lines to
apply to CVS.


Thanks.

----------------------------------------------------------------------
 tiwai - 11-16-04 16:42 
----------------------------------------------------------------------
Oops, the patch is NOT correct.  30 = reverb and 38 = chorus in fact.

Fixed on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-04 12:25 hg             New Issue                                    
11-09-04 19:00 tiwai          Note Added: 0002339                          
11-16-04 16:42 tiwai          Status                   new => resolved     
11-16-04 16:42 tiwai          Resolution               open => fixed       
11-16-04 16:42 tiwai          Assigned To               => tiwai           
11-16-04 16:42 tiwai          Note Added: 0002427                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
