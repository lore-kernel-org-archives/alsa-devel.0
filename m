From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001767]: midi port (64:32 'Audigy MPU-401 #2') will not read/record
Date: Sun, 22 Jan 2006 04:44:03 +0100
Message-ID: <e252e44a1fbf978243ef443cc180ee29@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B285184
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 04:44:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1767> 
======================================================================
Reported By:                bscipioni
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1767
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat
Kernel Version:             2.6.12-smp
======================================================================
Date Submitted:             01-22-2006 03:23 CET
Last Modified:              01-22-2006 04:44 CET
======================================================================
Summary:                    midi port (64:32 'Audigy MPU-401 #2') will not
read/record
Description: 
I have Audigy 2 Platinum.  The Audgiy "drive" midi input is not working. 
Previously I had been able to both play my midi keyboard and record from
it using Rosegarden, earlier versions of alsa and RedHat 9.  Now I can
only play
the keyboard (midi out 64:32) - record doesn't work.  Taking Rosegarden
out of the equation, I used both JACK and aconnect to connect 64:32
directly to 65:0 and I get nothing playing the keyboard.  Soundfonts are
loaded and working  
works just fine. So it seems just the 64:32 read port is not working
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-22-06 04:44 
----------------------------------------------------------------------
Please use ALSA CVS to do a binary search by date and identify the change
that broke it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 03:23 bscipioni      New Issue                                    
01-22-06 03:23 bscipioni      Distribution              => Redhat          
01-22-06 03:23 bscipioni      Kernel Version            => 2.6.12-smp      
01-22-06 04:44 rlrevell       Note Added: 0007743                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
