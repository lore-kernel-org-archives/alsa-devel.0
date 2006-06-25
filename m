From: Andi Kleen <ak@suse.de>
Subject: Alsa update in mainline broke ATI-IXP sound driver
Date: Sun, 25 Jun 2006 21:39:35 +0200
Message-ID: <200606252139.36002.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C9D3183
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jun 2006 21:39:41 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Since I updated an ATI x86-64 box to 2.6.17-git6 sound doesn't work anymore.

I just get

ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_concat returned error: No such device
ALSA lib confmisc.c:955:(snd_func_refer) error evaluating name
ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_refer returned error: No such device
ALSA lib conf.c:3962:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default

no matter how often I try. OSS clients also don't seem to work.
(in older kernels it sometimes didn't work on first try after boot, now it doesn't work 
at all)

The module loaded ok:

snd_pcm_oss            39328  0 
snd_mixer_oss          14784  1 snd_pcm_oss
snd_atiixp             16536  0 
snd_ac97_codec         97980  1 snd_atiixp
snd_ac97_bus            2688  1 snd_ac97_codec
snd_pcm                72328  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              19784  1 snd_pcm
snd_page_alloc          7824  2 snd_atiixp,snd_pcm
snd                    49280  6 snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller

I can't find any output from alsa in the kernel log except for


PCI: Enabling device 0000:00:14.5 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 217

when restarting rcalsasoudn

User land is from SUSE 10.0

-Andi

config:


#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_ATIIXP=m

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
