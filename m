From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001033]: hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Date: Mon, 4 Apr 2005 17:09:55 +0200
Message-ID: <6dcca33a60f6fe98e07ca9d27867744a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2D3A316F
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 17:09:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1033> 
======================================================================
Reported By:                sjankie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1033
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             04-03-2005 15:07 CEST
Last Modified:              04-04-2005 17:09 CEST
======================================================================
Summary:                    hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Description: 
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

azx driver compliens about: NO AFG found.

alsmixer starts, but no sound.
======================================================================

----------------------------------------------------------------------
 1g0R - 04-04-05 17:09 
----------------------------------------------------------------------
Hi,

I have Asus p5Ad2-e Premium motherboard with intel HDA sound.
I use alsa 1.0.9rc2 with option "snd name" model=full_dig in
modprobe.conf
and its working SPDIF, and analog output.
Check your /usr/lib or /usr/local/lib alsa module files.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-05 15:07 sjankie        New Issue                                    
04-03-05 15:07 sjankie        Kernel Version            => 2.6.11.6        
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-03-05 15:08 sjankie        Issue End Monitor: sjankie                    
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-04-05 17:09 1g0R           Note Added: 0004328                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
