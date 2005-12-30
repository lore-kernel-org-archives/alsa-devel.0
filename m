From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000740]: SPDIF Broken
Date: Fri, 30 Dec 2005 04:38:42 +0100
Message-ID: <732900cb5766293066c7a7e1a9431836@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D982E1A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:38:42 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             2.6.9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-21-2004 23:55 CET
Last Modified:              12-30-2005 04:38 CET
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

----------------------------------------------------------------------
 jdthood - 04-09-05 17:32 
----------------------------------------------------------------------
Submitter: Do you see any improvement in the 1.0.8 release?

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:38 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-04 23:55 nostar         New Issue                                    
12-21-04 23:55 nostar         Kernel Version            => 2.6.9           
04-09-05 17:32 jdthood        Note Added: 0004425                          
12-30-05 04:38 rlrevell       Status                   new => closed       
12-30-05 04:38 rlrevell       Note Added: 0007215                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
