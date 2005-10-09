From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001448]: AC3 passthrou on emu10k1 with version 1.0.10rc1 does not work
Date: Sun, 9 Oct 2005 13:16:51 +0200
Message-ID: <3a18089357125fa9d880309bee311c0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CCA11A2
	for <alsa-devel@alsa-project.org>; Sun,  9 Oct 2005 13:16:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1448> 
======================================================================
Reported By:                cocobo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1448
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             09-23-2005 20:47 CEST
Last Modified:              10-09-2005 13:16 CEST
======================================================================
Summary:                    AC3 passthrou on emu10k1 with version 1.0.10rc1 does
not work
Description: 
If I run kernel 2.6.14-rc[1-2] (alsa ver 1.0.10rc1) I can't get AC3 s/pdiff
passthrou to work. The external decoder does not switch over to dolby
mode. Kernel 2.6.13 work fine. I have a soundblaster live value soundcard
and use mplayer dev-CVS-050810-20:56-3.4.4 or xine-1.1.0 to play sound.
Ask me for more info if needed.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-05-05 19:05 
----------------------------------------------------------------------
Are you using the latest version of alsa-lib, too?

----------------------------------------------------------------------
 hugo4711 - 10-09-05 13:16 
----------------------------------------------------------------------
Same issue here. AC3 passthrough does not work. However my versions are
different:

uname -a:
Linux ravine 2.6.13-1.1526_FC4 #1 Wed Sep 28 19:15:10 EDT 2005 i686 athlon
i386 GNU/Linux

cat /proc/asound/version:
Advanced Linux Sound Architecture Driver Version 1.0.10rc1.
Compiled on Oct  4 2005 for kernel 2.6.13-1.1526_FC4

cat /proc/asound/cards:
0 [Audigy         ]: Audigy - Audigy 1 [SB0090]
                     Audigy 1 [SB0090] (rev.3, serial:0x511102) at 0xe400,
irq 11
1 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0xe800, irq 10
2 [Bt878          ]: Bt87x - Brooktree Bt878
                     Brooktree Bt878 at 0xdddfe000, irq 11

MPlayer version 1.0pre7-4.0.0

The output from mplayer is the following when initializing the soundcard:

alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82
AES2 0x00 AES3 0x02}
ALSA lib setup.c:549:(add_elem) Cannot obtain info for CTL elem
(MIXER,'IEC958 Playback Default',0,0,0): No such file or directory
alsa-init: playback open error: No such file or directory

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 20:47 cocobo         New Issue                                    
09-23-05 20:47 cocobo         Distribution              => Gentoo          
09-23-05 20:47 cocobo         Kernel Version            => 2.6.14-rc2      
10-05-05 19:05 tiwai          Note Added: 0006440                          
10-09-05 13:16 hugo4711       Note Added: 0006445                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
