From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001809]: recording from microphone very quiet on SIS7012
Date: Mon, 27 Mar 2006 09:49:59 +0200
Message-ID: <fcba2a09217d77a054f916f1efbdbe56@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF773196
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 09:49:59 +0200 (MEST)
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
Last Modified:              03-27-2006 09:49 CEST
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
 hweigel - 03-27-06 09:49 
----------------------------------------------------------------------
Hi,

I have seen the same problem with SIS7012 on Suse 9.1.
All sound applications except of the microphone work.
To it seems similar to issue 1618, ie using a condensor
mircophone requires some DC bias to work but that is
not included in the driver.

Regards,
Herbert.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 09:20 piotr_sobolewskiNew Issue                                    
02-02-06 09:20 piotr_sobolewskiFile Added: test1.wav.bz2                    
02-02-06 09:20 piotr_sobolewskiDistribution              => Debian          
02-02-06 09:20 piotr_sobolewskiKernel Version            => 2.6.13.4        
02-02-06 09:34 piotr_sobolewskiIssue Monitored: piotr_sobolewski                
   
02-03-06 12:11 hweigel        Issue Monitored: hweigel                     
03-27-06 09:49 hweigel        Note Added: 0008993                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
