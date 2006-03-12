From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001917]: SB audigy 2 NX buffer underruns
Date: Sun, 12 Mar 2006 12:46:14 +0100
Message-ID: <0427dfdfe8ec96a1a3bcfc9c50675c4b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFBDD1D8
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 12:46:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1917> 
======================================================================
Reported By:                vyzivus
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1917
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15
======================================================================
Date Submitted:             03-12-2006 12:46 CET
Last Modified:              03-12-2006 12:46 CET
======================================================================
Summary:                    SB audigy 2 NX buffer underruns
Description: 
The best I can get is audio with clicks. Both mplayer and aplay screams
every 10 seconds something about buffer underrun. Then at some random
underrun something (snd-usb-audio?) finally breaks down and everything
locks when trying to play. It seems to affect usb functionality aswell - I
am not able to use usb disks until I reboot.
I tried to put this into /etc/asound.conf:
pcm.usb {
        type hw;
        card 1;
        device 0;
}

pcm.NX {
        type dmix
        ipc_key 1024
        slave {
                pcm     "usb";
                channels        2;
                rate    48000;
                period_size     6000;
                buffer_size     24000;
                period_time     125000;
        }
        bindings {
                0 0
                1 1
        }
}



with various period_* and buffer arguments but this simply stops playing
after first buffer underrun. I tried to 

modprobe snd-usb-audio nrpacks=1

 just to see snd-usb-audio die sooner. I'm wondering what I really bought.
The
http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
site says that S/PDIF is not working for NX. Well, _my_ NX does not seem
to know it because S/PDIF works. With clicks and all that shit of course.

When I try to play a file with mplayer this happens:
$ mplayer -ao alsa:device=NX *
... blahblah ...
alsa-init: 1 soundcard found, using: dmixer
alsa: 48000 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A:   2.2 (02.1) of 380.0 (06:20.0)  3.8%
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe
alsa-play: trying to reset soundcard
... repeat until ctrl+c

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-06 12:46 vyzivus        New Issue                                    
03-12-06 12:46 vyzivus        Distribution              => Gentoo          
03-12-06 12:46 vyzivus        Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
