From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001678]: nForce (10de:026c) left channel squeals, right channel mostly okay
Date: Wed, 4 Jan 2006 17:56:07 +0100
Message-ID: <473613128a4c52f2ddd7bab41dc09ed4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10FA213C
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:56:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1678> 
======================================================================
Reported By:                kees
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1678
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.15-rc6-git4
======================================================================
Date Submitted:             12-25-2005 02:29 CET
Last Modified:              01-04-2006 17:56 CET
======================================================================
Summary:                    nForce (10de:026c) left channel squeals, right
channel mostly okay
Description: 
This is an integrated chipset on an ASUS A8N-VM-UAYGZ mobo.  Marketing info
is this is an "nForce410" board, with "6-channel HD audio".

Both the ALSA in 2.6.15-rc6-git4 and the 1.0.11rc1 ALSA driver for
snd-hda-intel load fine, but during playback, the left channel squeals,
while the right seems to play things okay.

I'm happy to dig around and try whatever needs trying to get this fixed. 
Thanks!
======================================================================

----------------------------------------------------------------------
 tiwai - 01-04-06 17:40 
----------------------------------------------------------------------
Could you try ALSA 1.0.11rc2?

----------------------------------------------------------------------
 kees - 01-04-06 17:56 
----------------------------------------------------------------------
Tried 1.0.11rc2.  No changes in any of the behavior.  However, I did notice
a behavior I didn't report before that exists in mainline, 1.0.11rc1, and
1.0.11rc2: after module startup, the left channel of the "front" line is
muted.  All other settings are okay, though.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-25-05 02:29 kees           New Issue                                    
12-25-05 02:29 kees           Distribution              => Ubuntu Breezy   
12-25-05 02:29 kees           Kernel Version            => 2.6.15-rc6-git4 
12-26-05 11:02 kees           Note Added: 0007149                          
12-30-05 23:43 morgoth666     Issue Monitored: morgoth666                    
12-30-05 23:43 morgoth666     Issue End Monitor: morgoth666                    
12-30-05 23:44 morgoth666     Issue Monitored: morgoth666                    
12-30-05 23:50 morgoth666     Note Added: 0007300                          
12-31-05 05:47 Dr Hotdog      Issue Monitored: Dr Hotdog                    
12-31-05 10:16 kees           Note Added: 0007355                          
12-31-05 17:12 Dr Hotdog      Note Added: 0007357                          
12-31-05 17:30 Dr Hotdog      Note Edited: 0007357                         
01-04-06 17:40 tiwai          Note Added: 0007446                          
01-04-06 17:56 kees           Note Added: 0007449                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
