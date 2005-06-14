From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001191]: Center channel and 32-bit emulation broken when upgrading alsa-lib from 1.0.8 to 1.0.9 on nForce 4 system
Date: Tue, 14 Jun 2005 11:45:57 +0200
Message-ID: <2673873d972ee169a128bc1e92e74b9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBF6A1A7
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2005 11:45:57 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              06-14-2005 11:45 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-05 11:45 robert         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
