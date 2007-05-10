From: ramkromberg@mail.com
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Thu, 10 May 2007 22:57:06 +0200
Message-ID: <20070510205706.8B5B11CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id C633324404
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 22:58:59 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	2246718001A8
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 20:58:54 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well, it didn't take long so here's the results :
"sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1" gave no errors, and
"lsmod" later gave:
Module                  Size  Used by
snd_sb8                 9216  0
snd_sb8_dsp            12288  1 snd_sb8
snd_sb_common          17792  2 snd_sb8,snd_sb8_dsp
snd_opl3_lib           11520  1 snd_sb8
snd_hwdep               9988  1 snd_opl3_lib
snd_pcm_oss            44544  0
snd_pcm                79876  3 snd_sb8,snd_sb8_dsp,snd_pcm_oss
snd_mixer_oss          17408  1 snd_pcm_oss
snd_seq_dummy           4740  0
snd_seq_oss            32896  0
snd_seq_midi            9600  0
snd_rawmidi            25472  2 snd_sb8_dsp,snd_seq_midi
snd_seq_midi_event      8448  2 snd_seq_oss,snd_seq_midi
snd_seq                52592  6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              23684  3 snd_opl3_lib,snd_pcm,snd_seq
snd_seq_device          9100  6
snd_opl3_lib,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    54020  13
snd_sb8,snd_sb8_dsp,snd_sb_common,snd_opl3_lib,snd_hwdep,snd_pcm_oss,snd_pcm,snd_mixer_oss,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               8672  1 snd
snd_page_alloc         10888  1 snd_pcm
nfs                   240876  0
nfsd                  218992  17
exportfs                6912  1 nfsd
lockd                  64904  3 nfs,nfsd
sunrpc                161340  12 nfs,nfsd,lockd
apm                    22752  1
ppdev                  10116  0
cpufreq_stats           7360  0
cpufreq_ondemand        9228  0
cpufreq_powersave       2688  0
freq_table              5792  2 cpufreq_stats,cpufreq_ondemand
cpufreq_conservative     8200  0
cpufreq_userspace       5408  0
nls_iso8859_1           5120  1
nls_cp437               6784  1
vfat                   14208  1
fat                    53916  1 vfat
ext2                   66824  1
lp                     12452  0
parport_pc             36388  1
parport                36936  3 ppdev,lp,parport_pc
pcspkr                  4224  0
ipv6                  268704  8
tsdev                   8768  0
evdev                  11008  1
ext3                  133128  1
jbd                    59816  1 ext3
mbcache                 9604  2 ext2,ext3
8139too                27648  0
ide_cd                 32672  0
cdrom                  37664  1 ide_cd
ide_disk               17024  5
floppy                 59524  0
ehci_hcd               34188  0
8139cp                 25088  0
mii                     6528  2 8139too,8139cp
uhci_hcd               25360  0
usbcore               134280  3 ehci_hcd,uhci_hcd
piix                   10756  0 [permanent]
generic                 5124  0 [permanent]
ata_generic             9092  0
libata                125720  1 ata_generic
scsi_mod              142348  1 libata
fbcon                  42656  0
tileblit                3584  1 fbcon
font                    9216  1 fbcon
bitblit                 6912  1 fbcon
softcursor              3200  1 bitblit
vesafb                  9220  0
capability              5896  0
commoncap               8192  1 capability


But when I try to play an ogg gxine crushes an xmms
ignores, when trying an mp3 gxine again crushes and
xmms gives the soundcard no configured error...

Just a recap: I verifyed using dos the settings
(hwset and volset - default and save), and used the bios
to set "IRQ 5" as "ISA Legacy".

I didn't use the jumper as I see no need since the epprom
already does the job.

So I'm stuck,
What do you think I should do now ?
Ram Kromberg
ramkromberg@mail.com
