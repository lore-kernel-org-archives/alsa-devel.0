From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000993]: Please provide asound_fm.h
Date: Wed, 16 Mar 2005 12:41:29 +0100
Message-ID: <785d8a99291518fc4aa42e590d3952c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 71103226
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 12:41:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=993> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   993
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-14-2005 22:28 CET
Last Modified:              03-16-2005 12:41 CET
======================================================================
Summary:                    Please provide asound_fm.h
Description: 
The submitter of Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=299423 says:

> Please include the header asound_fm.h  This is required to use the
> OSS compatibility Direct-FM interface (or ALSA DMFM device directly via
> ioctls, as opposed to using through alsa-lib as normal).

See http://bugs.debian.org/299423 for the full request.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-15-05 22:51 
----------------------------------------------------------------------
Here is the manual page which mentions that header:
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1192.htm

----------------------------------------------------------------------
 tiwai - 03-16-05 12:41 
----------------------------------------------------------------------
Fixed on CVS.  Will appear in rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 22:28 jdthood        New Issue                                    
03-15-05 22:51 jdthood        Note Added: 0003920                          
03-16-05 12:41 tiwai          Status                   new => resolved     
03-16-05 12:41 tiwai          Resolution               open => fixed       
03-16-05 12:41 tiwai          Assigned To               => tiwai           
03-16-05 12:41 tiwai          Note Added: 0003944                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
