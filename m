From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001374]: unplug usb audio device while streaming will lock up the usb kernel
Date: Fri, 30 Dec 2005 23:18:20 +0100
Message-ID: <d865ba6abea12b05bbb9f0ae5b394264@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E75E4148
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:18:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1374> 
======================================================================
Reported By:                byuan
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1374
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-27-2005 23:53 CEST
Last Modified:              12-30-2005 23:18 CET
======================================================================
Summary:                    unplug usb audio device while streaming will lock up
the usb kernel
Description: 
unplug usb audio device while streaming will lock up the usb kernel, the
snd_pcm_close() doesn't help, unless the process that called the
snd_pcm_open be closed.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:18 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-27-05 23:53 byuan          New Issue                                    
08-27-05 23:55 byuan          Issue Monitored: byuan                       
12-30-05 23:18 rlrevell       Note Added: 0007283                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
