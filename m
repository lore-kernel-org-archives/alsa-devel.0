From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001015]: Static when not playing through the OSS Emulation
Date: Fri, 25 Mar 2005 14:57:45 +0100
Message-ID: <a3a3ac2809594652e07753907e5cd5da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 539131AD
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2005 14:57:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1015> 
======================================================================
Reported By:                wintermute77
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1015
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:              2.6.10-ck5
======================================================================
Date Submitted:             03-25-2005 04:00 CET
Last Modified:              03-25-2005 14:57 CET
======================================================================
Summary:                    Static when not playing through the OSS Emulation
Description: 
I get crackling static coming in when sound is being output to my speakers
(not when there is nothing playing) using the ice1724 driver with my
M-Audio Revolution 7.2.  The problem appears to go away if I use OSS
emulation, but of course this isn't desirable since I cannot use dmix in
this case.

I am using xmms and mplayer to produce the badness.
======================================================================

----------------------------------------------------------------------
 daspooky - 03-25-05 14:57 
----------------------------------------------------------------------
I have the same problem, i posted issue 0000996 concerning this problem. I
only get noise/static when enabling dmix.My chipset is a c-media CMI8738.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 04:00 wintermute77   New Issue                                    
03-25-05 04:00 wintermute77   Distribution              => Gentoo          
03-25-05 04:00 wintermute77   Kernel Version            =>  2.6.10-ck5     
03-25-05 14:57 daspooky       Note Added: 0004207                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
