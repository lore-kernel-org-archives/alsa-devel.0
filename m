From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000631]: card detected but no sound
Date: Tue, 9 Nov 2004 14:30:20 +0100
Message-ID: <dc670c47b8e8bc375f66804bd7ab02a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C771815E
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 14:30:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=631> 
======================================================================
Reported By:                poleta33
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   631
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.4.26-gentoo
======================================================================
Date Submitted:             11-05-2004 16:29 CET
Last Modified:              11-09-2004 14:30 CET
======================================================================
Summary:                    card detected but no sound
Description: 
I've installed alsa with alsaconf... everything runs perfectly but I've got
no sound... (I've tried to unmute amixer with no success).. now i'm
totally lost... I've got one error on dmesg dealing with JEDEC but cannot
solve...

gva1080 distfiles # amixer info
Card default 'I82801BAICH2'/'Intel 82801BA-ICH2 at 0xdc00, irq 17'
  Mixer name    : 'Analog Devices AD1885'
  Components    : 'AC97a'
  Controls      : 36
  Simple ctrls  : 25

gva1080 distfiles # ls -l /dev/dsp
lr-xr-xr-x  1 root root 9 Nov  5 16:24 /dev/dsp -> sound/dsp


======================================================================

----------------------------------------------------------------------
 poleta33 - 11-09-04 14:30 
----------------------------------------------------------------------
solved... don't know exactly how and why...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-04 16:29 poleta33       New Issue                                    
11-05-04 16:29 poleta33       Distribution              => gentoo          
11-05-04 16:29 poleta33       Kernel Version            => 2.4.26-gentoo   
11-09-04 14:30 poleta33       Note Added: 0002321                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
