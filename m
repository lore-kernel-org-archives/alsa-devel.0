From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001323]: MIC jack not supported
Date: Tue, 13 Dec 2005 13:21:59 +0100
Message-ID: <b70107aa2eeaa278a74456ea5e71ebce@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 95E8411F
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 13:21:59 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1323> 
======================================================================
Reported By:                submax82
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1323
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               debian 3.1 sarge
Kernel Version:             linux 2.6.12.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-08-2005 22:10 CEST
Last Modified:              12-13-2005 13:21 CET
======================================================================
Summary:                    MIC jack not supported
Description: 
The problem is simple but important! The alsamixer do not show the volume
of the MIC therefore this do not work!
======================================================================

----------------------------------------------------------------------
 jcdutton - 11-07-05 00:06 
----------------------------------------------------------------------
You seem to have drivers up to date enough.
The controls to adjust are the
Mic/Line in
SPDIF out

These are mutually exclusive. I.e. if SPDIF out is un-muted, Mic/Line in
will not work.
To capture from mic, select Mic on the Mic/Line in control in alsamixer
playback windows, and then I2S in on the capture window.

----------------------------------------------------------------------
 jcdutton - 12-13-05 13:21 
----------------------------------------------------------------------
Closed due to lack of feedback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 22:10 submax82       New Issue                                    
08-08-05 22:10 submax82       Distribution              => debian 3.1 sarge
08-08-05 22:10 submax82       Kernel Version            => linux 2.6.12.4  
08-08-05 22:59 submax82       Issue Monitored: submax82                    
08-08-05 23:00 submax82       Note Added: 0005714                          
08-10-05 05:21 rlrevell       Note Added: 0005746                          
08-12-05 23:09 jcdutton       Note Added: 0005790                          
08-12-05 23:09 jcdutton       Status                   assigned => feedback
08-13-05 14:28 submax82       Note Added: 0005804                          
08-13-05 14:33 submax82       Issue End Monitor: submax82                    
08-17-05 17:02 submax82       Note Added: 0005839                          
09-10-05 10:39 jcdutton       Note Added: 0006109                          
09-15-05 06:44 qqtortqq       Note Added: 0006194                          
09-15-05 06:51 qqtortqq       Issue Monitored: qqtortqq                    
09-25-05 04:00 qqtortqq       Note Added: 0006383                          
11-07-05 00:06 jcdutton       Note Added: 0006611                          
12-13-05 13:21 jcdutton       Status                   feedback => closed  
12-13-05 13:21 jcdutton       Note Added: 0007008                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
