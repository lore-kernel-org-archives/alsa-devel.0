From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000732]: If PCM is set to norma to mt Sound Blaster Live, It emit a very high frequency sound damaging ears
Date: Mon, 20 Dec 2004 00:10:33 +0100
Message-ID: <eeaf39dbf42889cfe06ee0cbc905fc36@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 50B2327F
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 00:10:34 +0100 (MET)
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
Last Modified:              12-20-2004 00:10 CET
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
 Eric Valette - 12-20-04 00:04 
----------------------------------------------------------------------
So after recompiling stock 2.6.9 : problem is still the same. So I purely
removed /var/lib/alsa/asound.state (created by a manual alsactl store)
from a previous version and used alsamixer to put all level to a really
minimalistic settings => works on 2.6.9. In can put PCM to 100%

So, I really do not know what went wrong as I teached debian alsa init
script to always restore /var/lib/alsa/asound.state without storing a
fresh version when shutting down long time ago so that it remain unchanged
across sessions.

I guess there as been an inconsistency between /var/lib/alsa/asound.state,
the alsactl and the kernel driver at some point in time that caused this
problem. By chance, level was low enough when it occured so that I did not
really damaged my ears.

----------------------------------------------------------------------
 rlrevell - 12-20-04 00:10 
----------------------------------------------------------------------
OK great let's close this one.

It seems to me that you have your speakers or external amplifier turned up
WAY too loud, if a burst of random noise from the computer hurts your
ears.  Linux PCs are not (usually)  hard realtime systems, they can and do
fail, and it's up to you to configure things so that such a failure won't
cause physical injury.  Just my $0.02.

This might be as simple as turning down the speakers before booting a new
kernel for the first time ;-)

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
12-20-04 00:04 Eric Valette   Note Added: 0002861                          
12-20-04 00:10 rlrevell       Note Added: 0002862                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
