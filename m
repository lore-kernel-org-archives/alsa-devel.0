From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002142]: no more microphone
Date: Mon, 22 May 2006 12:12:52 +0200
Message-ID: <62c68ddf61c73119a07ec9df35809431@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBB09175
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2006 12:12:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2142> 
======================================================================
Reported By:                piem
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2142
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.17-rc3
======================================================================
Date Submitted:             05-22-2006 12:12 CEST
Last Modified:              05-22-2006 12:12 CEST
======================================================================
Summary:                    no more microphone
Description: 
I haven't been able to access the microphone on my iBook G4 since at least
2.6.12 and up to 2.6.17-rc3. The chip is a Snapper, and microphone
recording used to be supported. Debian package alsa-utils 1.0.11-2 is
installed.

$ cat /proc/asound/cards
 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                      PowerMac Snapper (Dev 38) Sub-frame 0

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 533.333000MHz
revision        : 0.1 (pvr 8003 0101)
bogomips        : 36.73
timebase        : 18432000
platform        : PowerMac
machine         : PowerBook6,5
motherboard     : PowerBook6,5 MacRISC3 Power Macintosh 
detected as     : 287 (iBook G4)
pmac flags      : 0000001b
L2 cache        : 512K unified
pmac-generation : NewWorld

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 12:12 piem           New Issue                                    
05-22-06 12:12 piem           Distribution              => Debian          
05-22-06 12:12 piem           Kernel Version            => 2.6.17-rc3      
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
