From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000998]: access to second playback hangs
Date: Sat, 19 Mar 2005 00:16:57 +0100
Message-ID: <196bd9eab0987ce87ea26b19741f5754@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BBEF222D
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 00:16:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=998> 
======================================================================
Reported By:                allefant
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   998
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-6
======================================================================
Date Submitted:             03-19-2005 00:16 CET
Last Modified:              03-19-2005 00:16 CET
======================================================================
Summary:                    access to second playback hangs
Description: 
This is haunting my since about half a year, since I got this card. Every
time the second playback device is accessed, there's a complete hardware
freeze. Disabling the second playback device makes it work. I know, this
isn't the best report, since I didn't compile the latest version and did
not much testing (no fun getting constant HW freezes) - but anyway, I
thought I report it here, maybe my workaround can help someone who googles
for this problems at least (or, maybe someone can give me even a hint how
to fix it).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 00:16 allefant       New Issue                                    
03-19-05 00:16 allefant       Distribution              => Debian sid      
03-19-05 00:16 allefant       Kernel Version            => 2.6.10-6        
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
