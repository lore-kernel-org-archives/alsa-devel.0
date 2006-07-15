From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000347]: Driver works with xmms,
	but not with kino or dvgrab
Date: Sat, 15 Jul 2006 22:06:49 +0200
Message-ID: <19a78f8f7d25ab06447545c9e8050bb7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40B1D11E
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 22:06:50 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=347> 
======================================================================
Reported By:                winjer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   347
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.7
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             06-26-2004 14:44 CEST
Last Modified:              07-15-2006 22:06 CEST
======================================================================
Summary:                    Driver works with xmms, but not with kino or dvgrab
Description: 
I get fine sound playing with xmms, but when I try to grab dv via firewire
from my camcorder the sound is badly out of sync with the pictures and is
much slower.

When I switch to my second soundcard, an es1371, grabbing dv works
perfectly.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 21:01 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?
Do you have the necessary device files in /dev/snd/?
Are you using udev, devfs or static device files?

----------------------------------------------------------------------
 winjer - 04-22-05 14:07 
----------------------------------------------------------------------
This motherboard blew up a few weeks ago, so now I'm unable to test
unfortunately.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 14:44 winjer         New Issue                                    
06-26-04 14:44 winjer         Distribution              => Debian GNU/Linux
06-26-04 14:44 winjer         Kernel Version            => 2.6.7           
06-30-04 16:36 tiwai          Note Added: 0001358                          
07-04-04 16:21 winjer         Note Added: 0001380                          
04-07-05 21:01 jdthood        Note Added: 0004367                          
04-22-05 14:07 winjer         Note Added: 0004554                          
07-15-06 22:06 Adrian Bunk    Status                   new => closed       
07-15-06 22:06 Adrian Bunk    Resolution               open => unable to
duplicate
07-15-06 22:06 Adrian Bunk    Description Updated                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
