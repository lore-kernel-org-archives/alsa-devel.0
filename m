From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000854]: Can't load module snd-cs4236, snd-cs4236 or snd-sb8
Date: Fri, 30 Dec 2005 05:22:51 +0100
Message-ID: <82a55db79ab617bbad201f5357207d9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03C83125
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:22:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=854> 
======================================================================
Reported By:                mrpee
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   854
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8-2-386
======================================================================
Date Submitted:             01-28-2005 13:18 CET
Last Modified:              12-30-2005 05:22 CET
======================================================================
Summary:                    Can't load module snd-cs4236, snd-cs4236 or snd-sb8
Description: 
I can't load any modules for my sound carc Cirrus Logic cs4237b on my Dell
Latitude CP M233XT. I tried snd-cs4236, snd-cs4236 and also the
soundblaster module snd-sb8 with the same result "no such device".

I think I'll tried everything, kernel 2.4 with alsamodules, 2.6.1, alsa
1.0.7-2. half/full duplex, changing irq, dma etc.

Here is a link from another forum whith the same problem:
http://www.talkaboutsoftware.com/group/linux.debian.laptop/messages/7049.html
======================================================================

----------------------------------------------------------------------
 mrpee - 03-30-05 09:49 
----------------------------------------------------------------------
After running alsaconf I have these modules:

# lsmod
Module                  Size  Used by
snd_pcm_oss            48168  0
snd_mixer_oss          16640  1 snd_pcm_oss
snd_pcm                85384  1 snd_pcm_oss
snd_page_alloc         11144  1 snd_pcm
snd_timer              23172  1 snd_pcm
snd                    50660  4
snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9824  1 snd
lp                     10408  0
ipv6                  229764  14
orinoco_cs              9096  1
ds                     17796  5 orinoco_cs
nfsd                  181024  8
exportfs                6144  1 nfsd
lockd                  56520  2 nfsd
sunrpc                137060  2 nfsd,lockd
af_packet              20872  2
floppy                 54992  0
parport_pc             33348  1
parport                37320  2 lp,parport_pc
rtc                    12088  0
tsdev                   7168  0
mousedev                9996  1
joydev                  9536  0
evdev                   9088  0
pcspkr                  3816  0
psmouse                17800  0
3c59x                  36776  0
yenta_socket           19200  2
pcmcia_core            63028  3 orinoco_cs,ds,yenta_socket
uhci_hcd               29328  0
usbcore               104164  3 uhci_hcd
dm_mod                 51068  0
capability              4872  0
commoncap               7168  1 capability
orinoco                38284  1 orinoco_cs
hermes                  7936  2 orinoco_cs,orinoco
ide_cd                 38176  0
cdrom                  35740  1 ide_cd
ext3                  109672  1
jbd                    54552  1 ext3
ide_generic             1664  0
piix                   12448  1
ide_disk               16768  3
ide_core              125028  4 ide_cd,ide_generic,piix,ide_disk
unix                   26036  302
font                    8576  0
vesafb                  6688  0
cfbcopyarea             3840  1 vesafb
cfbimgblt               3200  1 vesafb
cfbfillrect             3712  1 vesafb

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:22 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 13:18 mrpee          New Issue                                    
01-28-05 13:18 mrpee          Distribution              => Debian          
01-28-05 13:18 mrpee          Kernel Version            => 2.6.8-2-386     
01-28-05 13:23 mrpee          Note Added: 0003426                          
03-28-05 04:23 jdthood        Note Added: 0004233                          
03-30-05 09:49 mrpee          Note Added: 0004264                          
12-30-05 05:22 rlrevell       Note Added: 0007243                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
