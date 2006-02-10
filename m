From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001824]: Always mixed into one channel when recording stereo
Date: Fri, 10 Feb 2006 23:38:19 +0100
Message-ID: <b0b0e8bf3d89e53b9a4a6138f2227bde@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5C22D185
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 23:38:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1824> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1824
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r4
======================================================================
Date Submitted:             02-06-2006 06:56 CET
Last Modified:              02-10-2006 23:38 CET
======================================================================
Summary:                    Always mixed into one channel when recording stereo
Description: 
When recording stereo audio (2 channels), the sound seems to mix to one
channel and then saved in the left track. I do not have anything in
asound.conf or ~/.asoundrc that will affect the recordings. I even cleared
them out to make sure that my code is not screwing up the recordings. It
has done this since I upgraded to 1.0.10 from 1.0.9. I thought 1.0.11rc3
will fix the problem but it still does it.
======================================================================

----------------------------------------------------------------------
 tartif - 02-10-06 23:38 
----------------------------------------------------------------------
This sounds identical to bug 1527. It looks like an alsa-lib problem that
doesn't correctly set the recording source for the right channel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-06 06:56 Electro        New Issue                                    
02-06-06 06:56 Electro        Distribution              => Gentoo          
02-06-06 06:56 Electro        Kernel Version            => 2.6.14-gentoo-r4
02-10-06 23:38 tartif         Note Added: 0008009                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
