From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000632]: The recordings doesnt work properly
Date: Wed, 14 Sep 2005 15:59:33 +0200
Message-ID: <612eb62f73060746b35bfeb43f7a0fb0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E55E3199
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 15:59:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=632> 
======================================================================
Reported By:                littlewing
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   632
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian SID
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-05-2004 23:28 CET
Last Modified:              09-14-2005 15:59 CEST
======================================================================
Summary:                    The recordings doesnt work properly
Description: 
Hi,
when I am trying to recording music which are on a external player (cf
Mini disc), every recording are ugly. I can record music, but, after, when
I m play the front recorded tracks, there are a lot of "jumps", "sratchs"
or the music speeds or slown down randomly.

These problems were decreased when I was upgraded the kernel on the
version 2.6.9, but are still presents.

I test the same recording on windows, and worked perfectly:-(
======================================================================

----------------------------------------------------------------------
 pzad - 11-10-04 23:30 
----------------------------------------------------------------------
What app do you use for reording ??? Try to use 
arecord -f dat -t wav some.wav
are problems in some.wav still there ????

----------------------------------------------------------------------
 jdthood - 09-14-05 15:59 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-04 23:28 littlewing     New Issue                                    
11-05-04 23:28 littlewing     Distribution              => Debian SID      
11-05-04 23:28 littlewing     Kernel Version            => 2.6.9           
11-05-04 23:31 littlewing     Note Added: 0002307                          
11-10-04 23:30 pzad           Note Added: 0002381                          
09-14-05 15:59 jdthood        Note Added: 0006168                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
