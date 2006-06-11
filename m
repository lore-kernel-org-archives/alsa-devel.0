From: John Rigg <ad@sound-man.co.uk>
Subject: open /dev/snd/seq failed
Date: Sun, 11 Jun 2006 14:21:57 +0100
Message-ID: <E1FpPt7-0001Z8-7E@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just compiled alsa-lib, alsa-tools and alsa-utils 1.0.11
on a new Debian Etch amd64 installation and keep getting the following error
message from apps that try to connect to the sequencer:

ALSA lib seq_hw.c:457:(snd_seq_hw_open) open /dev/snd/seq failed: No such file
or directory
can't open sequencer

This is with Debian 2.6.15-1 kernel and with kernel.org 2.6.16.20 (compiled
using Debian .config but with CONFIG_PREEMPT=y).

Contents of /dev/snd:

controlC0 controlC1 controlC2 midiC0D0 midiC1D0 midiC2D0
pcmC0D0c pcmC0D0p pcmC1D0c pcmC1D0p pcmC2D0c pcmC2D0p timer

lsmod:

snd_ice1712            67360  0 
snd_ice17xx_ak4xxx      6720  1 snd_ice1712
snd_ak4xxx_adda         9216  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_cs8427             12672  1 snd_ice1712
snd_ac97_codec        103868  1 snd_ice1712
snd_pcm                96008  2 snd_ice1712,snd_ac97_codec
snd_timer              27336  1 snd_pcm
snd_page_alloc         13904  1 snd_pcm
snd_ac97_bus            4928  1 snd_ac97_codec
snd_i2c                 8192  2 snd_ice1712,snd_cs8427
snd_mpu401_uart        10432  1 snd_ice1712
snd_rawmidi            29664  1 snd_mpu401_uart
snd_seq_device         11792  1 snd_rawmidi
joydev                 13120  0 
evdev                  13952  0 
shpchp                 47008  0 
snd                    62304  10 snd_ice1712,snd_ak4xxx_adda,snd_cs8427,snd_ac97_codec,snd_pcm,snd_timer,snd_i2c,snd_mpu401_uart,snd_rawmidi,snd_seq_device

There are three ice1712 cards (Delta 1010s) installed.
The kernel config contains the following:

# Linux kernel version: 2.6.15-1-amd64-k8-smp
...
CONFIG_SND=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_GENERIC_DRIVER=y
#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
...

Everything (jackd, Ardour) works fine except the sequencer.
Although this is AMD64 SMP the RTCs sync properly (two single core
Opterons, not dual core). Any ideas?


John
