From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000907]: The sound is choppy and sometimes played at wrong speed
Date: Tue, 22 Mar 2005 22:56:19 +0100
Message-ID: <c5eee034fa8e5b0184af3c1dbb07f9da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2DF0D293
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:56:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=907> 
======================================================================
Reported By:                sHINOBI
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   907
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.766_FC3
======================================================================
Date Submitted:             02-13-2005 11:36 CET
Last Modified:              03-22-2005 22:56 CET
======================================================================
Summary:                    The sound is choppy and sometimes played at wrong
speed
Description: 
The soundcard is working, although the sound is choppy when playing sound
at 44100 Hz. 48000 Hz audio like the one at DVD's is played correctly.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-22-05 22:14 
----------------------------------------------------------------------
Try 1.0.9rc1.  My last fix to ac97 might influence on this behavior.

----------------------------------------------------------------------
 sHINOBI - 03-22-05 22:56 
----------------------------------------------------------------------
I'm already using it without success. The problem can be, that this
soundcard is without ac97 :-(. Any other ideas how to solve this? BTW I
think I have those problems when I'm using OSS emulation.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-05 11:36 sHINOBI        New Issue                                    
02-13-05 11:36 sHINOBI        Distribution              => Fedora Core 3   
02-13-05 11:36 sHINOBI        Kernel Version            => 2.6.10-1.766_FC3
02-13-05 11:38 sHINOBI        Note Added: 0003583                          
03-02-05 13:22 Juha           Note Added: 0003770                          
03-19-05 18:24 jcdutton       Note Added: 0004064                          
03-22-05 22:14 tiwai          Note Added: 0004138                          
03-22-05 22:56 sHINOBI        Note Added: 0004144                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
