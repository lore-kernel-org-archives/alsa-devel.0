From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001520]: Soundchip was not detected
Date: Mon, 24 Apr 2006 15:59:18 +0200
Message-ID: <437b5465caee385ee3a273e24b681321@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 751BA192
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 15:59:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1520> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1520
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Slackware 9.0
Kernel Version:             2.6.14-rc4
======================================================================
Date Submitted:             11-01-2005 10:35 CET
Last Modified:              04-24-2006 15:59 CEST
======================================================================
Summary:                    Soundchip was not detected
Description: 
I have an HP Omnibook 5700 CTX with some CS423x chip onboard, which is not
detected by alsaconf. I did not find the ids in cs4236.c so I think the
Pnp ID's
must added to this file.


======================================================================

----------------------------------------------------------------------
 rlrevell - 04-24-06 00:27 
----------------------------------------------------------------------
Submitter:  have you made any progress solving this problem?

----------------------------------------------------------------------
 Henne - 04-24-06 15:59 
----------------------------------------------------------------------
I have an idea, but I have not the right idea how to include this thing
cleanly.
I'll have more answers at the end of this weak.

On the CS4232 there is a option to set the resources manually on the chip,
which is the way the oss-driver is using. But this means the driver has to
write to port 0x297, which can be also the LPT1 status port. This could
make problems.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 10:35 Henne          New Issue                                    
11-01-05 10:35 Henne          Distribution              => Slackware 9.0   
11-01-05 10:35 Henne          Kernel Version            => 2.6.14-rc4      
11-08-05 18:48 tiwai          Note Added: 0006637                          
11-08-05 21:00 Henne          Note Added: 0006643                          
11-12-05 19:33 Henne          Note Added: 0006688                          
11-15-05 10:10 Henne          Note Added: 0006729                          
02-06-06 09:34 Henne          Note Added: 0007944                          
03-16-06 13:57 Henne          Note Added: 0008602                          
03-17-06 12:14 tiwai          Note Added: 0008642                          
03-17-06 18:42 Henne          Note Added: 0008650                          
04-24-06 00:02 Adrian Bunk    Issue Monitored: Adrian Bunk                    
04-24-06 00:27 rlrevell       Note Added: 0009446                          
04-24-06 15:59 Henne          Note Added: 0009461                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
