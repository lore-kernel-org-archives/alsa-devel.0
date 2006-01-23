From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001777]: aumix doesn't work with snd-hda-intel driver
Date: Mon, 23 Jan 2006 19:53:45 +0100
Message-ID: <871f35dfcbb0b04c289865716e472ae4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7E61A171
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 19:53:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1777> 
======================================================================
Reported By:                tvignaud
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1777
Category:                   CORE OSS - mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mandriva Linux
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-23-2006 19:47 CET
Last Modified:              01-23-2006 19:53 CET
======================================================================
Summary:                    aumix doesn't work with snd-hda-intel driver
Description: 
With both ALSA 1.0.9b and 1.0.10, aumix won't work with the snd-hda-intel
driver (presumably because it doesn't provide enought data or mixer
element?).

Strace shows it try access() /dev/sound/mixer, then succesfully open() it
and then successfully run four ioctl() on it (at least strace show that
the return value is 0, but the fields must be incorrect or sg else because
with other drivers, aumix will contiune with MTRRIOC_ADD_ENTRY ioctl and
the like whereas with snd-hda-intel, it just exits with an error message).

I've unsuccessfully tried playing with softvol.
======================================================================

----------------------------------------------------------------------
 tvignaud - 01-23-06 19:53 
----------------------------------------------------------------------
to be more precise, we've tested kernel-2.6.12 with ALSA-=1.0.9b and
2.6.14/1.0.10.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-06 19:47 tvignaud       New Issue                                    
01-23-06 19:47 tvignaud       Distribution              => Mandriva Linux  
01-23-06 19:47 tvignaud       Kernel Version            => 2.6.12          
01-23-06 19:53 tvignaud       Note Added: 0007762                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
