From: Jordan Breeding <jordan.breeding@attbi.com>
Subject: Problems with cs46xx under 2.5.44
Date: Mon, 28 Oct 2002 06:48:56 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DBD3238.3010109@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

   I am using a Turtle Beach cs46xx based card and have it configured 
for ALSA and the new firmware image under Linux 2.5.44 to allow playing 
multiple streams at once.  When running under 2.5.44 trying to scan to 
different parts of an mp3 file seems to take a lot longer than it should 
and I get a lot of the following output to dmesg:

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f09ff>] snd_pcm_oss_write1+0x3f/0x190
  [<c03f2b4c>] snd_pcm_oss_write+0x4c/0x90
  [<c0152a8a>] vfs_write+0xda/0x140
  [<c0152b8e>] sys_write+0x3e/0x60
  [<c010955b>] syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

ALSA sound/pci/cs46xx/cs46xx_lib.c:2895: cs46xx: 
cs46xx_setup_eapd_slot() Failure to write the GPIO pins for slot 12.
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c040f13c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c03fb578>] snd_pcm_prepare+0x118/0x270
  [<c03fdb4f>] snd_pcm_playback_ioctl1+0x4f/0x320
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c03f0576>] snd_pcm_oss_prepare+0x26/0x50
  [<c03f05e4>] snd_pcm_oss_make_ready+0x44/0x60
  [<c03f0e4d>] snd_pcm_oss_sync+0x1d/0x1c0
  [<c03fdb79>] snd_pcm_playback_ioctl1+0x79/0x320
  [<c03f229a>] snd_pcm_oss_release+0x2a/0xb0
  [<c03fe188>] snd_pcm_kernel_playback_ioctl+0x38/0x50
  [<c015420f>] __fput+0xff/0x110
  [<c0151971>] filp_close+0x81/0xb0
  [<c0151a1a>] sys_close+0x7a/0xc0
  [<c010955b>] syscall_call+0x7/0xb

Anybody know what's going on and how to fix it?  Thanks.

Jordan



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
