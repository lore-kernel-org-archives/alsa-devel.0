From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001023]: ens1371 pcm not work in 2.6.11 kernel
Date: Thu, 31 Mar 2005 13:14:19 +0200
Message-ID: <16c002342e3beaa24597744638550cb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0F5FB225
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 13:14:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023> 
======================================================================
Reported By:                yafrank
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1023
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.8_FC3
======================================================================
Date Submitted:             03-30-2005 14:25 CEST
Last Modified:              03-31-2005 13:14 CEST
======================================================================
Summary:                    ens1371 pcm not work in 2.6.11 kernel
Description: 
I'm using FC3 and my Creative SB AudioPCI 64V sound card works fine in 
2.6.10-1.770_FC3 kernel. After I replaced the kernel to 2.6.11 from
kernel.org or 2.6.11-1.8_FC3 from redhat, there is no sound anymore. I
noticed that the 2.6.11 kernel uses alsa 1.0.8 driver, yet userspace
alsa-lib and utility in fc3 are 1.0.6. So I upgrade them to 1.0.8 too.
Still, there is no sound and alsamixer doesn't show any pcm option.
Fortunately, the 1.0.8 lib and utility backward compatible with 1.0.6
driver in 2.6.10 kernel, so they were kept. The sound card uses ens1371
kernel module. And my /etc/modprobe.conf is this:

alias snd-card-0 snd-ens1371
alias sound-slot-0 snd-ens1371
install snd-ens1371 /sbin/modprobe --ignore-install snd-ens1371 &&
/usr/sbin/alsactlrestore >/dev/null 2>&1 || :
remove snd-ens1371 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-ens1371
alias usb-controller uhci-hcd
alias net-pf-10 off
alias ipv6 off
alias eth0 8139too


======================================================================

----------------------------------------------------------------------
 yafrank - 03-31-05 10:49 
----------------------------------------------------------------------
The ens1371 kernel module is loaded in 2.6.11
[frank@twinhead html]$ uname -a
Linux twinhead.localdomain 2.6.11-prep
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Wed Mar 30 17:11:30 CST
2005
i686 i686 i386 GNU/Linux
[frank@twinhead html]$ cat /proc/asound/cards0
[AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                   Ensoniq AudioPCI ENS1371 at 0xfcc0, irq 5
[frank@twinhead html]$ /sbin/lsmod | grep snd
snd_ens1371            28452  1
snd_rawmidi            27808  1 snd_ens1371
snd_seq_device          8972  1 snd_rawmidi
snd_ac97_codec         67576  1 snd_ens1371
snd_pcm_oss            49328  0
snd_mixer_oss          18048  2 snd_pcm_oss
snd_pcm                94472  3 snd_ens1371,snd_ac97_codec,snd_pcm_oss
snd_timer              31492  1 snd_pcm
snd                    55652  8
snd_ens1371,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11232  2 snd
snd_page_alloc          9988  1 snd_pcm

    As concern to "no sound", I've tested xmms playing mp3 file, mplayer
with wma and aplay with wav file. Alsamixer can always be invoked, but PCM
channel is missing if 2.6.11 kernel used. It seems that the former PCM
volume setting is now occupied by "Center" channel. Enable every channel
and miximum each volume setting in alsamixer doens't help either. 
    Aplay can be started without any error and VU meter can be seen if -vv
option applied.

----------------------------------------------------------------------
 yafrank - 03-31-05 13:14 
----------------------------------------------------------------------
More info of the sound card.
[root@twinhead ~]# lspci -vvv | grep "audio" -A8
00:06.0 Multimedia audio controller: Creative Labs Ectiva EV1938
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0e70
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort- >SERR- <PERR-
        Latency: 96 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at fcc0 [size=64]
        Region 1: I/O ports at fc40 [size=32]
        Capabilities: [dc] Power Management version 1

    If other info is needed, just let me know.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 14:25 yafrank        New Issue                                    
03-30-05 14:25 yafrank        Distribution              => Fedora Core 3   
03-30-05 14:25 yafrank        Kernel Version            => 2.6.11-1.8_FC3  
03-30-05 18:08 tiwai          Note Added: 0004266                          
03-31-05 10:49 yafrank        Note Added: 0004277                          
03-31-05 13:14 yafrank        Note Added: 0004279                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
