From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000225]: No PCM-mixer on Epox 8RDA3I
	and no sound
Date: Tue, 11 Jul 2006 12:43:44 +0200
Message-ID: <3c3b6fc6b440301284e41c94d635bff9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3652E223
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 12:43:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=225> 
======================================================================
Reported By:                qeldroma
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   225
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               gentoo 2004.1
Kernel Version:             2.6.5-gentoo-dev-sources
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             04-20-2004 10:50 CEST
Last Modified:              07-11-2006 12:43 CEST
======================================================================
Summary:                    No PCM-mixer on Epox 8RDA3I and no sound
Description: 
I recently changed from a leadtek nforce2 board to the epox nforce2 board.
AFAIK, they got both the same onboard audio chip, so i didn't changed any
setting i had done for the leadtek, because i could keep them in my eyes.

But now, all is working well (xmms even shows the equalizer going up and
down!), but i can't hear anything.

First i thought, sthg. is muted, but a look at "alsamixer" told me, that
all is up and unmuted. Only PCM is not changeable and keeps at 0%.

>From the leadtek i know, that PCM is the main-volume tab in alsa, so i
think, that this broken PCM-mixer is the reason fro the broken alsa.

Btw, i am not the only person with this fault.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000255 CM9739 does not sound
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 15:45 
----------------------------------------------------------------------
Submitter: Problems like this are often the result of faulty mixer
settings.
Were you ever able to resolve the problem, e.g., by adjusting mixer
settings
with gamix or by upgrading your ALSA drivers to the latest release?

----------------------------------------------------------------------
 jdthood - 03-23-05 16:06 
----------------------------------------------------------------------
Please send the output of

   lsmod
   uname -a
   lspci
   cat /proc/asound/version
   cat /proc/asound/cards

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-04 10:50 qeldroma       New Issue                                    
04-20-04 10:50 qeldroma       Distribution              => gentoo 2004.1   
04-20-04 10:50 qeldroma       Kernel Version            =>
2.6.5-gentoo-dev-sources
04-20-04 12:28 tiwai          Note Added: 0000871                          
04-20-04 12:39 qeldroma       Note Added: 0000873                          
03-23-05 15:45 jdthood        Note Added: 0004165                          
03-23-05 15:45 jdthood        Relationship added       has duplicate 0000255
03-23-05 16:06 jdthood        Note Added: 0004172                          
04-18-06 04:01 segfault       Issue Monitored: segfault                    
07-11-06 12:43 Adrian Bunk    Status                   new => closed       
07-11-06 12:43 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
