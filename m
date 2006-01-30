From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001795]: compilation breaks on usbaudio.c
Date: Mon, 30 Jan 2006 13:24:38 +0100
Message-ID: <68f174c532aa78d26696a2a3df14c9a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AAA721C8
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2006 13:24:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1795> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1795
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.15-git8
======================================================================
Date Submitted:             01-30-2006 09:30 CET
Last Modified:              01-30-2006 13:24 CET
======================================================================
Summary:                    compilation breaks on usbaudio.c
Description: 
/home/henne/alsa/alsa-driver-1.0.11rc3/usb/usbaudio.c:2038: error: unknown
field &#8216;owner&#8217; specified in initializer
/home/henne/alsa/alsa-driver-1.0.11rc3/usb/usbaudio.c:2038: warning:
initialization from incompatible pointer type

======================================================================

----------------------------------------------------------------------
 Henne - 01-30-06 13:24 
----------------------------------------------------------------------
I forgot to mention, that CONFIG_SND_USB_AUDIO is not enabled in my kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-06 09:30 Henne          New Issue                                    
01-30-06 09:30 Henne          Distribution              => Suse 10.0 x86_64
01-30-06 09:30 Henne          Kernel Version            => 2.6.15-git8     
01-30-06 13:24 Henne          Note Added: 0007836                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
