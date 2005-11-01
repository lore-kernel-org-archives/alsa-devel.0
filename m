From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001191]: Center channel and 32-bit emulation broken when upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Date: Tue, 1 Nov 2005 15:45:44 +0100
Message-ID: <f02e9df79748b812eb946b8bef5b9b83@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B87E915C
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:45:44 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001501.
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
Last Modified:              11-01-2005 15:45 CET
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
related to          0001501 intel8x0 surround channels missing and ...
has duplicate       0001206 No center channel; rear left and right ...
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

----------------------------------------------------------------------
 robert - 08-19-05 02:45 
----------------------------------------------------------------------
If neither you nor the other developers have a nforce motherboard, WHO
CHANGED NFORCE.conf, thereby introducing the bug?

----------------------------------------------------------------------
 rlrevell - 08-19-05 03:10 
----------------------------------------------------------------------
The change was made to fix some other bug.

 Details here:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/conf/cards/NFORCE.conf?rev=1.9&view=log

What you are asking is that each change be fully regression tested with
every single piece of hardware on the market.  We are not Microsoft, we
don't have those kinds of resources.

Try reverting the last three changes one at a time and see which causes
the problem.  Or try the patch I posted to #1206.

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
08-19-05 02:45 robert         Note Added: 0005863                          
08-19-05 03:10 rlrevell       Note Added: 0005865                          
11-01-05 15:45 jdthood        Relationship added       related to 0001501  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
