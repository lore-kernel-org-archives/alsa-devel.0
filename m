From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000984]: No Sound
Date: Thu, 17 Mar 2005 18:49:27 +0100
Message-ID: <a508928282049aadbcab0101c95150cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EE8D123B
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2005 18:49:27 +0100 (MET)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=984> 
======================================================================
Reported By:                mailavj
Assigned To:                
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
Last Modified:              03-17-2005 18:49 CET
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
 tiwai - 03-16-05 13:00 
----------------------------------------------------------------------
Please elaborate your hardware: driver, codec chip.
Make sure that you set up the mixer properly.

Above all, try the later version of ALSA.  1.0.6 is way too old for
debugging.

----------------------------------------------------------------------
 mailavj - 03-17-05 18:49 
----------------------------------------------------------------------
my soundchip is AD1985 frm Analog Devices. and Motherboard is Intel
D865GBF.. and ALSA Driver is 1.0.6-a
no sound is comin frm my box

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
