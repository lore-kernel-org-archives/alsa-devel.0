From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000891]: Wrong settings in NFORCE.conf
Date: Tue, 15 Feb 2005 11:29:15 +0100
Message-ID: <8ba6482d6f1c89f9d80ddd990b5b0ca5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D86F6278
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2005 11:29:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=891> 
======================================================================
Reported By:                slammer
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   891
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-08-2005 14:51 CET
Last Modified:              02-15-2005 11:29 CET
======================================================================
Summary:                    Wrong settings in NFORCE.conf
Description: 
I have an NForce2 chipset with intel8x0 on my ABIT NF7-S and i have
separate sockets for Line-In, Mic, Center/LFE and Surround and i think
there is a lot of other motherboards that have it. Therefore i don't
understand why you force the "Mic As Center/LFE" and "Line-In As Surround"
true, whenever someone whants to use the surround51 and surround4 pcm by
the corresponding hooks. I think that you should leave it as an option and
if it is common that many people use those triggers on, just enable it by
default, but don't force it.

======================================================================

----------------------------------------------------------------------
 tiwai - 02-09-05 11:33 
----------------------------------------------------------------------
Well, there were no machines with independent surround outputs former time.
 A patch to control automatically both cases is welcome.

----------------------------------------------------------------------
 slammer - 02-15-05 11:29 
----------------------------------------------------------------------
I'm not sure it is detectable, since for example Epox 8RDA+ has the same
NForce2 with intel8x0 - litereally the same hardware but it has those
sockets shared. However in Windows once there used to be a wizard in
nVMixer wich asked you which variant you have, and now - with the new
nVMixer it doesn't and seems to play correctly out of the box, but I have
no idea how it detects it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 14:51 slammer        New Issue                                    
02-08-05 15:07 slammer        Issue Monitored: slammer                     
02-09-05 11:33 tiwai          Note Added: 0003538                          
02-15-05 11:29 slammer        Note Added: 0003620                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
