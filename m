From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001585]: No sound from Soundblaster Live USB since updating kernel drivers to 1.0.10.rc3
Date: Tue, 22 Nov 2005 07:54:36 +0100
Message-ID: <06327b9061925ade7888752fee2ad332@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2070D19E
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 07:54:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585> 
======================================================================
Reported By:                sailfrog
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1585
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             > 2.6.14 (rc1, mm1, mm2, rc2)
======================================================================
Date Submitted:             11-21-2005 17:45 CET
Last Modified:              11-22-2005 07:54 CET
======================================================================
Summary:                    No sound from Soundblaster Live USB since updating
kernel drivers to 1.0.10.rc3
Description: 
Every kernel since 2.6.14 (I have tried rc1, mm1, mm2, and rc2) has left
my external USB sound card broken. It appears to be something in the
alsa-git-2005-11-07.patch that was posted to LKML on 11/07/05:

subject:         [ALSA UPDATE] 1.0.10rc3
message-id:        
<Pine.LNX.4.61.0511071457480.8818@tm8103.perex-int.cz>

Applying this alsa update to 2.6.14 also renders the card silent. The
card
is visible in /proc/asound/cards, alsamixer sees it and I can adjust the
volume, but I get no sound from xmms, mplayer, etc. I tried enabling alsa
debug and verbose printk but I was unable to find any additional messages
from dmesg or in any log files. The card is a Creative Labs SoundBlaster
Live 24-bit external. I'm using the SPDIF output to run sound through a
home theater system. I'm running debian unstable on a Toshiba laptop. 

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-22-05 07:54 
----------------------------------------------------------------------
This is probably a bug that has been fixed in ALSA 1.0.10 and since
2.6.15rc1.

(rc1 and rc2 came before the release)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-05 17:45 sailfrog       New Issue                                    
11-21-05 17:45 sailfrog       Distribution              => Debian          
11-21-05 17:45 sailfrog       Kernel Version            => > 2.6.14 (rc1, mm1,
mm2, rc2)
11-21-05 18:45 sailfrog       Issue Monitored: sailfrog                    
11-22-05 07:54 Clemens LadischNote Added: 0006785                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
