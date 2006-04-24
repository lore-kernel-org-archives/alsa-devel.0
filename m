From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002013]: no digital output
Date: Mon, 24 Apr 2006 20:30:22 +0200
Message-ID: <5d986414552f75d472de73e7d99d4e89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB2C1174
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 20:30:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2013> 
======================================================================
Reported By:                SamiH
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2013
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               BLFS
Kernel Version:             2.6.15.4
======================================================================
Date Submitted:             04-09-2006 11:43 CEST
Last Modified:              04-24-2006 20:30 CEST
======================================================================
Summary:                    no digital output
Description: 
Shortly: Digital output doesn't work at all, or I don't know how to use
it.

This has been my problem quite long time now. I have upgraded my kernel
from  2.6.8 to 2.6.15.4 with some steps bitween those versions, and the
problem is still here. I have tried some live-cds with same results as my
stable system.

Analog stereo output works with no problems. If someone did tell me what I
should test on my system so that I could give the results to you.

These aren't broken:
 * my external amplifier
 * the digital coaxial cable
 * speakers etc.

Please tell me at least what to do, what to search for, or something...
======================================================================

----------------------------------------------------------------------
 tiwai - 04-20-06 15:22 
----------------------------------------------------------------------
Don't ever use hw unless you know what you're doing.

Try
   % aplay -Dplug:spdif something.wav

----------------------------------------------------------------------
 SamiH - 04-24-06 20:30 
----------------------------------------------------------------------
My computer broked and the motherboard is in repair, so I cannot test that
now. Thanks anyway, I'll test it when I get my computer working again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-09-06 11:43 SamiH          New Issue                                    
04-09-06 11:43 SamiH          Distribution              => BLFS            
04-09-06 11:43 SamiH          Kernel Version            => 2.6.15.4        
04-10-06 16:50 tiwai          Note Added: 0009198                          
04-13-06 21:10 SamiH          File Added: alsa.txt                         
04-13-06 21:22 SamiH          Note Added: 0009269                          
04-13-06 21:26 SamiH          Note Edited: 0009269                         
04-20-06 15:22 tiwai          Note Added: 0009382                          
04-24-06 20:30 SamiH          Note Added: 0009476                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
