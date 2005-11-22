From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001522]: unable to mute line in while recording(capturing) line in.
Date: Tue, 22 Nov 2005 21:45:18 +0100
Message-ID: <a6e40f25ed77f768e1bcc6049a125b07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA9401B8
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 21:45:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1522> 
======================================================================
Reported By:                penguinz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1522
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10(Breezy)
Kernel Version:             2.6.12-9-k7
======================================================================
Date Submitted:             11-01-2005 16:00 CET
Last Modified:              11-22-2005 21:45 CET
======================================================================
Summary:                    unable to mute line in while recording(capturing)
line in.
Description: 
Unable to mute line in while recording line in. I have a Mythtv system
runing, and since the upgrade from Ubuntu 5.04(Warty) to Ubuntu
5.10(Breezy) I can not mute line in. I tried it on my desktop machine and
get the same results, but also duel boots back into 5.04 so I can test it
both ways.
======================================================================

----------------------------------------------------------------------
 penguinz - 11-22-05 21:26 
----------------------------------------------------------------------
Also a problem while using Skype software. The mic input has the same
problem. Nothing worse than hearing yourself talk though the headset :)

----------------------------------------------------------------------
 pzad - 11-22-05 21:45 
----------------------------------------------------------------------
Set capture on "Capture" and your source ("Line In" or "Mic").
Changing (mute) Line In (or Mic) volume can not affect recorded signal -
this will change only playback volume (if you have SB Live). Make sure,
you have set "Wave Capture" to 0.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 16:00 penguinz       New Issue                                    
11-01-05 16:00 penguinz       Distribution              => Ubuntu 5.10(Breezy)
11-01-05 16:00 penguinz       Kernel Version            => 2.6.12-9-k7     
11-22-05 21:26 penguinz       Note Added: 0006800                          
11-22-05 21:45 pzad           Note Added: 0006803                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
