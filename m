From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001940]: enemy territory has no sound on ICE1724
Date: Wed, 29 Mar 2006 19:24:21 +0200
Message-ID: <30bc1a74be72734d8deda6d4af165d88@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EC5B718B
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 19:24:22 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1940> 
======================================================================
Reported By:                oscar
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1940
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.15 (Debian')
Resolution:                 duplicate
Duplicate:                  1634
Fixed in Version:           
======================================================================
Date Submitted:             03-18-2006 00:28 CET
Last Modified:              03-29-2006 19:24 CEST
======================================================================
Summary:                    enemy territory has no sound on ICE1724
Description: 

Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).

Enemy territory starts without sound.
Reports this error:
------- sound initialization -------
/dev/dsp: Invalid argument
Could not set /dev/dsp to stereo=2------------------------------------

Strace:
open("/dev/dsp", O_RDWR)                = 327
getuid32()                              = 1000
setresuid32(-1, 1000, -1)               = 0
ioctl(327, SNDCTL_DSP_GETCAPS, 0xbfb7eddc) = 0
ioctl(327, SNDCTL_DSP_STEREO, 0xbfb7edd4) = -1 EINVAL (Invalid argument)
write(2, "/dev/dsp: Invalid argument\n", 27) = 27
write(2, "Could not set /dev/dsp to stereo"..., 34) = 34
close(327)                              = 0
write(2, "--------------------------------"..., 37) = 37


SNDCTL_DSP_STEREO fails on /dev/dsp.

Unfortunately all wrappers misbehave with this damned game...
I run this to get this far: "et.x86 0 0 direct" >
/proc/asound/card0/pcm0p/oss
without that the game exits with and MMAP error (it's a known issue with
q3 engine, I am only writing it here so noone will suggest it as a
workaround).

I appreciate any help/advice.
Willing to compile and test code.



======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001634 lack of mmap support with ice1724
======================================================================

----------------------------------------------------------------------
 oscar - 03-18-06 00:31 
----------------------------------------------------------------------
I forgot the exact hw specs:

0 [SN25P          ]: ICE1724 - Shuttle SN25P
                     Shuttle SN25P at 0xa000, irq 20

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-18-06 00:28 oscar          New Issue                                    
03-18-06 00:28 oscar          Distribution              => Debian          
03-18-06 00:28 oscar          Kernel Version            => 2.6.15 (Debian')
03-18-06 00:28 oscar          Issue Monitored: oscar                       
03-18-06 00:31 oscar          Note Added: 0008666                          
03-29-06 19:24 tiwai          Relationship added       duplicate of 0001634
03-29-06 19:24 tiwai          Duplicate ID             0 => 1634           
03-29-06 19:24 tiwai          Status                   new => resolved     
03-29-06 19:24 tiwai          Resolution               open => duplicate   
03-29-06 19:24 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
