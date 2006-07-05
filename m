From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001888]: MIDI external output
	occasionally freezes the machine
Date: Thu, 6 Jul 2006 01:59:40 +0200
Message-ID: <252fde104636dab2c5b53d0ed6dde399@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB45F17A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 01:59:40 +0200 (MEST)
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
Last Modified:              07-06-2006 01:59 CEST
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
 tiwai - 07-05-06 15:15 
----------------------------------------------------------------------
How about the patch in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952?

----------------------------------------------------------------------
 Sir Boss - 07-06-06 01:59 
----------------------------------------------------------------------
$ cat /proc/asound/cards
 0 [ICH5           ]: ICH4 - Intel ICH5
                      Intel ICH5 with AD1980 at 0xfebffa00, irq 16
 1 [ALS4000        ]: ALS4000 - Avance Logic ALS4000
                      Avance Logic ALS4000 at 0xdf00, irq 23
$ cat /proc/asound/pcm
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
01-00: ALS4000 DSP :  : playback 1 : capture 1
$ cat /proc/asound/timers
G0: system timer : 1000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
  Client application 10156 : running
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
P0-2-1: PCM capture 0-2-1 : SLAVE
P0-3-1: PCM capture 0-3-1 : SLAVE
P0-4-0: PCM playback 0-4-0 : SLAVE
P1-0-0: PCM playback 1-0-0 : SLAVE
P1-0-1: PCM capture 1-0-1 : SLAVE

Forgive a noob...but where exactly does that patch from 952 go?  If it's a
kernel patch, how do I go about applying it?

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
07-06-06 01:59 Sir Boss       Note Added: 0010845                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
