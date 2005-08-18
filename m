From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001346]: Nforce3-250 has no working support for front microphone
Date: Thu, 18 Aug 2005 23:01:22 +0200
Message-ID: <4869503455a34dc25a5323260e84123d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8B10322C
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2005 23:01:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1346> 
======================================================================
Reported By:                alchemyx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1346
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.12
======================================================================
Date Submitted:             08-17-2005 11:04 CEST
Last Modified:              08-18-2005 23:01 CEST
======================================================================
Summary:                    Nforce3-250 has no working support for front
microphone
Description: 
I have nforce3-250 based motherboard. It uses i8x0 drivers for its sound
chip, my output from lspci:

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb
AC'97 Audio Controller (rev a1)
        Subsystem: Giga-byte Technology: Unknown device a002
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 21
        I/O ports at e000
        I/O ports at e400 [size=128]
        Memory at fa002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

That soundcard is supported quite well. Playing and also recording sounds
just fine. Only problem is that I have front audio panel built in my case,
where I can connect microphone and headphones. Headphones work fine, but I
can't get recording from microphone connected to front panel.

Tweaking with mixer didn't help. Only solution was to use binary nvsound
from nvidia drivers which is, to be honest, poor quality. Also it works
fine under Windows.

So it seems that there is something missing or wrong in current i8x0
driver.
======================================================================

----------------------------------------------------------------------
 jirka - 08-18-05 18:43 
----------------------------------------------------------------------
This bug is probably duplicate of my bug #1232

https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=1232

try to record some very loud sound and maybe you will find that is is
actually recorder, but with very very very low volume.

----------------------------------------------------------------------
 alchemyx - 08-18-05 23:01 
----------------------------------------------------------------------
You are completly right. I can hear myself, but I need to turn up the
volume to the max and almost scream to the mic! :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 11:04 alchemyx       New Issue                                    
08-17-05 11:04 alchemyx       Distribution              => Gentoo          
08-17-05 11:04 alchemyx       Kernel Version            => 2.6.12          
08-18-05 18:43 jirka          Note Added: 0005851                          
08-18-05 23:01 alchemyx       Note Added: 0005859                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
