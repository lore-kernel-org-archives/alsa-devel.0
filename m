From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001852]: Network transparency through polypaudio
Date: Fri, 17 Feb 2006 20:47:51 +0100
Message-ID: <689a93fe4d5f41089b3e382d0ec4c2a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35901191
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2006 20:47:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1852> 
======================================================================
Reported By:                drzeus
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1852
Category:                   PCM - oss
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-17-2006 20:47 CET
Last Modified:              02-17-2006 20:47 CET
======================================================================
Summary:                    Network transparency through polypaudio
Description: 
This is a request to include the polypaudio (a sound server) plugin I've
written. Having it in ALSA would mean that all ALSA apps could
transparently work across the network.

The plugin can currently handle:

 * PCM playback.
 * PCM capture.
 * Playback volume control.

I supports polled mode and direct access.

Polypaudio needed to be extended a bit to support this plugin so to
compile and use it you need the svn version of polypaudio:

svn co svn://svn.0pointer.de/polypaudio/trunk polypaudio
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 20:47 drzeus         New Issue                                    
02-17-06 20:47 drzeus         File Added: alsa-polyp-1.0.10-3.tar.bz2           
        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
