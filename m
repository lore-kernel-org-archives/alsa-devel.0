From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001852]: Network transparency through polypaudio
Date: Sat, 18 Feb 2006 03:16:19 +0100
Message-ID: <8048e709e0a464873f9bd90f6490ced3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D0A71B0
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 03:16:19 +0100 (MET)
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
Last Modified:              02-18-2006 03:16 CET
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

----------------------------------------------------------------------
 drzeus - 02-18-06 03:16 
----------------------------------------------------------------------
The per connection buffers are tunable (they're set from the buffer
parameters given from alsa). The backend is shared among all clients so
it's configured at the server end, but it can be tuned for low latency.

The big problem is that ALSA's plugin system lacks a way for plugins to
report latency. All they can report is buffer usage, not things like
transport latency.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 20:47 drzeus         New Issue                                    
02-17-06 20:47 drzeus         File Added: alsa-polyp-1.0.10-3.tar.bz2           
        
02-18-06 02:12 rlrevell       Note Added: 0008113                          
02-18-06 03:16 drzeus         Note Added: 0008115                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
