From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000319]: Cannot control main volume independently for left and right channels
Date: Wed, 23 Mar 2005 15:28:31 +0100
Message-ID: <5824549f30b9d166e4cdeb8668bd3887@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4254A26B
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:28:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=319> 
======================================================================
Reported By:                walrus121
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   319
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 1
Kernel Version:             2.4.26-1.ll.rhfc1.ccrma (from Planet CCRMA)
======================================================================
Date Submitted:             05-31-2004 17:46 CEST
Last Modified:              03-23-2005 15:28 CET
======================================================================
Summary:                    Cannot control main volume independently for left
and right channels
Description: 
I have tried with numerous volume control programs, and I get the same
result.  If I try to adjust one channel, the values of the two channels
are averaged in some strange way and are rebalanced to the center.  I know
that this must be a driver-specific issue because I can control the two
channels independently for my Sound Blaster AWE 64 Value card, also in my
computer, and because it doesn't seem to matter which mixer I use.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-17-04 19:22 
----------------------------------------------------------------------
Can you verify the bug with the latest ALSA version. 1.0.7?

----------------------------------------------------------------------
 jdthood - 03-23-05 15:28 
----------------------------------------------------------------------
Submitter: Can you verify the bug still exists in the latest ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 17:46 walrus121      New Issue                                    
05-31-04 17:46 walrus121      File Added: modules.conf                     
05-31-04 17:46 walrus121      Distribution              => Fedora Core 1   
05-31-04 17:46 walrus121      Kernel Version            =>
2.4.26-1.ll.rhfc1.ccrma (from Planet CCRMA)
11-17-04 19:22 rlrevell       Note Added: 0002441                          
03-23-05 15:28 jdthood        Note Added: 0004160                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
