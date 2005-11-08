From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001537]: no dmix by default for snd_i8x0
Date: Tue, 8 Nov 2005 22:59:35 +0100
Message-ID: <77d7badd7c2e3ceba497bc5adb3a978e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFE431DA
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 22:59:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1537> 
======================================================================
Reported By:                fhimpe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1537
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-08-2005 22:59 CET
Last Modified:              11-08-2005 22:59 CET
======================================================================
Summary:                    no dmix by default for snd_i8x0
Description: 
I have a Thinkpad R52, with Intel integrated sound chip:

 00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
        Subsystem: IBM: Unknown device 0567
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 1c00 [size=256]
        I/O ports at 1880 [size=64]
        Memory at a8000800 (32-bit, non-prefetchable) [size=512]
        Memory at a8000400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

It is working fine with the module snd_intel8x0.

This device does not support hardware mixing, and dmix was not enabled by
default, causing all kind of problems (some applications even
crashing/hanging when trying to access sound devices at the same time).

I could enable dmix by putting this in /etc/asound.conf:
pcm.dsp0 {
    type plug
    slave.pcm dmix
}
ctl.mixer0 {
    type hw
    card 0
}

Kernel used is 2.6.14-archck1 (alsa 1.0.10rc1 IIRC).
Userland tools:
libalsa-data-1.0.10-0.rc3.1mdk
libalsa2-1.0.10-0.rc3.1mdk
libalsa2-devel-1.0.10-0.rc3.1mdk
alsa-utils-1.0.10-0.rc3.1mdk

dmix should be enabled by default for this device.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 22:59 fhimpe         New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
