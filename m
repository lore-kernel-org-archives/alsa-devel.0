From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002286]: SB Audigy LS - no sound from
	line-in
Date: Mon, 17 Jul 2006 10:16:27 +0200
Message-ID: <35dd73263bbb86cafe7dc983defda199@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D3AE163
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 10:16:27 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2286> 
======================================================================
Reported By:                brazso
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2286
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.17-r2
======================================================================
Date Submitted:             07-16-2006 12:31 CEST
Last Modified:              07-17-2006 10:16 CEST
======================================================================
Summary:                    SB Audigy LS - no sound from line-in
Description: 
Last time when I used the line-in connector of my SB Audigy LS card a half
year ago, there was no problem with it. By now I wanted to digitalise some
stuff, but my line-in is dumb. Since I often update my gentoo portage tree
included the alsa-drivers, I'm sure that with alsa-driver-1.0.11rc1 dated
on 12/13/05 it still worked. Unfortunately I cannot say more when it went
wrong precisely, because all of my attempts to restore an earlier alsa
version than 1.0.11 were failed. With kernel 2.6.17-r2 alsa 1.0.10,
1.0.11rc1 and 1.0.11rc2 cannot be compiled, and although I could install
alsa 1.0.11rc3, but the mixer did not include my line-in for unknown
reason.

======================================================================

----------------------------------------------------------------------
 jcdutton - 07-16-06 23:01 
----------------------------------------------------------------------
Please attach the output of:
amixer scontents


----------------------------------------------------------------------
 brazso - 07-17-06 10:16 
----------------------------------------------------------------------
Thanks for your response, I attached the requested output content. Of
course I tried to switch on the 'Line in' and 'AC97 Line' separately, I
also played with the others without any success on 1.0.11. By the way,
what is the difference between the 2 'line in' sliders? In alsa 1.0.10
mixer there was just 'AC97 Line' slider.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 12:31 brazso         New Issue                                    
07-16-06 12:31 brazso         Kernel Version            => 2.6.17-r2       
07-16-06 22:18 brazso         Note Added: 0011030                          
07-16-06 23:01 jcdutton       Note Added: 0011031                          
07-16-06 23:01 jcdutton       Status                   assigned => feedback
07-17-06 10:15 brazso         File Added: amixer_scontents.txt                  
 
07-17-06 10:16 brazso         Note Added: 0011037                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
