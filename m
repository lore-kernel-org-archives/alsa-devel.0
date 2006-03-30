From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001809]: recording from microphone very quiet on SIS7012
Date: Thu, 30 Mar 2006 09:03:53 +0200
Message-ID: <6b537fc7fb082ac47b6ffa08c0b74ea1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D8A3191
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 09:03:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1809> 
======================================================================
Reported By:                piotr_sobolewski
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1809
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.13.4
======================================================================
Date Submitted:             02-02-2006 09:20 CET
Last Modified:              03-30-2006 09:03 CEST
======================================================================
Summary:                    recording from microphone very quiet on SIS7012
Description: 
I have an integrated onboard sound card with chipset SIS7012. I us ALSA and
the driver is intel8x0. When I record from line in, everything seems to be
ok. However, when I try to record from the microphone, the recorded signal
is very quiet (low). I used alsamixer to maximize the capturing level and
turned on the +20dB microfone amplification, but it did not help.
======================================================================

----------------------------------------------------------------------
 hweigel - 03-30-06 09:03 
----------------------------------------------------------------------
I have seen a similar problem with ALC260, it is reported under issue
#1618.It might be connected to the micro needing a bias voltage.
For ALC260 the problem has been solved within alsa-1.0.11rc4

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 09:20 piotr_sobolewskiNew Issue                                    
02-02-06 09:20 piotr_sobolewskiFile Added: test1.wav.bz2                    
02-02-06 09:20 piotr_sobolewskiDistribution              => Debian          
02-02-06 09:20 piotr_sobolewskiKernel Version            => 2.6.13.4        
02-02-06 09:34 piotr_sobolewskiIssue Monitored: piotr_sobolewski                
   
02-03-06 12:11 hweigel        Issue Monitored: hweigel                     
03-30-06 09:03 hweigel        Note Added: 0009022                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
