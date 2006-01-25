From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001778]: Only sound on line-out jack
Date: Wed, 25 Jan 2006 11:51:33 +0100
Message-ID: <def87554aea1ac8bbe2966afe1b0d0ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 068E0163
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 11:51:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1778> 
======================================================================
Reported By:                pw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1778
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-24-2006 15:24 CET
Last Modified:              01-25-2006 11:51 CET
======================================================================
Summary:                    Only sound on line-out jack
Description: 
I'm using a Acer Extensa 6702-100 notebook (Intel ICH6 chipset / kernel
2.6.15 / alsa-driver 1.0.11-rc2). The notebook has internal stereo
speakers, a built-in microphone and three jacks (line-out, microphone and
headphones).

I've loaded the snd-hda-intel module with every model listed in the
documentation. When using the fujitsu model option I'm getting sound on
the line-out jack. The internal speakers, built-in microphone and
headphone jack don't work. I've not tested the mic jack yet.
======================================================================

----------------------------------------------------------------------
 blackr2d - 01-25-06 11:51 
----------------------------------------------------------------------
Duplicate of 1572 - mixer controls not picked up correctly for ALC880

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-06 15:24 pw             New Issue                                    
01-24-06 15:26 pw             File Added: codec#0                          
01-24-06 15:27 pw             File Added: codec#1                          
01-25-06 11:51 blackr2d       Note Added: 0007777                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
