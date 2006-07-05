From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001888]: MIDI external output
	occasionally freezes the machine
Date: Wed, 5 Jul 2006 15:15:38 +0200
Message-ID: <635cabc96bb9d62e7cc61a15d4592845@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F120D256
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Jul 2006 15:15:38 +0200 (MEST)
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
Last Modified:              07-05-2006 15:15 CEST
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

----------------------------------------------------------------------
 Raymond - 07-05-06 15:03 
----------------------------------------------------------------------
Post output of

cat /proc/asound/cards

cat /proc/asound/pcm

cat /proc/asound/timers

----------------------------------------------------------------------
 tiwai - 07-05-06 15:15 
----------------------------------------------------------------------
How about the patch in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-06 09:59 pigeon         New Issue                                    
03-02-06 09:59 pigeon         Distribution              => Debian testing  
03-02-06 09:59 pigeon         Kernel Version            => 2.6.14.4 SMP,
self-built
06-19-06 15:38 Raymond        Note Added: 0010314                          
07-04-06 02:22 Sir Boss       Note Added: 0010811                          
07-05-06 15:03 Raymond        Note Added: 0010836                          
07-05-06 15:15 tiwai          Note Added: 0010837                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
