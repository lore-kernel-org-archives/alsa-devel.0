From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000403]: intel8x0 driver swaps channels
Date: Tue, 22 Mar 2005 22:30:31 +0100
Message-ID: <84c5deb4577ffabb7f9c5bf71ef67aff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D6D03212
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:30:31 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0000949.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=403> 
======================================================================
Reported By:                phox
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   403
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.7-gentoo-r11
======================================================================
Date Submitted:             07-22-2004 22:27 CEST
Last Modified:              03-22-2005 22:30 CET
======================================================================
Summary:                    intel8x0 driver swaps channels
Description: 
While using this driver rather successfully with my AD1981B codec/AMD8111
'southbridge', I have been experiencing random channel swaps at the start
of a PCM audio stream (usually using ALSA directly but recently this
happened with Quake 3 + OSS, unless Q3 suddenly has ALSA support that I
don't know about).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000949 Randomly, left and right tracks are swaped
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-04 22:27 phox           New Issue                                    
07-22-04 22:27 phox           Distribution              => Gentoo          
07-22-04 22:27 phox           Kernel Version            => 2.6.7-gentoo-r11
07-22-04 22:54 eradicator     Issue Monitored: eradicator                    
03-04-05 19:30 NorbertB       Issue Monitored: NorbertB                    
03-22-05 22:30 jdthood        Relationship added       duplicate of 0000949
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
