From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001852]: Network transparency through polypaudio
Date: Sat, 18 Feb 2006 02:12:29 +0100
Message-ID: <c3b3e9c2009a756b9c94165c0a55d757@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4E32D1AB
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 02:12:29 +0100 (MET)
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
Last Modified:              02-18-2006 02:12 CET
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

----------------------------------------------------------------------
 rlrevell - 02-18-06 02:12 
----------------------------------------------------------------------
Is this suitable for low latency work AKA does it add any more delay than
is physically required by the network transport mechanism?  Is the
latency/buffering tunable?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 20:47 drzeus         New Issue                                    
02-17-06 20:47 drzeus         File Added: alsa-polyp-1.0.10-3.tar.bz2           
        
02-18-06 02:12 rlrevell       Note Added: 0008113                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
