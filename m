From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000891]: Wrong settings in NFORCE.conf
Date: Thu, 31 Mar 2005 20:52:25 +0200
Message-ID: <c1e9e46b3a94e498d472675476d0a64d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 90D8B24B
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 20:52:25 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
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
Severity:                   feature
Priority:                   normal
Status:                     acknowledged
======================================================================
Date Submitted:             02-08-2005 14:51 CET
Last Modified:              03-31-2005 20:52 CEST
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

----------------------------------------------------------------------
 tiwai - 02-16-05 17:18 
----------------------------------------------------------------------
Yes, a new control switch to change this behavior would be nice, but this
will likely result in a big rewrite.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 14:51 slammer        New Issue                                    
02-08-05 15:07 slammer        Issue Monitored: slammer                     
02-09-05 11:33 tiwai          Note Added: 0003538                          
02-15-05 11:29 slammer        Note Added: 0003620                          
02-16-05 17:18 tiwai          Note Added: 0003625                          
03-31-05 20:52 jdthood        Severity                 minor => feature    
03-31-05 20:52 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
