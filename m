From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001797]: Aureon 7.1 Universe: mixer flakyness (irrecoverable muting, intermittent muting of single channel)
Date: Sun, 19 Mar 2006 05:51:49 +0100
Message-ID: <48b44231f622892fc8f5c3478f67f623@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4EFC1CA
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 05:51:49 +0100 (MET)
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
Last Modified:              03-19-2006 05:51 CET
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
 rlrevell - 03-19-06 05:35 
----------------------------------------------------------------------
Have you confirmed the problem with ALSA CVS and no .asoundrc?

----------------------------------------------------------------------
 ikari_01 - 03-19-06 05:51 
----------------------------------------------------------------------
Will test with ALSA CVS shortly.
For now, I quick-checked without .asoundrc or /etc/asound.conf and the
problem persists. (192kHz 2ch s16le & 192kHz 2ch s32le)

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
