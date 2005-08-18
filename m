From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001191]: Center channel and 32-bit emulation broken when upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Date: Thu, 18 Aug 2005 21:33:19 +0200
Message-ID: <2c2401f40e5168854ab299f122592f0a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F4FE22C
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2005 21:33:19 +0200 (MEST)
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


The issue 0001206 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1191> 
======================================================================
Reported By:                robert
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1191
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-14-2005 11:45 CEST
Last Modified:              08-18-2005 21:31 CEST
======================================================================
Summary:                    Center channel and 32-bit emulation broken when
upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Description: 
I'm running AMD64 gentoo on an nforce4 system, audio is nVidia CK804 with
ALC850. I can emerge the newest alsa-driver package (1.0.9b), but when I
upgrade alsa-lib to 1.0.9, three things happen.  First, my 32 bit sound
applications, like mplayer32, don't work with alsa anymore.  Second, the
center channel on all 5.1 sound goes out.  Third, the a/v synchonization
on mplayer gets hosed using alsa (oss emulation still ok.)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001206 No Surround Sound (5.1) with analog spe...
======================================================================

----------------------------------------------------------------------
 jdthood - 06-15-05 14:01 
----------------------------------------------------------------------
Do the problems go away if you disable the dmix plugin?

----------------------------------------------------------------------
 robert - 06-15-05 22:00 
----------------------------------------------------------------------
How does one do that?

----------------------------------------------------------------------
 jdthood - 06-15-05 23:42 
----------------------------------------------------------------------
mplayer -ao alsa:device=hw=0

should do it

----------------------------------------------------------------------
 robert - 08-18-05 21:12 
----------------------------------------------------------------------
Those mplayer options do nothing to fix the problem.  The bug is in
NFORCE.conf.  Somebody decided to break it for alsa-lib 1.0.9 for unknown
reasons.

Narrowing the problem down to this file took several hours.  At least one
other person (bug # 1206) has the same problem.  I've also found the bug
on an AthlonXP nforce2 board.  My conclusion:  It's likely that nobody
with an nforce motherboard has functioning surround sound in Linux right
now.  

How did this happen?  Was there no TESTING before these changes were made?
 End users (who have no clue how to debug this kind of stuff) will never
be able to straighten this out.

----------------------------------------------------------------------
 rlrevell - 08-18-05 21:31 
----------------------------------------------------------------------
So are you volunteering to buy me an Nforce2 motherboard?

Otherwise, please fuck off.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-05 11:45 robert         New Issue                                    
06-15-05 14:01 jdthood        Note Added: 0005023                          
06-15-05 22:00 robert         Note Added: 0005045                          
06-15-05 23:42 jdthood        Note Added: 0005048                          
08-18-05 21:12 robert         Note Added: 0005853                          
08-18-05 21:31 rlrevell       Note Added: 0005855                          
08-18-05 21:32 rlrevell       Relationship added       has duplicate 0001206
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
