From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001491]: Onboard sound of HP Kayak workstation isn't detected properly
Date: Sat, 25 Feb 2006 09:54:22 +0100
Message-ID: <8c4f292b4e0f15a2ed60ce5e674072ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 300D617B
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2006 09:54:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1491> 
======================================================================
Reported By:                mmp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1491
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:              2.6.11-1-smp
======================================================================
Date Submitted:             10-21-2005 23:10 CEST
Last Modified:              02-25-2006 09:54 CET
======================================================================
Summary:                    Onboard sound of HP Kayak workstation isn't detected
properly
Description: 
Detection of AD1816AJS chip contained on the board of HP Kayak workstation
(chipset i440LX) is not detected by ALSA - tested in both PnP and non-PnP
mode. With legacy OSS driver it works fine in non-PnP mode (PnP probably
doesn't work), but there's need to hard-write all parameters like io, irq,
dma and so...
======================================================================

----------------------------------------------------------------------
 axion - 02-25-06 09:54 
----------------------------------------------------------------------
This problem still exists in latest kernel 2.6.15.3.

The original OSS driver works, but can not be combined with alsa compliant
cards.
When using the original OSS driver in combination with an alsa driver-card
udev does not create correct devices.

Example of devices when only using original oss driver:

crw-rw--w-  1 root audio 14, 4 2006-02-25 09:01 audio
crw-rw--w-  1 root audio 14, 3 2006-02-25 09:01 dsp
crw-rw--w-  1 root audio 14, 0 2006-02-25 09:01 mixer
crw-rw--w-  1 root audio 14, 1 2006-02-25 09:01 sequencer
crw-rw--w-  1 root audio 14, 8 2006-02-25 09:01 sequencer2

Example of devices combining oss and alsa driver:

crw-rw--w-  1 root audio 14, 12 2006-02-25 09:52 adsp
crw-rw--w-  1 root audio 14,  4 2006-02-25 09:01 audio
crw-rw--w-  1 root audio 14,  3 2006-02-25 09:01 dsp
crw-rw--w-  1 root audio 14,  0 2006-02-25 09:01 mixer
crw-rw--w-  1 root audio 14,  1 2006-02-25 09:01 sequencer
crw-rw--w-  1 root audio 14,  8 2006-02-25 09:01 sequencer2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 23:10 mmp            New Issue                                    
10-21-05 23:10 mmp            Distribution              => Debian GNU/Linux
10-21-05 23:10 mmp            Kernel Version            =>  2.6.11-1-smp   
02-25-06 09:54 axion          Note Added: 0008186                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
