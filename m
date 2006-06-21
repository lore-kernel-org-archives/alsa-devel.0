From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Wed, 21 Jun 2006 02:02:34 +0200
Message-ID: <8c12eb6ec14f6bead0988e03258f3392@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 77D0C175
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 02:02:34 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2219> 
======================================================================
Reported By:                El Santo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2219
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian etch (2006-06-18)
Kernel Version:             2.6.15-1-686
======================================================================
Date Submitted:             06-18-2006 17:41 CEST
Last Modified:              06-21-2006 02:02 CEST
======================================================================
Summary:                    snd-mpu401 don't load
Description: 
I have a Aopen MX63LE board with onboard sound managed by snd-via82xx
driver. It loads all necesary modules, includind snd-mpu401-uart, but no
snd-mpu401
The audio part of the driver works perfectly, but the midi port doesn't
work.

In BIOS i can set (and see) the mpu401 port (0x300 or 0x330) but there is
not a MPU401 IRQ setting in bios. When i tried to manually load snd-mpu401
(setting the port accordingly to BIOS) it doesnt work. I don't know the
mpu401 irq setting but i tryed them all. None of them worked. The driver
says "device not found".

Under windows xp the port works perfectly, so the hardware is ok. Anyway
under windows xp, i use a "system inspector" to monitor ioports and irq
usage, and i didnt see any irq assigned for mpu401 port, and the port
(0x330) wasn't occupied neither.

any idea?
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-21-06 00:56 
----------------------------------------------------------------------
Kernel command line: root=/dev/hda2 ro pci=routeirq
Local APIC disabled by BIOS -- you can enable it with "lapic"

Try booting without "pci=routeirq".  Try enabling "lapic".  Try kernel
2.6.17.

If all of the above fail, report the bug on the kernel mailing list
(including dmesg output)

----------------------------------------------------------------------
 rlrevell - 06-21-06 02:02 
----------------------------------------------------------------------
Please disregard my last message - try this instead (from Rene Herman)

"Looking at the driver, please make him provide "mpu_port=0x330" as a 
parameter to snd-via82xx and check if it then works (if it does, there 
is a "VIA82xx MPU401" at 0x330 in /proc/ioports, and aplaymidi -l will 
list the MPU401 UART)."

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 17:41 El Santo       New Issue                                    
06-18-06 17:41 El Santo       Distribution              => Debian etch
(2006-06-18)
06-18-06 17:41 El Santo       Kernel Version            => 2.6.15-1-686    
06-19-06 03:45 Raymond        Note Added: 0010305                          
06-20-06 19:49 tiwai          Note Added: 0010349                          
06-20-06 23:30 El Santo       Note Added: 0010357                          
06-20-06 23:39 rlrevell       Note Added: 0010359                          
06-20-06 23:54 El Santo       Note Added: 0010362                          
06-21-06 00:00 rlrevell       Note Added: 0010363                          
06-21-06 00:04 rlrevell       Note Added: 0010364                          
06-21-06 00:12 El Santo       Note Added: 0010365                          
06-21-06 00:18 rlrevell       Note Added: 0010366                          
06-21-06 00:33 El Santo       File Added: dmesg.log                        
06-21-06 00:36 El Santo       Note Added: 0010367                          
06-21-06 00:52 rlrevell       Note Added: 0010369                          
06-21-06 00:56 rlrevell       Note Added: 0010370                          
06-21-06 02:02 rlrevell       Note Added: 0010374                          
======================================================================
