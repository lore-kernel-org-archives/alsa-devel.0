From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001888]: MIDI external output occasionally freezes the machine
Date: Thu, 2 Mar 2006 09:59:29 +0100
Message-ID: <be56203a9c44d596c99c8065b62f26a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 21B5D1CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 09:59:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1888> 
======================================================================
Reported By:                pigeon
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1888
Category:                   PCI - ymfpci
Reproducibility:            random
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.14.4 SMP, self-built
======================================================================
Date Submitted:             03-02-2006 09:59 CET
Last Modified:              03-02-2006 09:59 CET
======================================================================
Summary:                    MIDI external output occasionally freezes the
machine
Description: 

Since I've upgraded my kernel from 2.4 to 2.6.14.4, I'm having random
machine freezes when using the external MIDI port on my ymf soundcard. It
can happen just by playing midi using "pmidi -p 64:0 <midi file>". It
freezes sometimes when I simply ctrl-c it. Rosegarden also suffers from
the same behavior while starting and/or stopping a playback.

My external MIDI is connected to a Yamaha digital piano.

I do not have this problem when I was using a 2.4 kernel, and a self built
alsa driver (possibly version 1.0.9).

The snd-ymfpci driver is loaded with the follow options:
mpu_port=1 fm_port=1 joystick_port=1

Thanks.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-06 09:59 pigeon         New Issue                                    
03-02-06 09:59 pigeon         Distribution              => Debian testing  
03-02-06 09:59 pigeon         Kernel Version            => 2.6.14.4 SMP,
self-built
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
