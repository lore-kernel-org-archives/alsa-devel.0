From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000732]: If PCM is set to norma to mt Sound Blaster Live, It emit a very high frequency sound damaging ears
Date: Sun, 19 Dec 2004 22:51:31 +0100
Message-ID: <a7e4464f20d69c5ae7f8c59eace7e3bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2F3BF2AD
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 22:51:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=732> 
======================================================================
Reported By:                Eric Valette
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   732
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.10-rc3
======================================================================
Date Submitted:             12-19-2004 15:10 CET
Last Modified:              12-19-2004 22:51 CET
======================================================================
Summary:                    If PCM is set to norma to mt Sound Blaster Live, It
emit a very high frequency sound damaging ears
Description: 
Since 2.6.10-rc1 or rc2, I can no more use alsa on my PC or I may damage my
ears! This is why I put a high priority as I think it may really damage
people ears...

NB : WIndows XP is working as usual, I did not change anything in my
settings except updating the kernel from 2.6.9...

Reading the bitkeeper changelog for emuk10k1, it may well be related to
other change in other part of the code (PCI layer...)

Do you have a bitkeeper tree diff so that I can test with latest kernel
version of the code?
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-19-04 22:46 
----------------------------------------------------------------------
What in the hell does "If PCM is set to norma to mt Sound Blaster Live"
mean?  Your bug report is incomprehensible.

----------------------------------------------------------------------
 Eric Valette - 12-19-04 22:51 
----------------------------------------------------------------------
Sorry I did not read back before submitting...

If you set PCM value to under 50% it works (but you almost ear nothing).
If you set it above this value, then the speakers start emitting high
frequency sound that hurts...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 15:10 Eric Valette   New Issue                                    
12-19-04 15:10 Eric Valette   Distribution              => Debian          
12-19-04 15:10 Eric Valette   Kernel Version            => 2.6.10-rc3      
12-19-04 22:41 Eric Valette   Note Added: 0002851                          
12-19-04 22:46 Eric Valette   Note Added: 0002852                          
12-19-04 22:46 rlrevell       Note Added: 0002853                          
12-19-04 22:51 Eric Valette   Note Added: 0002854                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
