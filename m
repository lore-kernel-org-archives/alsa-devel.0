From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000333]: no stereo sound (nforce2)
Date: Wed, 23 Mar 2005 15:49:58 +0100
Message-ID: <2de91199d7f781850a61ab50caaadd4d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 94F2227A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:49:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=333> 
======================================================================
Reported By:                elkner
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   333
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.4.23, 2.6.6
======================================================================
Date Submitted:             06-12-2004 23:10 CEST
Last Modified:              03-23-2005 15:49 CET
======================================================================
Summary:                    no stereo sound (nforce2)
Description: 
I have a Gigabyte GA-7N400 PRO2 motherboard, which has an
Nforce2 chipset. So I trie to use 'snd-card-0 snd-intel8x0'.
The problem is - it seems to not support stereo (only the right speaker
sends out sound). So when one mutes the right
speaker/channel there is a big silence :(

I tried this with the 2.4.23 as well with the 2.6.6 kernel
both with alsa-* 0.9.1 and 1.0.4rc2 (which comes with the 2.6 kernel). 
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 15:49 
----------------------------------------------------------------------
Any improvement in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-04 23:10 elkner         New Issue                                    
06-12-04 23:10 elkner         Distribution              => Slackware       
06-12-04 23:10 elkner         Kernel Version            => 2.4.23, 2.6.6   
03-23-05 15:49 jdthood        Note Added: 0004167                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
