From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000732]: If PCM is set to norma to mt Sound Blaster Live, It emit a very high frequency sound damaging ears
Date: Sun, 19 Dec 2004 23:16:40 +0100
Message-ID: <96e00dc31ceed715d24174d9aa16e1f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3AE13214
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 23:16:41 +0100 (MET)
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
Last Modified:              12-19-2004 23:16 CET
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
 Eric Valette - 12-19-04 23:11 
----------------------------------------------------------------------
They are connected to the Analog output.

----------------------------------------------------------------------
 Eric Valette - 12-19-04 23:16 
----------------------------------------------------------------------
Unfortunately, I have only tree kernels I keep with lilo :
current, previous and a good one.

If current obviously fails, then current = previous and good = previous
and then lilo so that I can start hacking.

Unfortunately, As I do not listen to music or watch video frequently, I
missed the exact point when it started misbehaving and probably crash the
good kernel when migrating from 2.6.10-rc1 to something newer.

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
12-19-04 23:00 rlrevell       Note Added: 0002855                          
12-19-04 23:05 Eric Valette   Note Added: 0002856                          
12-19-04 23:09 rlrevell       Note Added: 0002857                          
12-19-04 23:10 rlrevell       Note Added: 0002858                          
12-19-04 23:11 Eric Valette   Note Added: 0002859                          
12-19-04 23:16 Eric Valette   Note Added: 0002860                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
