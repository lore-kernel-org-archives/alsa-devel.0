From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001670]: Mic no longer works, can't seem to change anything to fix it
Date: Thu, 22 Dec 2005 05:13:13 +0100
Message-ID: <4663c95ffcf64a51c25c94bfbe160ee1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6EF471A7
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 05:13:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1670> 
======================================================================
Reported By:                callihn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1670
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             ALL, currently vanilla 2.6.14.4
======================================================================
Date Submitted:             12-22-2005 02:25 CET
Last Modified:              12-22-2005 05:13 CET
======================================================================
Summary:                    Mic no longer works, can't seem to change anything
to fix it
Description: 
Everything was working fine in FC2, now that I have upgraded to FC4 I can
no longer get the mic to work, using the same asound.state as posted below
in both and everything else still works as it did before, also I know the
mic does work because unmuting it allows me to hear it in loopback, not
sure if it means anything but in alsamixer the capture option on the mic
does blink when in use but again I can get no sound out of it other than
loopback from unmuting it in the playback section.
======================================================================

----------------------------------------------------------------------
 callihn - 12-22-05 05:13 
----------------------------------------------------------------------
Also here is my card:

01:00.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 02:25 callihn        New Issue                                    
12-22-05 02:25 callihn        Distribution              => Fedora Core 4   
12-22-05 02:25 callihn        Kernel Version            => ALL, currently
vanilla 2.6.14.4
12-22-05 05:13 callihn        Note Added: 0007119                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
