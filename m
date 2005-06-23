From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001193]: no sound through speakers but sound in headphones
Date: Thu, 23 Jun 2005 13:59:00 +0200
Message-ID: <f26ef4734f292aff7ad2128c8a7fa8b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14E1021D
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2005 13:59:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1193> 
======================================================================
Reported By:                gadget
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1193
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               debian-pure64 sid
Kernel Version:             2.6.11.11
======================================================================
Date Submitted:             06-15-2005 13:03 CEST
Last Modified:              06-23-2005 13:59 CEST
======================================================================
Summary:                    no sound through speakers but sound in headphones
Description: 
I can't hear anything through the internel speakers of my notebook. The
sound is anyway hear through the headphones. I can change the volume
correctly, nothing is muted.
I tried the ac97_quirk option through modprobe or direct insmod.
I also tried other drivers without success (no card found).
======================================================================

----------------------------------------------------------------------
 gadget - 06-15-05 13:10 
----------------------------------------------------------------------
the card is recongnized as
x Card: ATI IXP                                                           
                                                                          
                                                  
x Chip: Realtek ALC658 rev 0   
by alsamixer

it appears as Realtek AC'97 under windows

----------------------------------------------------------------------
 gadget - 06-23-05 13:59 
----------------------------------------------------------------------
no ideas at all ?
it quite annoying for dvds.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 13:03 gadget         New Issue                                    
06-15-05 13:03 gadget         Distribution              => debian-pure64 sid
06-15-05 13:03 gadget         Kernel Version            => 2.6.11.11       
06-15-05 13:09 gadget         Issue Monitored: gadget                      
06-15-05 13:10 gadget         Note Added: 0005022                          
06-15-05 13:14 gadget         File Added: lsmod-report                     
06-15-05 13:14 gadget         File Added: lspci-report                     
06-15-05 13:15 gadget         File Added: lspci-vn-report                    
06-15-05 13:16 gadget         File Added: lspci-vv-report                    
06-15-05 13:16 gadget         File Added: proc-asound-report.tar.gz             
      
06-15-05 13:17 gadget         Issue End Monitor: gadget                    
06-23-05 13:59 gadget         Note Added: 0005186                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
