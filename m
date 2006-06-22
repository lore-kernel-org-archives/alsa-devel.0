From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Thu, 22 Jun 2006 14:30:57 +0200
Message-ID: <f286bcfe97baa450e07f3f49c9111865@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7825D220
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jun 2006 14:30:57 +0200 (MEST)
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
Last Modified:              06-22-2006 14:30 CEST
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
 rlrevell - 06-22-06 03:29 
----------------------------------------------------------------------
What does that have to do with the driver failing to detect the MPU port?

----------------------------------------------------------------------
 Raymond - 06-22-06 14:30 
----------------------------------------------------------------------
May be via82c686b cannot use PCI BAR2 as mpu port when it BAR2 is > 0x1000


e400-e403 : 0000:00:07.5
  e400-e403 : VIA686A

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
06-21-06 04:51 Raymond        Note Added: 0010379                          
06-21-06 18:00 El Santo       Note Added: 0010400                          
06-22-06 03:19 Raymond        Note Added: 0010412                          
06-22-06 03:27 Raymond        Note Edited: 0010412                         
06-22-06 03:29 rlrevell       Note Added: 0010413                          
06-22-06 14:30 Raymond        Note Added: 0010422                          
======================================================================



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
