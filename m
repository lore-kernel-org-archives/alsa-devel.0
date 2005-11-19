From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001556]: Fortissimo 4: No Volume Control
Date: Sat, 19 Nov 2005 10:27:49 +0100
Message-ID: <b3763cf0b8da16a6b5fb8e0f0f423583@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1503D17E
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2005 10:27:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556> 
======================================================================
Reported By:                bladus
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1556
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.14-ck1
======================================================================
Date Submitted:             11-13-2005 22:06 CET
Last Modified:              11-19-2005 10:27 CET
======================================================================
Summary:                    Fortissimo 4: No Volume Control
Description: 
With the Hercules Fortissimo 4 (Envy24HT) there's no posibillity to control
the volume.
It's always at max.

Under Windows the card uses the reference drivers from VIA, so maybe you
can fix that issue.
I would be very happy if you could send me a response to this issue within
a week, since when it's not possible i can return the card to the
merchant.

Thank you.

======================================================================

----------------------------------------------------------------------
 bladus - 11-15-05 16:37 
----------------------------------------------------------------------
Thanks, i will test it but there's one problem:
I don't have /var/log/messages, is there any other file where alsa puts
it's messages?

----------------------------------------------------------------------
 bladus - 11-19-05 10:27 
----------------------------------------------------------------------
Okay i tried it and both options don't work.
with the sn25p option the volume in alsamixer is 100%, but if i change it
the soundcard doesn't react.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 22:06 bladus         New Issue                                    
11-13-05 22:06 bladus         Distribution              => Gentoo Linux 2005.1
11-13-05 22:06 bladus         Kernel Version            => 2.6.14-ck1      
11-14-05 11:02 perex          Note Added: 0006713                          
11-14-05 11:02 perex          Assigned To               => perex           
11-14-05 11:02 perex          Status                   new => feedback     
11-14-05 13:39 bladus         Note Added: 0006722                          
11-14-05 13:55 bladus         Note Added: 0006723                          
11-14-05 14:01 perex          Note Added: 0006724                          
11-15-05 16:37 bladus         Note Added: 0006731                          
11-19-05 10:27 bladus         Note Added: 0006761                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
