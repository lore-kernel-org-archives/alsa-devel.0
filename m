From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001942]: [PATCH] added support uncommon "rate"
Date: Mon, 20 Mar 2006 09:09:42 +0100
Message-ID: <f779c93190260043fc363e6607ee2646@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 045EC1F3
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 09:09:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1942> 
======================================================================
Reported By:                os-bebas
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1942
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               UBuntu Dapper Drake
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-18-2006 23:48 CET
Last Modified:              03-20-2006 09:09 CET
======================================================================
Summary:                    [PATCH] added support uncommon "rate"
Description: 
attached you can find a simple patch to match
"uncommon" rate in some USB speaker to the fixed
conv_rates in usbaudio.c.

Signed-off-by: S. Effendi <osbebas@yahoo.co.id>

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-20-06 09:09 
----------------------------------------------------------------------
Your patch assumes that every device that doesn't happen to support one of
the predefined rates is lying and actually does use the next-smaller rate
instead.
This assumptions is wrong for most devices, and probably for yours, too.

What is the output of "time dd if=/dev/zero of=/dev/dsp1 bs=1000
count=10000"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-18-06 23:48 os-bebas       New Issue                                    
03-18-06 23:48 os-bebas       File Added: alsa_usbaudio_conv_rates_fixed.patch  
                 
03-18-06 23:48 os-bebas       Distribution              => UBuntu Dapper Drake
03-18-06 23:48 os-bebas       Kernel Version            => 2.6.15.6        
03-20-06 09:09 Clemens LadischNote Added: 0008712                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
