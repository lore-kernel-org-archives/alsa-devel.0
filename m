From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001015]: Static when not playing through the OSS Emulation
Date: Sat, 26 Mar 2005 00:09:51 +0100
Message-ID: <243067549bfb504c5fe3e2811b6eaaa4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A79871F1
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2005 00:09:51 +0100 (MET)
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
Last Modified:              03-26-2005 00:09 CET
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
 daspooky - 03-25-05 14:58 
----------------------------------------------------------------------
I have the same problem, I posted issue 0000996 concerning this problem. I
only get noise/static when enabling dmix. My chipset is a c-media CMI8738.



----------------------------------------------------------------------
 wintermute77 - 03-26-05 00:09 
----------------------------------------------------------------------
I'm not sure how to disable dmix explicitly...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 04:00 wintermute77   New Issue                                    
03-25-05 04:00 wintermute77   Distribution              => Gentoo          
03-25-05 04:00 wintermute77   Kernel Version            =>  2.6.10-ck5     
03-25-05 14:57 daspooky       Note Added: 0004207                          
03-25-05 14:58 daspooky       Note Edited: 0004207                         
03-26-05 00:09 wintermute77   Note Added: 0004214                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
