From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001809]: recording from microphone very quiet on SIS7012
Date: Thu, 2 Feb 2006 09:20:52 +0100
Message-ID: <003bf9db6371d43ddbd2c084d6a527d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A018A1E1
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2006 09:20:52 +0100 (MET)
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
Last Modified:              02-02-2006 09:20 CET
======================================================================
Summary:                    recording from microphone very quiet on SIS7012
Description: 
I have an integrated onboard sound card with chipset SIS7012. I us ALSA and
the driver is intel8x0. When I record from line in, everything seems to be
ok. However, when I try to record from the microphone, the recorded signal
is very quiet (low). I used alsamixer to maximize the capturing level and
turned on the +20dB microfone amplification, but it did not help.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 09:20 piotr_sobolewskiNew Issue                                    
02-02-06 09:20 piotr_sobolewskiFile Added: test1.wav.bz2                    
02-02-06 09:20 piotr_sobolewskiDistribution              => Debian          
02-02-06 09:20 piotr_sobolewskiKernel Version            => 2.6.13.4        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
