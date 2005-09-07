From: Mark Zealey <mz234@cam.ac.uk>
Subject: intel8x0 no sound in 2.6.12
Date: Wed, 7 Sep 2005 15:57:02 +0100
Message-ID: <200509071557.02218.mz234@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

I've just bought a laptop and put linux on it, however the sound does not 
work. Everythnig installs fine, the channels are all as they should be but 
there is no sound out of either the speakers or the headphone jack. The 
problem looks to be the same as 
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/0755.html however I've 
been unable to find how that was resolved. The only thnig which looks vaguely 
like an error is:

Sep  6 12:23:35 isaiah intel8x0_measure_ac97_clock: measured 51192 usecs
Sep  6 12:23:35 isaiah intel8x0: clocking to 48000
Sep  6 12:23:36 isaiah ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> 
GSI 11 (level, low) -> IRQ 11
Sep  6 12:23:36 isaiah PCI: Setting latency timer of device 0000:00:1f.6 to 64
Sep  6 12:23:36 isaiah 
ALSA /var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/alsa-kernel/pci/ac97/ac97_codec.c:1993: 
MC'97 1 converters and GPIO not ready (0xff00)


Dump of appropriate stuff following this, any help would be appreciated. I'm 
using gentoo and I've tried using the kernel drivers and also the drivers in 
alsa 1.0.9b but to no avail.

Cheers,

-- 

Mark Zealey
http://zealey.org/mark


isaiah mark # uname -a
Linux isaiah 2.6.12-gentoo-r10 #1 Tue Sep 6 11:42:11 BST 2005 i686 Intel(R) 
Celeron(R) M processor         1300MHz GenuineIntel GNU/Linux
isaiah mark # lsmod
Module                  Size  Used by
appletalk              36660  2
ipx                    29100  2
p8022                   2304  1 ipx
psnap                   3972  2 appletalk,ipx
llc                     7508  2 p8022,psnap
snd_pcm_oss            53152  0
snd_mixer_oss          19712  1 snd_pcm_oss
snd_seq_dummy           3780  0
snd_seq_oss            37696  0
snd_seq_midi_event      7104  1 snd_seq_oss
snd_seq                55120  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          9036  3 snd_seq_dummy,snd_seq_oss,snd_seq
rtc                    13496  0
yenta_socket           23560  0
rsrc_nonstatic         11840  1 yenta_socket
pcmcia_core            51080  2 yenta_socket,rsrc_nonstatic
snd_intel8x0m          19908  1
snd_intel8x0           34304  1
snd_ac97_codec         86332  2 snd_intel8x0m,snd_intel8x0
snd_pcm                94088  4 
snd_pcm_oss,snd_intel8x0m,snd_intel8x0,snd_ac97_codec
snd_timer              25924  2 snd_seq,snd_pcm
snd                    57092  15 
snd_pcm_oss,snd_mixer_oss,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         10116  3 snd_intel8x0m,snd_intel8x0,snd_pcm
piix                   10628  0 [permanent]
cpufreq_conservative     7140  1
cpufreq_userspace       4444  0
p4_clockmod             5000  0
speedstep_lib           3840  1 p4_clockmod
isaiah mark # cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Sep  6 2005 for kernel 2.6.12-gentoo-r10.
isaiah mark # cat /proc/asound/devices
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl
isaiah mark # cat /proc/asound/I82801DBICH4/
codec97#0/ intel8x0   pcm0c/     pcm1c/     pcm3c/
id         oss_mixer  pcm0p/     pcm2c/     pcm4p/
isaiah mark # cat /proc/asound/I82801DBICH4/intel8x0
Intel8x0

Global control        : 0x00000002
Global status         : 0x00700300
SDM                   : 0x00000000
AC'97 codecs ready    : primary secondary
AC'97 codecs SDIN     : 0 1 0
isaiah mark # cat /proc/asound/I82801DBICH4/id
I82801DBICH4


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
