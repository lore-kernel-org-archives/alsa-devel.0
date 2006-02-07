From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001827]: cannot set rate to 44100 Hz with full duplex
Date: Tue, 7 Feb 2006 11:12:46 +0100
Message-ID: <c3d18bc9d84c0d87fc5efad0e18e8cfc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 561811C0
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2006 11:12:46 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1827> 
======================================================================
Reported By:                mdeboer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1827
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-07-2006 11:12 CET
Last Modified:              02-07-2006 11:12 CET
======================================================================
Summary:                    cannot set rate to 44100 Hz with full duplex
Description: 
I try to run the alsa-lib/test/latency.c test, and it exits with

  Rate doesn't match (requested 44100Hz, get 0Hz)
  Unable to set parameters for playback stream: Invalid argument

If I force the application to continue at this point (commenting the
return -EINVAL; line), it seems to work ok. But what I find strange is
that the exact rates for I/O are not identical:

  Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0
  Its setup is:
    stream       : PLAYBACK
    ...
    exact rate   : 44101 (1445100000/32768)
    ...
  Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0
  Its setup is:
    stream       : CAPTURE
    ...
    exact rate   : 44099.8 (1572864000/35666)
    ...

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-07-06 11:12 mdeboer        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
