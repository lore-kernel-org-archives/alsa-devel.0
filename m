From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000336]: No sound playing
Date: Wed, 23 Mar 2005 15:50:42 +0100
Message-ID: <e3cad584a6255ee1618dcfb0f801ff8b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0289927A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:50:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=336> 
======================================================================
Reported By:                davidgvh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   336
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.4.27-pre5
Resolution:                 not fixable
Fixed in Version:           
======================================================================
Date Submitted:             06-16-2004 14:03 CEST
Last Modified:              03-23-2005 15:50 CET
======================================================================
Summary:                    No sound playing
Description: 
I cannot get sound to work. After probing snd-card-0, I cannot change the
volume for the PCM channel in alsamixer.
======================================================================

----------------------------------------------------------------------
 davidgvh - 06-22-04 02:40 
----------------------------------------------------------------------
Sound plays under 2.4.27-rc1. Did not play before. Thinking the problem is
a kernel issue. However, the kernel has timing issues. Everything is 2-3
times faster. Sound plays at correct rate though. Still cannot change PCM
volume in alsamixer though.

edited on: 06-22-04 02:40

----------------------------------------------------------------------
 tiwai - 06-30-04 15:51 
----------------------------------------------------------------------
The codec doesn't support PCM volume indeed.  It's not a bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-04 14:03 davidgvh       New Issue                                    
06-16-04 14:03 davidgvh       File Added: ac97#0-0+regs                    
06-16-04 14:03 davidgvh       Distribution              => Fedora Core 2   
06-16-04 14:03 davidgvh       Kernel Version            => 2.4.27-pre5     
06-16-04 14:04 davidgvh       File Added: ac97#0-0                         
06-16-04 14:06 davidgvh       Note Added: 0001312                          
06-17-04 00:28 davidgvh       Note Added: 0001313                          
06-22-04 02:37 davidgvh       Note Edited: 0001312                         
06-22-04 02:38 davidgvh       Note Edited: 0001312                         
06-22-04 02:39 davidgvh       Note Added: 0001327                          
06-22-04 02:40 davidgvh       Note Edited: 0001327                         
06-30-04 15:51 tiwai          Note Added: 0001353                          
03-23-05 15:50 jdthood        Status                   new => resolved     
03-23-05 15:50 jdthood        Resolution               open => not fixable 
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
