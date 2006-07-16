From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002286]: SB Audigy LS - no sound from
	line-in
Date: Sun, 16 Jul 2006 23:01:26 +0200
Message-ID: <1fa907efa3ad6f94a6d80eda5287cf5a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 502D1222
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Jul 2006 23:01:26 +0200 (MEST)
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


The following issue requires your FEEDBACK.
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
Last Modified:              07-16-2006 23:01 CEST
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
 brazso - 07-16-06 22:18 
----------------------------------------------------------------------
I could restore alsa 1.0.10 with kernel 2.6.15-r8 and with this
configuration the ac97 line (in) works. With alsa 1.0.11 there are more
sliders (line in, mic, phone, aux, CAPTURE, AC97 AUX, AC97 LINE, AC97 MIX
- ones with lowercase exist only in alsa 1.0.11) in the output section of
the mixer, but none of them produces sound from the line in of my audigy
ls card.

----------------------------------------------------------------------
 jcdutton - 07-16-06 23:01 
----------------------------------------------------------------------
Please attach the output of:
amixer scontents


Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 12:31 brazso         New Issue                                    
07-16-06 12:31 brazso         Kernel Version            => 2.6.17-r2       
07-16-06 22:18 brazso         Note Added: 0011030                          
07-16-06 23:01 jcdutton       Note Added: 0011031                          
07-16-06 23:01 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
