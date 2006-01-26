From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001556]: Fortissimo 4: No Volume Control
Date: Thu, 26 Jan 2006 08:35:54 +0100
Message-ID: <3185d08890839d6f38610dc4a5934c75@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABA0E197
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 08:35:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556> 
======================================================================
Reported By:                bladus
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1556
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.14-ck1
======================================================================
Date Submitted:             11-13-2005 22:06 CET
Last Modified:              01-26-2006 08:35 CET
======================================================================
Summary:                    Fortissimo 4: No Volume Control
Description: 
With the Hercules Fortissimo 4 (Envy24HT) there's no posibillity to control
the volume.
It's always at max.

Under Windows the card uses the reference drivers from VIA, so maybe you
can fix that issue.
I would be very happy if you could send me a response to this issue within
a week, since when it's not possible i can return the card to the
merchant.

Thank you.

======================================================================

----------------------------------------------------------------------
 liiwi - 01-10-06 19:58 
----------------------------------------------------------------------
Hrm, with the same card I cannot even get a bleep out. Trying to use spdif,
don't have at the moment anything to connect to analog out. Kernel is
2.6.15.

Same "No matching model" error as above, and envy24control does not
start:

$ envy24control 
No ICE1712 cards found

Trying different model numbers with module options does not change
anything.

Hrm, seems that I have slightly different problem, as "Simple mixer
control 'Multi Track Peak'" has all volumes at 0%, and I cannot change
them.

Anything I can do?

----------------------------------------------------------------------
 rolling - 01-26-06 08:35 
----------------------------------------------------------------------
I have same problem volume control.  
Both of these options does solve the problem. Is there any more ideas how
to make it work. 
Distribution Ubuntu 5.10
Kernel 2.6.12

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 22:06 bladus         New Issue                                    
11-13-05 22:06 bladus         Distribution              => Gentoo Linux 2005.1
11-13-05 22:06 bladus         Kernel Version            => 2.6.14-ck1      
11-14-05 11:02 perex          Note Added: 0006713                          
11-14-05 11:02 perex          Assigned To               => perex           
11-14-05 11:02 perex          Status                   new => feedback     
11-14-05 13:39 bladus         Note Added: 0006722                          
11-14-05 13:55 bladus         Note Added: 0006723                          
11-14-05 14:01 perex          Note Added: 0006724                          
11-15-05 16:37 bladus         Note Added: 0006731                          
11-19-05 10:27 bladus         Note Added: 0006761                          
01-10-06 19:37 liiwi          Issue Monitored: liiwi                       
01-10-06 19:58 liiwi          Note Added: 0007552                          
01-26-06 08:35 rolling        Note Added: 0007785                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
