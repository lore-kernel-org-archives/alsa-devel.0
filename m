From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001834]: When using two cards with MIDI, MIDI port names should be differentiated
Date: Thu, 9 Feb 2006 20:07:57 +0100
Message-ID: <8fa72dde77a46b3c84398e50ae77422b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D6EDF1A4
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2006 20:07:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1834> 
======================================================================
Reported By:                peppo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1834
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-09-2006 20:07 CET
Last Modified:              02-09-2006 20:07 CET
======================================================================
Summary:                    When using two cards with MIDI, MIDI port names
should be differentiated
Description: 
I use two 1010LT cards synced. 
The ALSA MIDI names are the same for both cards, which makes it a bit hard
to distinguish them. Both are "M Audio Delta 1010LT MIDI".

Could this be fixed, perhaps, by checking which is card0 and which is
card1, and adding that to the name?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-06 20:07 peppo          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
