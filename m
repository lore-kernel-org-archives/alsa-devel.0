From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000525]: Sound does not work
Date: Fri, 24 Sep 2004 12:26:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924102657.DC6D52A003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 34017175
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 12:26:58 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000525
======================================================================
Reported By:                ao314
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     525
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-23-2004 10:00 CEST
Last Modified:              09-24-2004 12:26 CEST
======================================================================
Summary:                    Sound does not work
Description: 
Sometimes, after the computer has been off for a while the sound refuses to
work. Rebooting a couple of times seems to "fix" it.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:16 CEST 
----------------------------------------------------------------------
What is the exact behavior, "refuses to work" ?

----------------------------------------------------------------------
 ao314 - 09-24-2004 12:18 CEST 
----------------------------------------------------------------------
Basically there is no sound and the stuff I've tried fiddling around with
won't get the sound back including:
1. reinstalling alsa drivers
2. trying to set sound levels - both with alsamixer - which complains no
device found and the little volume control in the bottom right - which
can't be set
3. Alsaconf, can't find any soundcards at the end even though it seems to
correctly determine I have an nForce. 
The only thing that works is reseting the computer.

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:26 CEST 
----------------------------------------------------------------------
I guess the interrupt was diabled when this happens because unprocessed
interrupts are detected.  Check the kernel message.

Did you try 1.0.7rc1?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 10:00 ao314          New Bug                                      
09-23-04 10:00 ao314          Distribution              => Fedora Core 2   
09-23-04 10:00 ao314          Kernel Version            => 2.6.8           
09-23-04 14:29 ao314          Bug Monitored: ao314                         
09-23-04 18:16 tiwai          Bugnote Added: 0001827                       
09-24-04 12:07 ao314          Bug End Monitor: ao314                       
09-24-04 12:18 ao314          Bugnote Added: 0001873                       
09-24-04 12:18 ao314          File Added: amixer.out                       
09-24-04 12:18 ao314          File Added: dmesg.out                        
09-24-04 12:19 ao314          File Added: lspci.out                        
09-24-04 12:19 ao314          File Added: modprobe.out                     
09-24-04 12:26 tiwai          Bugnote Added: 0001876                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
