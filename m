From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000706]: SERR: Status=4210 followed by NMI reason 34 leading to reboot
Date: Thu, 16 Dec 2004 21:46:17 +0100
Message-ID: <c4793f766b9da346fa474b8f0ab89b2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28589255
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 21:46:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=706> 
======================================================================
Reported By:                dlc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   706
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               DeMuDi1.2.0
Kernel Version:             2.4.25
======================================================================
Date Submitted:             12-04-2004 00:36 CET
Last Modified:              12-16-2004 21:46 CET
======================================================================
Summary:                    SERR: Status=4210 followed by NMI reason 34 leading
to reboot
Description: 
System reboots when attempting to install a game under Wine.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-16-04 18:22 
----------------------------------------------------------------------
I don't think it's a bug of drivers.  The code doesn't reach even to the
initialization of sound stuff at all.

Try much newer kernels?

----------------------------------------------------------------------
 dlc - 12-16-04 21:46 
----------------------------------------------------------------------
The drivers are loaded:

dlc@muse:~$ /sbin/lsmod
Module                  Size  Used by    Not tainted
nls_iso8859-1           2812   1 (autoclean)
ide-cd                 28128   1 (autoclean)
cdrom                  25344   0 (autoclean) [ide-cd]
isofs                  23480   1 (autoclean)
floppy                 45916   0 (autoclean)
snd-seq-midi            3968   0 (autoclean) (unused)
snd-seq-oss            31584   0 (autoclean) (unused)
snd-seq-midi-event      3680   0 (autoclean) [snd-seq-midi snd-seq-oss]
snd-seq                42192   5 (autoclean) [snd-seq-midi snd-seq-oss
snd-seq-midi-event]
binfmt_misc             5700   1
usb-ohci               17320   0 (unused)
usbcore                56684   1 [usb-ohci]
pcnet32                13056   1
mii                     2096   0 [pcnet32]
crc32                   2864   0 [pcnet32]
snd-ice1712            46372   2
snd-pcm-oss            39784   0 (unused)
snd-mixer-oss          14168   1 [snd-pcm-oss]
snd-pcm                65760   0 [snd-ice1712 snd-pcm-oss]
snd-timer              17092   0 [snd-seq snd-pcm]
snd-ac97-codec         57328   0 [snd-ice1712]
snd-ice17xx-ak4xxx      1520   0 [snd-ice1712]
snd-cs8427              6664   0 [snd-ice1712]
snd-i2c                 2732   0 [snd-ice1712 snd-cs8427]
snd-mpu401-uart         4096   0 [snd-ice1712]
snd-rawmidi            14880   0 [snd-seq-midi snd-mpu401-uart]
snd-seq-device          4340   0 [snd-seq-midi snd-seq-oss snd-seq
snd-rawmidi]
snd-ak4xxx-adda         3868   0 [snd-ice1712 snd-ice17xx-ak4xxx]
snd                    37284   1 [snd-seq-midi snd-seq-oss
snd-seq-midi-event snd-seq snd-ice1712 snd-pcm-oss snd-mixer-oss snd-pcm
snd-timer snd-ac97-codec snd-cs8427 snd-i2c snd-mpu401-uart snd-rawmidi
snd-seq-device snd-ak4xxx-adda]
snd-page-alloc          5356   0 [snd-seq-oss snd-seq snd-mixer-oss
snd-pcm snd-timer snd-i2c snd-rawmidi snd-seq-device snd]
soundcore               3876   7 [snd]
ide-detect               288   0 (unused)
ide-scsi                8656   0
ide-core               98268   1 [ide-cd ide-detect ide-scsi]
ext3                   71144   4 (autoclean)
jbd                    40312   4 (autoclean) [ext3]
sd_mod                 10540  12 (autoclean)
aic7xxx               130284   6 (autoclean)
scsi_mod               89312   3 (autoclean) [ide-scsi sd_mod aic7xxx]
unix                   16236  31 (autoclean)
dlc@muse:~$ 

envy24control loads, although its faders and mutes don't affect the
signals.  All pcm meters display identically.  When I patch the first two
PCM outs to the H/W outs, I get signal out the output jacks.

I'll see about doing a clean reinstallation of DeMuDi selecting the 2.6
kernel as soon as possible (don't hold your breath)...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-04 00:36 dlc            New Issue                                    
12-04-04 00:36 dlc            Distribution              => DeMuDi1.2.0     
12-04-04 00:36 dlc            Kernel Version            => 2.4.25          
12-07-04 18:52 tiwai          Note Added: 0002760                          
12-07-04 19:22 dlc            Note Added: 0002763                          
12-16-04 17:45 dlc            Note Added: 0002830                          
12-16-04 18:22 tiwai          Note Added: 0002832                          
12-16-04 21:46 dlc            Note Added: 0002842                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
