From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000984]: No Sound
Date: Wed, 23 Mar 2005 16:02:35 +0100
Message-ID: <0b5eafd80a660cdc8ecca99f944fe482@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1734027A
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 16:02:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=984> 
======================================================================
Reported By:                mailavj
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   984
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.7-2
======================================================================
Date Submitted:             03-12-2005 19:09 CET
Last Modified:              03-23-2005 16:02 CET
======================================================================
Summary:                    No Sound
Description: 
my sound card is Sound MAX integrated Audio with Intel D865 GBF
motherboard..
i'm not getting sound output..
kernel version is 2.6.7-2 and my alsa driver version is 1.0.6-a
Is there any way to get sound out put on this card using this driver.. 
please help

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000970 No Sound
======================================================================

----------------------------------------------------------------------
 tiwai - 03-18-05 18:14 
----------------------------------------------------------------------
Apart from that the system is old -- you should check the mixer
configuration at first.

----------------------------------------------------------------------
 jdthood - 03-23-05 16:02 
----------------------------------------------------------------------
Please send the output of 

   lsmod
   uname -a
   lspci
   cat /proc/asound/version
   cat /proc/asound/cards

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 19:09 mailavj        New Issue                                    
03-16-05 13:00 tiwai          Note Added: 0003952                          
03-16-05 14:56 tiwai          Relationship added       duplicate of 0000970
03-16-05 14:56 tiwai          Duplicate ID             0 => 970            
03-16-05 14:56 tiwai          Status                   new => resolved     
03-16-05 14:56 tiwai          Resolution               open => duplicate   
03-16-05 14:56 tiwai          Assigned To               => tiwai           
03-16-05 14:56 tiwai          Assigned To              tiwai =>            
03-17-05 18:49 mailavj        Distribution              => Debian          
03-17-05 18:49 mailavj        Kernel Version            => 2.6.7-2         
03-17-05 18:49 mailavj        Status                   resolved => feedback
03-17-05 18:49 mailavj        Resolution               duplicate => reopened
03-17-05 18:49 mailavj        Note Added: 0003981                          
03-17-05 18:49 mailavj        Assigned To               => tiwai           
03-17-05 18:50 mailavj        Note Added: 0003982                          
03-17-05 18:55 rlrevell       Note Added: 0003983                          
03-18-05 18:14 tiwai          Note Added: 0003999                          
03-23-05 16:02 jdthood        Note Added: 0004169                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
