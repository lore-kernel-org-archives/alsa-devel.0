From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000523]: Unable to get SPDIF output on Biostar IDEQ minipc
Date: Fri, 24 Sep 2004 12:28:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924102850.E58DD2A003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3A45F217
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 12:28:51 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000523
======================================================================
Reported By:                pharm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     523
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work either)
======================================================================
Date Submitted:             09-22-2004 22:48 CEST
Last Modified:              09-24-2004 12:28 CEST
======================================================================
Summary:                    Unable to get SPDIF output on Biostar IDEQ minipc
Description: 
I have a Biostar IDEQ 210V minipc. As well as 6 channel analog out (which
appears to work, at least stereo analog out does for certain) there are
two digital (optical) SPDIF outputs. Unfortunately I can't get anything to
recognise these -- mplayer complains about the lack of IEC958 mixer
entries if I try to use the hwac3 output, and if I point the 
alsa output at any of the list of hardware outputs I get nothing from the
digital amp -- it doesn't appear to get any signal.

Assuming I'm not doing something dumb, is there anything else I should
try? I've tried all the ac97_quirk options.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:25 CEST 
----------------------------------------------------------------------
Could you try the attached patch?
(Note that it's totally untested.)

----------------------------------------------------------------------
 pharm - 09-23-2004 22:09 CEST 
----------------------------------------------------------------------
What am I looking for? It seems to detect OK:
/proc/asound/card0/codec97#0/ac97#0-0 contains the new ID string.

but there's no sound output :( (unless I've fouled up the mixer -- will
check again)

Is there stuff I can twiddle to see what works? I'll have a spelunk
through the patch, but I'm not familiar with the alsa internals
unfortunately...

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:03 CEST 
----------------------------------------------------------------------
What about th spdif output with the patch?
(make sure to use 1.0.7rc, not 1.0.6a)

----------------------------------------------------------------------
 pharm - 09-24-2004 12:28 CEST 
----------------------------------------------------------------------
Ah. Think I may have applied it to 1.0.6a. Will retest!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 22:48 pharm          New Bug                                      
09-22-04 22:48 pharm          Distribution              => Debian unstable 
09-22-04 22:48 pharm          Kernel Version            => 2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work either)
09-23-04 18:25 tiwai          Bugnote Added: 0001829                       
09-23-04 18:26 tiwai          File Added: cm9761-add.dif                    
09-23-04 22:09 pharm          Bugnote Added: 0001851                       
09-24-04 09:28 pharm          Bug Monitored: pharm                         
09-24-04 12:03 tiwai          Bugnote Added: 0001869                       
09-24-04 12:28 pharm          Bugnote Added: 0001877                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
