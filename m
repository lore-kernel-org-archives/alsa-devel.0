From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Wed, 21 Jun 2006 00:18:21 +0200
Message-ID: <a952fd6f9a31bfe0f61e0a2199bf0cf1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8CB5E187
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 00:18:21 +0200 (MEST)
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
Last Modified:              06-21-2006 00:18 CEST
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
 El Santo - 06-21-06 00:12 
----------------------------------------------------------------------
i can set (or see) the MPU401 io port in BIOS but i can not set (or see)
the MPU401 IRQ.

The port is enabled and it works with windows xp

----------------------------------------------------------------------
 rlrevell - 06-21-06 00:18 
----------------------------------------------------------------------
It must be a kernel bug if the port does not appear in /proc/ioports.

Please attach dmesg output (do not paste it inline)

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
======================================================================
