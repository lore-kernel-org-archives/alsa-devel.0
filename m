From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000632]: The recordings doesnt work properly
Date: Wed, 10 Nov 2004 23:30:35 +0100
Message-ID: <28c029ab1e9c3cae7318032b31f1719d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BA2A923B
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 23:30:35 +0100 (MET)
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
Last Modified:              11-10-2004 23:30 CET
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
 littlewing - 11-05-04 23:31 
----------------------------------------------------------------------
Another informations. 
Thanks for helping and sorry for my english

Soundcard: Creative Sound blaster audigy 2 ZS 
Platinium pro
ALSA : 1.0.6 - Debian packages
More:udev, hotplug,cups,sane

----------------------------------------------------------------------
 pzad - 11-10-04 23:30 
----------------------------------------------------------------------
What app do you use for reording ??? Try to use 
arecord -f dat -t wav some.wav
are problems in some.wav still there ????

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-04 23:28 littlewing     New Issue                                    
11-05-04 23:28 littlewing     Distribution              => Debian SID      
11-05-04 23:28 littlewing     Kernel Version            => 2.6.9           
11-05-04 23:31 littlewing     Note Added: 0002307                          
11-10-04 23:30 pzad           Note Added: 0002381                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
