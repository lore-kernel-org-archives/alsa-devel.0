From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001994]: alsa-oss dont use dmix
Date: Thu, 20 Apr 2006 15:35:24 +0200
Message-ID: <2549db350e946a04f65463e35bcda989@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 399B021E
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 15:35:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1994> 
======================================================================
Reported By:                crissi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1994
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-02-2006 19:45 CEST
Last Modified:              04-20-2006 15:35 CEST
======================================================================
Summary:                    alsa-oss dont use dmix
Description: 
The alsa-oss module doesnt use the dmix module but it should.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-02-06 19:58 
----------------------------------------------------------------------
Works for me:

$ ALSA_OSS_DEBUG=1 aoss /usr/bin/play /usr/share/sounds/error.wav 
Opened PCM dsp0 for stream 0 (result = -2)
Opened PCM default for stream 0 (result = 0)
           ^^^^^^^

'default' should be defined to use dmix with no need for .asoundrc.

The in-kernel OSS emulation can't be made to use dmix - you must use aoss.

----------------------------------------------------------------------
 tiwai - 04-20-06 15:35 
----------------------------------------------------------------------
Maybe using an older version?  It should work in 1.0.11, so closing this
now.
Reopen if you still have the same problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-06 19:45 crissi         New Issue                                    
04-02-06 19:58 rlrevell       Note Added: 0009069                          
04-20-06 15:35 tiwai          Status                   new => resolved     
04-20-06 15:35 tiwai          Resolution               open => fixed       
04-20-06 15:35 tiwai          Assigned To               => tiwai           
04-20-06 15:35 tiwai          Note Added: 0009387                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
