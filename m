From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000916]: no sound
Date: Thu, 3 Mar 2005 09:55:37 +0100
Message-ID: <1bfea6a0f6fef90e9d04cbf69a4520e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98EAF205
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2005 09:55:37 +0100 (MET)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=916> 
======================================================================
Reported By:                mbarrett
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   916
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC3
Kernel Version:             2.6.10-1.766_FC3
======================================================================
Date Submitted:             02-17-2005 17:00 CET
Last Modified:              03-03-2005 09:55 CET
======================================================================
Summary:                    no sound
Description: 
I have sound with kernel 2.6.9
It dissapeared when I installed kernel 2.6.10
Sound works on my Laptop (Dell) with the same kernel, just not my desktop
(Compaq D310m)
Any suggestions?

My sound card is an Intel 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio
======================================================================

----------------------------------------------------------------------
 tiwai - 02-17-05 18:27 
----------------------------------------------------------------------
First, try ALSA 1.0.8.

If you have still the same problem, attach the contents of
/proc/asound/card0/codec97#0/* files and /etc/asound.state for debugging.

----------------------------------------------------------------------
 manu-972 - 03-03-05 05:42 
----------------------------------------------------------------------
I have the same problem on a hp dv1000 (I think it is the same sound system
as yours). Anyway I found that removing the snd-intel8x0m module did the
trick: that is type this as root:
/sbin/rmmod snd-intel8x0m
I think this bug as been corrected but I don't know in which version
(perhaps 1.0.8).
HTH

----------------------------------------------------------------------
 manu-972 - 03-03-05 05:44 
----------------------------------------------------------------------
Just to be more precise here is the fix that I think cure this:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11772.html

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-05 17:00 mbarrett       New Issue                                    
02-17-05 17:00 mbarrett       Distribution              => FC3             
02-17-05 17:00 mbarrett       Kernel Version            => 2.6.10-1.766_FC3
02-17-05 18:27 tiwai          Note Added: 0003631                          
03-03-05 05:42 manu-972       Note Added: 0003783                          
03-03-05 05:44 manu-972       Note Added: 0003784                          
03-03-05 09:55 perex          Category                 PCI - intel8x0 => PCI -
intel8x0m
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
