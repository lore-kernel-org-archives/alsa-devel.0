From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000885]: usx2y is unsupported in v 1.08 builds
Date: Wed, 9 Feb 2005 11:55:54 +0100
Message-ID: <85504a216462f26fbdce8ed1fd5e2379@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D3A7625E
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 11:55:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=885> 
======================================================================
Reported By:                hamishtpb
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   885
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             2.4.28-Gentoo-r5
======================================================================
Date Submitted:             02-06-2005 05:57 CET
Last Modified:              02-09-2005 11:55 CET
======================================================================
Summary:                    usx2y is unsupported in v 1.08 builds
Description: 
Whever I try to build any 1.0.8 alsa-driver I get "unsupported card error"
when I set usb-usx2y as my card. I have manually installed 1.0.7 and the
compile went smoothly.
======================================================================

----------------------------------------------------------------------
 hamishtpb - 02-06-05 15:53 
----------------------------------------------------------------------
I forgot to mention that the problem occurs with both Gentoo's own portage
builds of 1.0.8 and manually downloaded builds.

----------------------------------------------------------------------
 tiwai - 02-09-05 11:55 
----------------------------------------------------------------------
Then I suspect it's gentoo specific.
What happens if you compile all drivers without passing --with-cards=xxx?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-05 05:57 hamishtpb      New Issue                                    
02-06-05 05:57 hamishtpb      Distribution              => Gentoo 2004.3   
02-06-05 05:57 hamishtpb      Kernel Version            => 2.4.28-Gentoo-r5
02-06-05 05:57 hamishtpb      Issue Monitored: hamishtpb                    
02-06-05 15:53 hamishtpb      Note Added: 0003525                          
02-09-05 11:55 tiwai          Note Added: 0003545                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
