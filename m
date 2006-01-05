From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001709]: 5.1 doesn't work
Date: Thu, 5 Jan 2006 22:02:55 +0100
Message-ID: <2ac4b1c551e8d45fbe3f7179be07ca96@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D7C318E
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 22:02:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1709> 
======================================================================
Reported By:                piezo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1709
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369
======================================================================
Date Submitted:             01-04-2006 13:50 CET
Last Modified:              01-05-2006 22:02 CET
======================================================================
Summary:                    5.1 doesn't work
Description: 
I'm new to linux.  I've been googling for a awnser to this problem for a
week now.  found a few with the same sort of problems but no awnsers.

I can get sterio sound but not 5.1 surround.  This is very irritating as I
bought a Audity2 soundcard for the purpose of using it's 5.1 sound
capability.

initially xine kept telling me that another process was using the PCM
device.  found how to fix this.  using
======================================================================

----------------------------------------------------------------------
 piezo - 01-05-06 00:23 
----------------------------------------------------------------------
"Sound Blaster Audigy 2 value" pci card
followed the Alsa setup instructions.
detected correctly (SB0400)

can only seem to use it in sterio or (with fixes) fake 5.1 (which is
really sterio duplicated).

----------------------------------------------------------------------
 rlrevell - 01-05-06 22:02 
----------------------------------------------------------------------
2.6.11 is way too old for such a new device.  Try a newer kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 13:50 piezo          New Issue                                    
01-04-06 13:50 piezo          Distribution              => Fedora Core 4   
01-04-06 13:50 piezo          Kernel Version            => 2.6.11-1.1369   
01-05-06 00:23 piezo          Note Added: 0007461                          
01-05-06 22:02 rlrevell       Note Added: 0007483                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
