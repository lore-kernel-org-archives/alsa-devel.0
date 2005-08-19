From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001191]: Center channel and 32-bit emulation broken when upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Date: Fri, 19 Aug 2005 02:46:00 +0200
Message-ID: <953d4f7a864ebc030523968ef09e444e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 36B93207
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 02:46:01 +0200 (MEST)
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
Last Modified:              08-19-2005 02:45 CEST
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
 rlrevell - 08-18-05 21:31 
----------------------------------------------------------------------
So are you volunteering to buy me an Nforce2 motherboard?

Otherwise, please fuck off.

----------------------------------------------------------------------
 robert - 08-19-05 02:45 
----------------------------------------------------------------------
If neither you nor the other developers have a nforce motherboard, WHO
CHANGED NFORCE.conf, thereby introducing the bug?

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
