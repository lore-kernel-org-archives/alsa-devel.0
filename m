From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000624]: crash with alc850 when driver alsa intel8x0 is use
Date: Thu, 11 Nov 2004 14:59:33 +0100
Message-ID: <24d459f92d725f398417596088fe169b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2DD1F272
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2004 14:59:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=624> 
======================================================================
Reported By:                xmoucheron
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   624
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1 mdk
======================================================================
Date Submitted:             11-02-2004 20:24 CET
Last Modified:              11-11-2004 14:59 CET
======================================================================
Summary:                    crash with alc850 when driver alsa intel8x0 is use
Description: 
When mandrakelinux boot and when a song is played then the song is stopped
and the acess to internet is stopped too.

This problem isreproducibility every days and allways.
======================================================================

----------------------------------------------------------------------
 xmoucheron - 11-11-04 14:48 
----------------------------------------------------------------------
I come to install the mandrakelinux 10.1  64bit edition with alsa driver
1.0.6 and the problem with this driver (intel 8x0) on mandrakelinux 64bit
is most important.

There is none sound with this version 64bit with alsa 1.0.6.

----------------------------------------------------------------------
 tiwai - 11-11-04 14:59 
----------------------------------------------------------------------
Perhaps when the "crash" occurs, you get a kernel message something like
"interrupt disabled".
If so, it's basically not a problem of the driver but because of purious
interrupts by unknown device - likely a BIOS problem.
As a workaround, you can set "buggy_irq=1" module option to snd-intel8x0
(for ALSA 1.0.7).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 20:24 xmoucheron     New Issue                                    
11-02-04 20:24 xmoucheron     Kernel Version            => 2.6.8.1 mdk     
11-04-04 13:36 xmoucheron     Note Added: 0002304                          
11-09-04 10:46 tiwai          Note Added: 0002318                          
11-09-04 10:47 tiwai          Note Added: 0002319                          
11-10-04 21:12 xmoucheron     Note Added: 0002376                          
11-10-04 21:16 xmoucheron     Note Edited: 0002376                         
11-11-04 14:48 xmoucheron     Note Added: 0002386                          
11-11-04 14:59 tiwai          Note Added: 0002387                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
