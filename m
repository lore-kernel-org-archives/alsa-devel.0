From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001516]: sound truncated unless I move mouse
Date: Sat, 31 Dec 2005 00:20:10 +0100
Message-ID: <0c7e0723718e3711782ed82a776e31e0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DE50194
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:20:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1516> 
======================================================================
Reported By:                moobaxx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1516
Category:                   PCI - intel8x0
Reproducibility:            N/A
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware
Kernel Version:             2.4
======================================================================
Date Submitted:             10-30-2005 20:14 CET
Last Modified:              12-31-2005 00:20 CET
======================================================================
Summary:                    sound truncated unless I move mouse
Description: 
there's something unusual, becouse when i reproduce a sound, it's sounds
cut off. Today i discovered that moving the mouse while playing, it's
sound perfect. When i stop moving it, the sound starts cut off again. 
As you notice, my english is very poor, so if you need aditional
information, just ask!
tnx.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:20 
----------------------------------------------------------------------
Sounds like an ACPI bug.  Any improvement with later kernel/ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-05 20:14 moobaxx        New Issue                                    
10-30-05 20:14 moobaxx        File Added: sonido.wav                       
10-30-05 20:14 moobaxx        Distribution              => slackware       
10-30-05 20:14 moobaxx        Kernel Version            => 2.4             
11-01-05 15:35 jdthood        Summary                  sounds cut off => sound
truncated unless I move mouse
12-31-05 00:20 rlrevell       Note Added: 0007316                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
