From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000740]: SPDIF Broken
Date: Tue, 21 Dec 2004 23:55:34 +0100
Message-ID: <1c653f1bdbafc99c3b010e5569c33994@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BCFC824A
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2004 23:55:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=740> 
======================================================================
Reported By:                nostar
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   740
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-21-2004 23:55 CET
Last Modified:              12-21-2004 23:55 CET
======================================================================
Summary:                    SPDIF Broken
Description: 
S/PDIF appears to be broken in the ice1712 driver on recent versions of
alsa.  I used to use it fine on 2.4 kernels (alsa 1.0 - 1.0.3), then I
quit using it for a while.  Now on 2.6 / 1.0.7 (cvs) I can't get S/PDIF to
work. I get silence untill I start screwing with Master Clock settings in
envy24control, then I get loud white noise.  I was able to get correct
sound once, by doing the following:

Revert from 1.0.7(cvs) to 1.0.4 (driver, lib, and envy24control).  I load
the driver, then I start jack, then I play a file via xmms (using
xmms-jack of course), then run envy24control, and click 'Word Clock' as
Master Clock.  If I do this in exactly this order I get sound.  If I click
any other Clock setting I get white noise that cant be reversed untill I
unload the driver.

I went back to 1.0.7 (cvs) to do the same thing, but when I click Word
Clock it doesnt stay, it immediately jumps back to its original state
(usually Internal 48000).  I can hear the audio for a split second
everytime I click Word Clock.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-04 23:55 nostar         New Issue                                    
12-21-04 23:55 nostar         Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
