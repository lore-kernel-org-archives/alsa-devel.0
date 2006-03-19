From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001797]: Aureon 7.1 Universe: mixer flakyness (irrecoverable muting, intermittent muting of single channel)
Date: Sun, 19 Mar 2006 05:35:17 +0100
Message-ID: <b7b67a9bbc2cef81d2353a3f5fa3312a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF2A11CA
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 05:35:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1797> 
======================================================================
Reported By:                ikari_01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1797
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             01-30-2006 23:46 CET
Last Modified:              03-19-2006 05:35 CET
======================================================================
Summary:                    Aureon 7.1 Universe: mixer flakyness (irrecoverable
muting, intermittent muting of single channel)
Description: 
1. Setting (or muting/unmuting) of any of the Master, Center, LFE, or Side
mixers eventually results in irrecoverably completely muted sound.
Sometimes, at first only one channel is muted.
Sometimes, at first the volume decreases before muting occurs.

This does not occur when touching the "Front" mixer.
The only way to recover sound is to unload and reload at least the
snd_ice1724 module.

2. When muting and unmuting "PCM" repeatedly, sound is not always muted or
unmuted accordingly, but only about 50% of the time. (meaning you have to
toggle a couple of times to get the desired setting)

3. When muting or unmuting Master, sometimes only one of the channels is
muted or unmuted.

note: None of the problems occurred when testing on a 32-bit distribution
(Knoppix 4.0 / 2.6.12 / ALSA 1.0.9; different version, but I had the same
problem with 1.0.9 on x86_64 anyway.)
======================================================================

----------------------------------------------------------------------
 ikari_01 - 03-19-06 05:22 
----------------------------------------------------------------------
I must apologise.
I obviously misinterpreted the problem. Even with the patched module, the
mixer remains unreliable (tested using xmms' volume control and alsamixer
again, same symptoms).
Thanks for pointing me to the problem again, though, as I now found out
that the reliability of the mixer depends on the playback sample rate- the
higher the rate, the less reliable the mixer. I tested this with dmixer
(@44100, 96000, 176400 and 192000Hz mixing rate) as well as with a 192kHz
wave file using plug with hw:0.0 as slave. The PCM "Mute" control is
almost unresponsive at this rate, while it fails only in 1/100 of the time
when playing back at 44100Hz.
Playback itself is not choppy at high rates and my machine should be fast
enough. Could it be that the GPIO port writes actually collide with the
transfer of sample data or with interrupts? (This is just a wild, wild
guess, though...)



----------------------------------------------------------------------
 rlrevell - 03-19-06 05:35 
----------------------------------------------------------------------
Have you confirmed the problem with ALSA CVS and no .asoundrc?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-06 23:46 ikari_01       New Issue                                    
01-30-06 23:46 ikari_01       Distribution              => Debian unstable 
01-30-06 23:46 ikari_01       Kernel Version            => 2.6.14.3        
01-30-06 23:48 ikari_01       Issue Monitored: ikari_01                    
01-30-06 23:51 ikari_01       Note Added: 0007842                          
01-30-06 23:53 ikari_01       Note Added: 0007843                          
01-30-06 23:55 ikari_01       Note Edited: 0007842                         
01-30-06 23:55 ikari_01       Note Deleted: 0007843                        
01-30-06 23:56 ikari_01       Note Edited: 0007842                         
01-31-06 00:04 ikari_01       Note Edited: 0007842                         
03-19-06 02:05 ungod          Note Added: 0008677                          
03-19-06 02:06 ungod          Note Edited: 0008677                         
03-19-06 02:07 ungod          Note Edited: 0008677                         
03-19-06 02:08 ungod          Note Edited: 0008677                         
03-19-06 02:37 ikari_01       Note Added: 0008678                          
03-19-06 02:41 ungod          File Added: aureon-mutex.diff                    
03-19-06 02:44 ungod          Note Added: 0008679                          
03-19-06 05:19 ikari_01       Note Added: 0008680                          
03-19-06 05:22 ikari_01       Note Edited: 0008680                         
03-19-06 05:35 rlrevell       Note Added: 0008681                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
