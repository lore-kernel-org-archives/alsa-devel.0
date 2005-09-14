From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000732]: If PCM is set to norma to mt Sound Blaster Live, It emit a very high frequency sound damaging ears
Date: Wed, 14 Sep 2005 16:10:45 +0200
Message-ID: <9ddee69e5f893473355546c4ed4cffd3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 215FF1A3
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:10:46 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.10-rc3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-19-2004 15:10 CET
Last Modified:              09-14-2005 16:10 CEST
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
 pzad - 12-20-04 16:43 
----------------------------------------------------------------------
Lee, have you time (will) to play with DSP code and driver ???
For example to implement Master (PCM) control, spdif volume control, and
fix bass, treble problem (clipping) ?

----------------------------------------------------------------------
 jdthood - 09-14-05 16:10 
----------------------------------------------------------------------
It looks like this bug report can be closed.

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
12-20-04 00:15 Eric Valette   Note Added: 0002863                          
12-20-04 08:17 pzad           Note Added: 0002867                          
12-20-04 08:34 rlrevell       Note Added: 0002869                          
12-20-04 09:36 Eric Valette   Note Added: 0002870                          
12-20-04 16:43 pzad           Note Added: 0002886                          
09-14-05 16:10 jdthood        Status                   assigned => resolved
09-14-05 16:10 jdthood        Resolution               open => fixed       
09-14-05 16:10 jdthood        Note Added: 0006175                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
