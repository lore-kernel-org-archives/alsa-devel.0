From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000624]: crash with alc850 when driver alsa intel8x0 is use
Date: Tue, 9 Nov 2004 10:47:57 +0100
Message-ID: <0caef663b9f26fc1ced08aa78a1604a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A2D3259
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 10:47:58 +0100 (MET)
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
Last Modified:              11-09-2004 10:47 CET
======================================================================
Summary:                    crash with alc850 when driver alsa intel8x0 is use
Description: 
When mandrakelinux boot and when a song is played then the song is stopped
and the acess to internet is stopped too.

This problem isreproducibility every days and allways.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 10:46 
----------------------------------------------------------------------
Please elaborate your system environment.  The internet access is
through ethernet?  Is the same interrupt shared between the sound
and the eth chips?

----------------------------------------------------------------------
 tiwai - 11-09-04 10:47 
----------------------------------------------------------------------
Also, please elaborate the symptom more precisely.
Does the system "crash"?  (i.e. you have to reboot), or just the
network connection stops?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 20:24 xmoucheron     New Issue                                    
11-02-04 20:24 xmoucheron     Kernel Version            => 2.6.8.1 mdk     
11-04-04 13:36 xmoucheron     Note Added: 0002304                          
11-09-04 10:46 tiwai          Note Added: 0002318                          
11-09-04 10:47 tiwai          Note Added: 0002319                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
