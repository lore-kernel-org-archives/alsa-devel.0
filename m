From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001457]: Lagged sound
Date: Thu, 17 Nov 2005 10:56:12 +0100
Message-ID: <162df9fc232f2606e39d347eb612136c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 280551C5
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2005 10:56:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1457> 
======================================================================
Reported By:                mouse
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1457
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               ALT Linux
Kernel Version:             from 2.6.10 to 2.6.12
======================================================================
Date Submitted:             09-25-2005 12:56 CEST
Last Modified:              11-17-2005 10:56 CET
======================================================================
Summary:                    Lagged sound
Description: 
Played music a bit lagged and in dmesg I see:
vortex: IRQ fifo error
======================================================================

----------------------------------------------------------------------
 mouse - 11-17-05 09:10 
----------------------------------------------------------------------
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX
Host bridge (rev 02)
0000:00:02.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)

from /proc/interrupts:
11:     176596          XT-PIC  ide2, ide3, au8830,
radeon@pci:0000:01:00.0

----------------------------------------------------------------------
 Raymond - 11-17-05 10:56 
----------------------------------------------------------------------
Which application are you using to play music ?

http://developer.intel.com/technology/iapc/involve.htm

Although the windows drivers are ACPI compliant, the ALSA au88x0 driver do
not support suspend/resume.

My au8830 works fine (including 10-bands stereo equalizer) except the
front/rear channels are swapped.

Does the front/rear channels swap occur on your MX300 ?

Which AC97 codec is on your MX300 ?

speaker-test -c 4

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 12:56 mouse          New Issue                                    
09-25-05 12:56 mouse          Distribution              => ALT Linux       
09-25-05 12:56 mouse          Kernel Version            => from 2.6.10 to 2.6.12
09-25-05 13:00 mouse          Note Added: 0006386                          
09-25-05 13:00 mouse          File Added: au8830                           
11-16-05 13:05 Raymond        Note Added: 0006739                          
11-17-05 09:10 mouse          Note Added: 0006746                          
11-17-05 10:56 Raymond        Note Added: 0006747                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
