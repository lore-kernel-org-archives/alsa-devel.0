From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000535]: via82xx: "codec 0 is not valid..."
Date: Tue, 9 Nov 2004 18:34:20 +0100
Message-ID: <181714ec7dcce69b100da65e34d4b064@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 960A72B6
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 18:34:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=535> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   535
Category:                   PCI - via82xx
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2004 14:29 CEST
Last Modified:              11-09-2004 18:34 CET
======================================================================
Summary:                    via82xx: "codec 0 is not valid..."
Description: 
Trying to play any sound at all generates lines like this in the syslog:

kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/via82xx.c:588:
codec_read: codec 0 is not valid [0xfe0000]
kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/via82xx.c:727:
invalid via82xx_cur_ptr, using last valid pointer


with no sound ever being produced.  I don't know anything about sound
hardware, so don't know what other information you need.  It's an onboard
chip, listed in the debconf data below.



======================================================================

----------------------------------------------------------------------
 jdthood - 11-05-04 11:53 
----------------------------------------------------------------------
In reply to the "turn off ACPI" suggestion the submitter replies "No
change".

----------------------------------------------------------------------
 tiwai - 11-09-04 18:34 
----------------------------------------------------------------------
The first message (codec 0...) is likely harmless.  I know other devices 
show the same message but working.

The second one (using last ptr) is more serious, but the system should
still work, at least produce some sounds.
The fact that he doesn't get any sound implies that the mixer
configuration is not properly done.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 14:29 jdthood        New Issue                                    
09-24-04 14:54 tiwai          Note Added: 0001889                          
11-05-04 11:53 jdthood        Note Added: 0002306                          
11-09-04 18:34 tiwai          Note Added: 0002330                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
