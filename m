From: Juergen Kreileder <jk@blackdown.de>
Subject: ioctl32 on ppc64
Date: Mon, 13 Sep 2004 03:21:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87fz5notfg.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I'm trying to get an Audigy NX working with a ppc64 kernel (2.6.9-rc1)
and 32-bit userland.  ALSA seems to work fine (except for dmix) with
32-bit kernels + 32-bit userland and 64-bit kernels + 64 userland.

With mixed a mixed 32-bit/64-bit environment I wasn't able to run
alsactl/amixer/alsamixer initially:

,----
| ioctl32(alsactl:2581): Unknown cmd fd(3) cmd(c2c85513){02} arg(ffffe6e0) on /dev/snd/controlC0
| ioctl32(amixer:2582): Unknown cmd fd(3) cmd(c2c85512){02} arg(ffffe180) on /dev/snd/controlC0
| ioctl32(alsactl:2584): Unknown cmd fd(3) cmd(c2c85513){02} arg(ffffe6e0) on /dev/snd/controlC0
`----

After removing the packed attribute from struct sndrv_ctl_elem_value32,
32-bit alsactl and alsamixer seem to work fine.

I also can play 48000 Hz wav files with 32-bit aplay now, but playing
41000 Hz stuff only works directly to hw:0,0 (sounds broken).
Doing rate conversion with a plugin defined in .asoundrc works for the
pure 32-bit and 64-bit cases but not for the mixed 32-bit/64-bit case,
it fails with "ALSA lib pcm_hw.c:549:(snd_pcm_hw_start)
SNDRV_PCM_IOCTL_START failed: Broken pipe":

,----
| $ aplay 44100.wav 
| Playing WAVE '44100.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
| ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken pipe
| Aborted by signal Interrupt...
| jk@fry:~$ aplay -v 44100.wav 
| Playing WAVE '44100.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
| Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
| Its setup is:
| stream       : PLAYBACK
| access       : RW_INTERLEAVED
| format       : S16_LE
| subformat    : STD
| channels     : 2
| rate         : 44100
| exact rate   : 44100 (44100/1)
| msbits       : 16
| buffer_size  : 15052
| period_size  : 3763
| period_time  : 85333
| tick_time    : 1000
| tstamp_mode  : NONE
| period_step  : 1
| sleep_min    : 0
| avail_min    : 3763
| xfer_align   : 3763
| start_threshold  : 15052
| stop_threshold   : 15052
| silence_threshold: 0
| silence_size : 0
| boundary     : 986447872
| Slave: Hardware PCM card 0 'SB Audigy 2 NX' device 0 subdevice 0
| 
| Its setup is:
| stream       : PLAYBACK
| access       : MMAP_INTERLEAVED
| format       : S16_LE
| subformat    : STD
| channels     : 2
| rate         : 48000
| exact rate   : 48000 (48000/1)
| msbits       : 16
| buffer_size  : 16384
| period_size  : 4096
| period_time  : 85333
| tick_time    : 1000
| tstamp_mode  : NONE
| period_step  : 1
| sleep_min    : 0
| avail_min    : 4096
| xfer_align   : 4096
| start_threshold  : 16384
| stop_threshold   : 16384
| silence_threshold: 0
| silence_size : 0
| boundary     : 0
| ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken pipe
| Aborted by signal Interrupt...
| $ strace aplay 44100.wav
| [...]
| ioctl(4, 0x40104132, 0xffffdf80)        = 0
| ioctl(4, 0x40104132, 0xffffdf80)        = 0
| mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x40027000
| shmget(IPC_PRIVATE, 61440, 0666)        = 16121856
| shmat(16121856, 0, 0)                   = 0x40037000
| shmctl(16121856, IPC_RMID, 0)           = 0
| ioctl(4, 0x20004140, 0xeb300000)        = 0
| ioctl(4, 0xc0684113, 0x1001fac4)        = 0
| read(3, "\1\0\377\377\1\0\377\377\0\0\0\0\0\0\1\0\377\377\0\0\0"..., 15052) = 15052
| read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\376\377\1\0\0\0\377\377"..., 15052) = 15052
| read(3, "\2\0\377\377\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 15052) = 15052
| read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\377\377\0\0\0"..., 15052) = 15052
| ioctl(4, 0x20004142, 0x1000)            = -1 EPIPE (Broken pipe)
| write(2, "ALSA lib pcm_hw.c:549:(snd_pcm_h"..., 41ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) ) = 41
| write(2, "SNDRV_PCM_IOCTL_START failed", 28SNDRV_PCM_IOCTL_START failed) = 28
| write(2, ": Broken pipe", 13: Broken pipe)           = 13
| write(2, "\n", 1
| )                       = 1
| read(3, "\1\0\376\377\1\0\0\0\0\0\0\0\0\0\1\0\377\377\1\0\376\377"..., 15052) = 15052
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
| [...]
`----

Any idea?

BTW, is anybody working on a driver for the built-in soundcard of the
PowerMac G5?


        Juergen

--- sound/core/ioctl32/ioctl32.c.orig   2004-09-13 01:05:44.732947976 +0200
+++ sound/core/ioctl32/ioctl32.c        2004-09-13 01:10:53.208913840 +0200
@@ -246,7 +246,7 @@ struct sndrv_ctl_elem_value32 {
                struct sndrv_aes_iec958 iec958;
         } value;
         unsigned char reserved[128];
-} __attribute__((packed));
+};
 
 
 /* hmm, it's so hard to retrieve the value type from the control id.. */
=

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://www.blackdown.org/java-linux/java2-status/


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
