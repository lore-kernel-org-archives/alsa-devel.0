From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001463]: recording does not work
Date: Fri, 30 Dec 2005 23:47:04 +0100
Message-ID: <42938de22b2577af6520712df582bfb5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0CCD168
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:47:04 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1463> 
======================================================================
Reported By:                vladak
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1463
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Advanced Linux Sound Architecture Driver Version
1.0.9b
Kernel Version:             Linux erazim.devnull-lab.cz 2.6.13-1.1524_FC4 #1 Wed
Sep 21 00:00:00 EDT 2005 i686 athlon i386 GNU/Linux
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-26-2005 20:59 CEST
Last Modified:              12-30-2005 23:47 CET
======================================================================
Summary:                    recording does not work
Description: 
Even if this issue was marked resolved (see bug 0001216), recording on
Sound Blaster Live 5.1 Live! does not work.

I have tried skype, audacity, arecord/aplay, ... nothing works.

I am able to hear myself in the headphones when I talk into the
microphone, but the sound cannot be recorded.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:47 
----------------------------------------------------------------------
This was fixed by adding the SB0222 (possibly SB0220) detection

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-05 20:59 vladak         New Issue                                    
09-26-05 20:59 vladak         Distribution              => Advanced Linux Sound
Architecture Driver Version 1.0.9b
09-26-05 20:59 vladak         Kernel Version            => Linux
erazim.devnull-lab.cz 2.6.13-1.1524_FC4 #1 Wed Sep 21 00:00:00 EDT 2005 i686
athlon i386 GNU/Linux
09-26-05 21:00 vladak         File Added: amixer.out                       
12-30-05 23:47 rlrevell       Status                   new => resolved     
12-30-05 23:47 rlrevell       Resolution               open => fixed       
12-30-05 23:47 rlrevell       Assigned To               => rlrevell        
12-30-05 23:47 rlrevell       Note Added: 0007297                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
