From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001797]: Aureon 7.1 Universe: mixer flakyness (irrecoverable muting, intermittent muting of single channel)
Date: Sun, 19 Mar 2006 14:26:24 +0100
Message-ID: <38cf0c9d122e2357c57b391391d94a0a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D0651AB
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 14:26:24 +0100 (MET)
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
Last Modified:              03-19-2006 14:26 CET
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
 ikari_01 - 03-19-06 06:57 
----------------------------------------------------------------------
Shame on me, I never tested on 32bit before at high playback rates as I did
not believe it to be the problem. :/

The problem remains exactly the same under a 32 bit kernel.

Unfortunately, I do not currently have exactly the same versions
available. The version matches the one in the original description.
Maybe I should try swapping PCI slots...

----------------------------------------------------------------------
 ungod - 03-19-06 14:26 
----------------------------------------------------------------------
Electrical noise is always a possibility, but I was not able to reproduce
the error at 192kHz (linux-2.6.15.6 with ALSA CVS, both with and without
the mutex patch)
This doesn't mean that the problem is an isolated one, however. After all
I have the Space edition and not the Universe one. Universe probably have
additional logic attached to the GPIO pins, which are not treated properly
by the driver.
It is quite a while ago I worked on the Space driver, but if I remember
correct, there was some difference. Unfortunately I wasn't able to find
anyone with the Universe so that the driver could be tested.

Btw., have you tried reproducing the error in Windows or the 4Front OSS
drivers (http://www.opensound.com/)? Not that I do not believe you, but
the whole reason I initially got involved with the Aureon driver, was that
my own card actually was broken from the start. A voltage regulator was
broken, and I blamed the ALSA driver which at that time was quite simple.
Later I saw that the regulator was broken (the print was quite black
around the chip), and exchanged the card to a new one, which solved all my
problems.

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
03-19-06 05:51 ikari_01       Note Added: 0008682                          
03-19-06 06:33 ikari_01       Note Added: 0008683                          
03-19-06 06:35 rlrevell       Note Added: 0008684                          
03-19-06 06:57 ikari_01       Note Added: 0008685                          
03-19-06 14:26 ungod          Note Added: 0008689                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
