From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000604]: sound loop problem
Date: Thu, 28 Oct 2004 02:17:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <19888be8e581308e29878159b58bea17@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1F91F2CA
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2004 02:17:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=604> 
======================================================================
Reported By:                chomwitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   604
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               slackware10
Kernel Version:             2.6.7
======================================================================
Date Submitted:             10-26-2004 01:29 CEST
Last Modified:              10-28-2004 02:17 CEST
======================================================================
Summary:                    sound loop problem
Description: 
i get a sound loop which gets correctet only 
while moving the mouse!
======================================================================

----------------------------------------------------------------------
 chomwitt - 10-28-04 02:14 
----------------------------------------------------------------------
this is output from dmesg.

/root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec read
timeout (reg 1c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 0)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 3c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 1c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 0)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 3c)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/atiixp.c:458: atiixp: codec
read timeout (reg 1c)
....... (many many lines like the above)
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/ac97/ac97_codec.c:1904:
AC'97 2 does not respond - RESET
ALSA /root/alsa-driver-1.0.6a/alsa-kernel/pci/ac97/ac97_codec.c:1912:
AC'97 2 access is not valid [0xffffffff], removing mixer.

----------------------------------------------------------------------
 chomwitt - 10-28-04 02:17 
----------------------------------------------------------------------
aadebug output

ALSA Audio Debug v0.0.8 - Thu Oct 28 01:02:33 EEST 2004
http://alsa.opensrc.org/
aadebug Kernel ----------------------------------------------------
Linux garibaldh20 2.6.7
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13 Thu Oct 28 00:25:29
EEST 2004 i686 unknown
unknown GNU/Linux
Loaded Modules --------------------------------------------
snd_pcm_oss            51368  0 
snd_mixer_oss          19328  1 snd_pcm_oss
snd_atiixp             18472  0 
snd_ac97_codec         67920  1 snd_atiixp
snd_pcm                80904  2 snd_pcm_oss,snd_atiixp
snd_timer              22788  1 snd_pcm
snd                    46820  6
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          9480  2 snd_atiixp,snd_pcm
Proc Config -----------------------------------------------
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_PCM_OSS=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_AD1816A=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
Modprobe Conf --------------------------------------------
alias snd-card-0 snd-atiixp
alias sound-slot-0 snd-atiixp
Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.6a
Compiled on Oct 28 2004 for kernel 2.6.7.
0 [IXP            ]: ATIIXP - ATI IXP
                     ATI IXP rev 0 at 0xe8003000, irq 10
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
00-00: ATI IXP AC97 : ATI IXP AC97 : playback 1 : capture 1
Dev Snd ---------------------------------------------------
Warning: /dev/snd does not exist
CPU -------------------------------------------------------
model name	: Intel(R) Celeron(R) CPU 2.80GHz
cpu MHz		: 2801.084
RAM -------------------------------------------------------
MemTotal:       191744 kB
SwapTotal:      240932 kB
Hardware --------------------------------------------------
00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5833 (rev 02)
00:14.5 Multimedia audio controller: ATI Technologies Inc SoundMAX
Integrated Digital Audio

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 01:29 chomwitt       New Issue                                    
10-26-04 01:29 chomwitt       Distribution              => slackware10     
10-26-04 01:29 chomwitt       Kernel Version            => 2.6.7           
10-27-04 21:07 chomwitt       Note Added: 0002280                          
10-28-04 02:14 chomwitt       Note Added: 0002281                          
10-28-04 02:17 chomwitt       Note Added: 0002282                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
