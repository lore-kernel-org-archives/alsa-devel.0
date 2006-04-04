From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001980]: No Sound with module snd-hda-intel and no error output
Date: Tue, 4 Apr 2006 09:23:05 +0200
Message-ID: <8fb9f3a260ff019c6fbebd170741d7ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 221731A6
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 09:23:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1980> 
======================================================================
Reported By:                zyfhie
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1980
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu
Kernel Version:             2.6.15-19-386
======================================================================
Date Submitted:             03-30-2006 14:43 CEST
Last Modified:              04-04-2006 09:23 CEST
======================================================================
Summary:                    No Sound with module snd-hda-intel and no error
output
Description: 
I just have ubuntu installed in my laptop,and there is no sound at all.
In dmesg|grep hda-intel there is no message,but I could see 
[4296289.511000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[4296330.997000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level,
low) -> IRQ 201
[4296330.997000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
 
after rmmod snd-hda-intel &modprobe snd-hda-intel

I had tried many parm in my alsa-base such as model,position_fix.
Hope somebody could help!!! 

======================================================================

----------------------------------------------------------------------
 zyfhie - 04-03-06 09:03 
----------------------------------------------------------------------
cat /sys/module/snd_hda_intel/parameters/model
asus

----------------------------------------------------------------------
 zyfhie - 04-04-06 09:23 
----------------------------------------------------------------------
Finally I'm loading with "model=laptop-eapd" and it works:)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-06 14:43 zyfhie         New Issue                                    
03-30-06 14:43 zyfhie         Distribution              => ubuntu          
03-30-06 14:43 zyfhie         Kernel Version            => 2.6.15-19-386   
04-01-06 00:28 error10        Note Added: 0009051                          
04-03-06 01:57 anarki         Note Added: 0009076                          
04-03-06 02:12 zyfhie         Note Added: 0009078                          
04-03-06 02:46 zyfhie         Note Added: 0009079                          
04-03-06 03:22 zyfhie         Note Added: 0009082                          
04-03-06 05:52 rlrevell       Note Added: 0009083                          
04-03-06 09:03 zyfhie         Note Added: 0009090                          
04-04-06 09:23 zyfhie         Note Added: 0009110                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
