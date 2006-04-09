From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001703]: NVidia CK804 - Realtek ALC850 rev 0 - passthrough not working
Date: Sun, 9 Apr 2006 14:31:33 +0200
Message-ID: <12ec49d2f03592689f7a48affb81f945@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DA0D139
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 14:31:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1703> 
======================================================================
Reported By:                alsarealist
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1703
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               self burned
Kernel Version:             
======================================================================
Date Submitted:             01-03-2006 18:42 CET
Last Modified:              04-09-2006 14:31 CEST
======================================================================
Summary:                    NVidia CK804 - Realtek ALC850 rev 0 - passthrough
not working
Description: 
Pass-through with xine is not working.
PCM Stereo downmix works fine


00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio
Controller (rev a2)

gcc (GCC) 4.0.2
alsa version 1.0.11rc2
Linux 2.6.15

======================================================================

----------------------------------------------------------------------
 alsarealist - 01-06-06 01:03 
----------------------------------------------------------------------
Using xine I got a funny effect with SPSA:
Before starting xine I set SPSA to 3:

cat   /proc/asound/card0/codec97#0/ac97#0-0+regs |grep 0:2a
0:2a = 05f4

After I started xine SPSA is set back to 0:
cat   /proc/asound/card0/codec97#0/ac97#0-0+regs |grep 0:2a
0:2a = 05c4

What's going on here?

I tried to play a wave file but I heared no sound.

aplay -Dplug:spdif some-sound.wav
Playing WAVE 'some-sound.wav' : Signed 16 bit Little Endian, Rate 48000
Hz, Channels 6

<silence>

During this test I had the same funny effect of switching SPSA from 3 to 0
and back to 3. Is that normal? What exactly are these "AC-LINK slots"?
Channels on SPDIF?

----------------------------------------------------------------------
 alsarealist - 04-09-06 14:31 
----------------------------------------------------------------------
Giving up frustrated - DTS, Dolby 5.1 seems not to be possible. Stay an
stereo.

Closing case.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 18:42 alsarealist    New Issue                                    
01-03-06 18:42 alsarealist    Distribution              => self burned     
01-03-06 19:05 rlrevell       Note Added: 0007403                          
01-04-06 01:45 alsarealist    Note Added: 0007409                          
01-04-06 17:11 tiwai          Note Added: 0007436                          
01-04-06 17:32 alsarealist    File Added: asound.state                     
01-04-06 17:33 alsarealist    Note Added: 0007443                          
01-04-06 17:38 alsarealist    File Added: proc-asound                      
01-04-06 17:42 alsarealist    Note Added: 0007447                          
01-04-06 23:11 alsarealist    Note Added: 0007459                          
01-05-06 20:00 tiwai          Note Added: 0007477                          
01-06-06 01:03 alsarealist    Note Added: 0007486                          
04-09-06 14:31 alsarealist    Note Added: 0009179                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
