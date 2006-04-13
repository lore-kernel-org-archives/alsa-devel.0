From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002013]: no digital output
Date: Thu, 13 Apr 2006 21:22:48 +0200
Message-ID: <05163e7c57ac244f18a2791b094d288c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E917178
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 21:22:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2013> 
======================================================================
Reported By:                SamiH
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2013
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               BLFS
Kernel Version:             2.6.15.4
======================================================================
Date Submitted:             04-09-2006 11:43 CEST
Last Modified:              04-13-2006 21:22 CEST
======================================================================
Summary:                    no digital output
Description: 
Shortly: Digital output doesn't work at all, or I don't know how to use
it.

This has been my problem quite long time now. I have upgraded my kernel
from  2.6.8 to 2.6.15.4 with some steps bitween those versions, and the
problem is still here. I have tried some live-cds with same results as my
stable system.

Analog stereo output works with no problems. If someone did tell me what I
should test on my system so that I could give the results to you.

These aren't broken:
 * my external amplifier
 * the digital coaxial cable
 * speakers etc.

Please tell me at least what to do, what to search for, or something...
======================================================================

----------------------------------------------------------------------
 tiwai - 04-10-06 16:50 
----------------------------------------------------------------------
You didn't write what did you test...

----------------------------------------------------------------------
 SamiH - 04-13-06 21:22 
----------------------------------------------------------------------
Sorry about that incomplete post, hopefully this tells something to you.

In alsa.txt is my alsactl output.
The programs I have used: aplay, xmms, xine, speaker-test

I have tested different mixer values, sometimes in order, sometimes
random. But now I tested with speaker-test.

* speaker-test -c 2 -Dhw:0,0,[12] -> only analog stereo
* speaker-test -c 2 -Dhw:0,0,3 -r 44100 -> no sound, but plays (44100 was
the first samplerate I tried after it said: "Setting of hwparams failed:
Invalid argument Rate 48000Hz not available for playback: Invalid
argument) 
* speaker-test -c 2 -Dhw:0,0,[4567] -> Playback open error: -16,Device or
resource busy
* speaker-test -c 2 -Dhw:0,1,0 -> only analog stereo
* speaker-test -c 2 -Dhw:0,1,[12] -> Playback open error: -16,Device or
resource busy

-----

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: V8237 [VIA 8237], device 0: VIA 8237 [VIA 8237]
  Subdevices: 4/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
card 0: V8237 [VIA 8237], device 1: VIA 8237 [VIA 8237]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-09-06 11:43 SamiH          New Issue                                    
04-09-06 11:43 SamiH          Distribution              => BLFS            
04-09-06 11:43 SamiH          Kernel Version            => 2.6.15.4        
04-10-06 16:50 tiwai          Note Added: 0009198                          
04-13-06 21:10 SamiH          File Added: alsa.txt                         
04-13-06 21:22 SamiH          Note Added: 0009269                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
