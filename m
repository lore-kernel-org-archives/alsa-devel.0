From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001880]: Can not use alsamixer when
	using CK804 and the iec598 volume has to be all the day down
Date: Thu, 8 Jun 2006 00:17:43 +0200
Message-ID: <6a52212975d7352af636abb325b09daf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC8F5160
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 00:17:43 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1880> 
======================================================================
Reported By:                davegermiquet
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1880
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-26-2006 06:31 CET
Last Modified:              06-08-2006 00:17 CEST
======================================================================
Summary:                    Can not use alsamixer when using CK804  and the
iec598 volume has to be all the day down
Description: 
First the IEC958 P volume has to be all the way down for my Coax cable to
work and the only option that works to get it running is

mplayer -ao device=surround51

mplayer -ao device=hw0,2 does not work.

When that is ran surround works and i my coax works but I can not use alsa
mixer to modify volumes it is like its inactive however volume controls
work in kaffeine and amarok.

Using revision 3 and motherboard a8ne-fm
Have attached file
======================================================================

----------------------------------------------------------------------
 Human - 06-08-06 00:17 
----------------------------------------------------------------------
Just a note on syntax if you're using mplayer 1.0pre6-3.3.5 or later:

"mplayer -ao device=hw0,2" -> "mplayer -ao device=hw=0.2"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-06 06:31 davegermiquet  New Issue                                    
02-26-06 06:31 davegermiquet  File Added: card.txt                         
06-08-06 00:17 Human          Note Added: 0010100                          
======================================================================
