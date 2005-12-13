From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000949]: Randomly, left and right tracks are swaped
Date: Tue, 13 Dec 2005 12:50:17 +0100
Message-ID: <2bfadfbfa3590de58e19140a961970c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0454018A
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:50:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=949> 
======================================================================
Reported By:                NorbertB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   949
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:              2.4.21-20.ELsmp
======================================================================
Date Submitted:             02-28-2005 00:08 CET
Last Modified:              12-13-2005 12:50 CET
======================================================================
Summary:                    Randomly, left and right tracks are swaped
Description: 
I'm running ALSA 1.0.8 on an APro 6224 (AMD8111, ac97' chipset Realtek
ALC655).
alsamixer is on, I can hear my audio OK but sometimes, randomly, left and
right channels are swapped.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000059 On au8820 left and right channels are s...
has duplicate       0000403 intel8x0 driver swaps channels
======================================================================

----------------------------------------------------------------------
 phox - 03-23-05 02:30 
----------------------------------------------------------------------
I should mention that I (the reporter of bug 0000403 mentioned above) am
also using an AMD8111-based board, the Tyan Thunder K8W (S2885ANRF), and
of course using the integrated Analog Devices 1981B chip.

----------------------------------------------------------------------
 jdthood - 12-13-05 12:50 
----------------------------------------------------------------------
NorbertB, phox: Any improvement in 1.0.10?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-05 00:08 NorbertB       New Issue                                    
02-28-05 00:08 NorbertB       Kernel Version            =>  2.4.21-20.ELsmp
03-22-05 22:30 jdthood        Relationship added       has duplicate 0000403
03-22-05 22:33 jdthood        Relationship added       related to 0000059  
03-23-05 02:30 phox           Note Added: 0004149                          
12-13-05 12:50 jdthood        Note Added: 0007004                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
