From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001557]: Sounds play only for a very
	short time (VT8251, 64-bit)
Date: Mon, 12 Jun 2006 02:47:09 +0200
Message-ID: <cec2c9c930593ed331e5fcb37ea7e03d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3276149
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jun 2006 02:47:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1557> 
======================================================================
Reported By:                Dakkus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1557
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 "Breezy Badger" (64-bit)
Kernel Version:             2.6.12-9-amd64-generic
======================================================================
Date Submitted:             11-14-2005 13:10 CET
Last Modified:              06-12-2006 02:47 CEST
======================================================================
Summary:                    Sounds play only for a very short time (VT8251,
64-bit)
Description: 
When playing for example an mp3 file, only a short burst of sound is heard.
The songs play with correct speed and sound otherwise correct, but sound
is played only for about one second. If I choose any random part of the
song (for example with xmms), I hear the same ~1s from that part of the
song, but then everything's quiet again.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001622 ASUS A8V-MX onboard sound does not work
======================================================================

----------------------------------------------------------------------
 thijser - 12-06-05 23:10 
----------------------------------------------------------------------
Exactly the same here ...

----------------------------------------------------------------------
 ggeorgak - 06-12-06 02:47 
----------------------------------------------------------------------
I have the same problem using OpenSuSE 10.1 and alsa version 1.0.11 using
2.6.16.13-4-smp kernel on a x64 architecture. Need some of alsa
masterminds help. An interesting link
is:https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=1622
the resolved duplicate with a patch file that supposedly was upstreamed to
newer alsa versions. Is there any solutions that doesn't involve kernel
recompilation not suitable for us linux commoners?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-05 13:10 Dakkus         New Issue                                    
11-14-05 13:10 Dakkus         Distribution              => Ubuntu 5.10 "Breezy
Badger" (64-bit)
11-14-05 13:10 Dakkus         Kernel Version            =>
2.6.12-9-amd64-generic
12-05-05 19:01 m_yates        Issue Monitored: m_yates                     
12-06-05 15:15 m_yates        Note Added: 0006923                          
12-06-05 22:35 thijser        Issue Monitored: thijser                     
12-06-05 23:10 thijser        Note Added: 0006939                          
12-07-05 11:24 perex          Relationship added       duplicate of 0001622
03-14-06 10:05 adrian         Issue Monitored: adrian                      
06-12-06 02:37 ggeorgak       Issue Monitored: ggeorgak                    
06-12-06 02:47 ggeorgak       Note Added: 0010155                          
======================================================================
