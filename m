From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001848]: settings: volume is extremely low
Date: Thu, 16 Feb 2006 17:22:11 +0100
Message-ID: <ab891b2f1ecf0685b61430aa017cf459@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C17B418C
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 17:22:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1848> 
======================================================================
Reported By:                Mitch 74
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1848
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva Linux 2006 Community x86-64
Kernel Version:             vanilla 2.6.15.4
======================================================================
Date Submitted:             02-16-2006 11:38 CET
Last Modified:              02-16-2006 17:22 CET
======================================================================
Summary:                    settings: volume is extremely low
Description: 
After compiling my kernel, installing it and booting it, I installed
alsa-drivers 1.0.11rc3 (./configure, make, make install). The driver loads
and works (I have sound coming out of my loudspeakers) but volume is very
low. (this lets all parasites reach my amp thus the sound is very
scratchy).
No complait about stability, however it would be nice to set output at
something different than 8 channels (default).
Has there been any improvement? Maybe in CVS?
======================================================================

----------------------------------------------------------------------
 Marijn Schouten - 02-16-06 17:22 
----------------------------------------------------------------------
did you try a to adjust your volume, for example with alsamixer?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-06 11:38 Mitch 74       New Issue                                    
02-16-06 11:38 Mitch 74       Distribution              => Mandriva Linux 2006
Community x86-64
02-16-06 11:38 Mitch 74       Kernel Version            => vanilla 2.6.15.4
02-16-06 17:22 Marijn SchoutenNote Added: 0008099                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
