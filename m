From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000736]: modprobe snd-azx still gives segmentation fault
Date: Thu, 15 Sep 2005 15:08:40 +0200
Message-ID: <82a4de3bc1f7835a5371c659a74b2600@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D3DE6163
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 15:08:39 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=736> 
======================================================================
Reported By:                fermier
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   736
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Mandrake 10.1 Offficial
Kernel Version:             2.3.8.1-12mdk
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-20-2004 07:40 CET
Last Modified:              09-15-2005 15:08 CEST
======================================================================
Summary:                    modprobe snd-azx still gives segmentation fault
Description: 
After having read the other errors reported for the CMI9880 sound chip and
that the CVS version has been fixed, I downloaded the latest CVS version
of the alsa-driver.  ./configure and make seem to complete without errors.
 After a make install a modprobe snd-azx still gives a segmentation fault
just like the normal tarred ball install and the previous CVS gave.  After
a modprobe snd-azx gave the segmentation fault a /sbin/lsmod hangs and
becomes a zombie process the same is true for modprobe -r snd or modprobe
-r snd-azx
======================================================================

----------------------------------------------------------------------
 fermier - 01-22-05 06:23 
----------------------------------------------------------------------
Yes, I can confirm that modprobe snd-dummy also gives a segmentation fault.
 When I installed the driver for the network card that comes as part of
the motherboard this did not give this kind of error though.  What compile
option could be wrong?

This is really a pity, because sound is the only thing left that I need to
get to work on this PC.

----------------------------------------------------------------------
 jdthood - 09-15-05 15:08 
----------------------------------------------------------------------
This was a kernel bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-04 07:40 fermier        New Issue                                    
12-20-04 07:40 fermier        Distribution              => Mandrake 10.1
Offficial
12-20-04 07:40 fermier        Kernel Version            => 2.3.8.1-12mdk   
12-20-04 08:31 rlrevell       Note Added: 0002868                          
12-20-04 13:04 fermier        Note Added: 0002871                          
12-20-04 13:05 fermier        Note Added: 0002872                          
12-20-04 14:27 tiwai          Note Added: 0002873                          
12-20-04 15:35 fermier        Note Added: 0002877                          
12-20-04 15:38 tiwai          Note Added: 0002878                          
12-20-04 16:01 fermier        Note Added: 0002879                          
12-20-04 16:05 tiwai          Note Added: 0002881                          
12-20-04 16:06 tiwai          Note Added: 0002882                          
12-20-04 16:23 fermier        Note Added: 0002884                          
12-20-04 16:34 tiwai          Note Added: 0002885                          
12-20-04 17:32 fermier        Note Added: 0002889                          
12-20-04 17:40 tiwai          Note Added: 0002891                          
12-20-04 18:10 fermier        Note Added: 0002893                          
01-20-05 19:18 tiwai          Note Added: 0003334                          
01-21-05 13:10 fermier        Note Added: 0003346                          
01-21-05 21:05 tiwai          Note Added: 0003356                          
01-22-05 06:23 fermier        Note Added: 0003372                          
09-15-05 15:08 jdthood        Status                   new => closed       
09-15-05 15:08 jdthood        Note Added: 0006202                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
