From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001807]: Sound playback hangs and loops on first buffer
Date: Fri, 3 Feb 2006 02:43:41 +0100
Message-ID: <b6aaae6c748d2ff4bfe1c2960f08bace@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D47EA19D
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 02:43:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1807> 
======================================================================
Reported By:                hno
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1807
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5 test 2 + relevant updates (kernel,
alsa)
Kernel Version:             2.6.15
======================================================================
Date Submitted:             02-02-2006 00:15 CET
Last Modified:              02-03-2006 02:43 CET
======================================================================
Summary:                    Sound playback hangs and loops on first buffer
Description: 
Trying to play any sound or music produces a never ending loop of the first
1/2 second or so.
======================================================================

----------------------------------------------------------------------
 rlrevell - 02-02-06 19:07 
----------------------------------------------------------------------
Any way you can compare the /proc/asound/cardX/codec* files between the
working and non-working versions?

----------------------------------------------------------------------
 hno - 02-03-06 02:43 
----------------------------------------------------------------------
There is quite some differences, most different mixer settings I think.

You can find a collection of /proc/asound/ entries from different alsa
versions at http://www.henriknordstrom.net/tmp/alsa-bug-1807/

1.0.9b-2.6.14-1.1656_FC4smp-silent
1.0.9b_26-realtek-3.5-6-2.6.14-1.1656_FC4smp-working
1.0.10rc1-2.6.14-1.1656_FC4smp-silent_crashing_alsamixer
1.0.11rc3-2.6.14-1.1656_FC4smp-hanging
1.0.11rc3-2.6.15-1.1884_FC5-hanging

Additionally the sources to realtek 3.5-6 (R3.56) driver (alsa 1.0.9b
based) can be found here:
ftp://152.104.238.194/pc/hda/alc880d/realtek-linux-audiopack-3.5-6.tar.bz2
from
http://www.realtek.com.tw/downloads/dlhd-2.aspx?lineid=2004052&famid=2004052&series=2004061&Software=True

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 00:15 hno            New Issue                                    
02-02-06 00:15 hno            Distribution              => Fedora Core 5 test 2
+ relevant updates (kernel, alsa)
02-02-06 00:15 hno            Kernel Version            => 2.6.15          
02-02-06 00:40 rlrevell       Note Added: 0007865                          
02-02-06 02:42 hno            Note Added: 0007867                          
02-02-06 03:46 hno            Note Added: 0007868                          
02-02-06 18:41 hno            Note Added: 0007879                          
02-02-06 19:07 rlrevell       Note Added: 0007881                          
02-03-06 02:43 hno            Note Added: 0007885                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
