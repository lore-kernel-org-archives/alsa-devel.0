From: "D. Sen" <dsen@homemail.com>
Subject: Re: intel8x0: changing characteristics after an APM
 suspend-resume cycle
Date: Wed, 08 Jan 2003 09:25:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E1C34CF.10903@homemail.com>
References: <3E1B3B2A.4070204@homemail.com> <s5h7kdfalxd.wl@alsa2.suse.de>
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



Takashi Iwai wrote:
 > At Tue, 07 Jan 2003 15:40:10 -0500,
 > D. Sen <dsen@homemail.com> wrote:
 >
 >>Hi,
 >>
 >>I am using the snd-intel8x0 drivers (0.9.0rc6) on my IBM Thinkpad
 >>running Linux 2.4.20. Everything seems to run fine until the machine
 >>goes through a suspend/resume cycle when mono files/streams seem to get
 >>played back at a much faster rate.
 >>
 >>A cold reboot resolves the problem.
 >
 >
 > even after unloading/reloading the module the problem persists?
 >
 >
 > Takashi
 >
 >

While unloading/reloading does resolve the problem, once in a while 
though, sound is totally stuffed up after the
suspend/resume cycle and the modules cant be reloaded. Typically happens 
if I forget to unmute the
channels after resume and attempt to play something. At that point
trying to reload the modules is not possible (see the messages below). A
suspend/resume cycle resolves the problem.

[/root] modprobe -a snd-intel8x0
/lib/modules/2.4.20/kernel/sound/pci/snd-intel8x0.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
        You may find more information in syslog or the output from dmesg
modprobe: insmod /lib/modules/2.4.20/kernel/sound/pci/snd-intel8x0.o failed
modprobe: insmod snd-intel8x0 failed

and in the syslog:
Jan  8 08:33:32 localhost kernel: PCI: Found IRQ 11 for device 00:1f.5
Jan  8 08:33:32 localhost kernel: PCI: Sharing IRQ 11 with 00:1f.3
Jan  8 08:33:32 localhost kernel: PCI: Sharing IRQ 11 with 00:1f.6
Jan  8 08:33:32 localhost kernel: PCI: Sharing IRQ 11 with 02:00.1
Jan  8 08:33:33 localhost kernel: ALSA
../../alsa-kernel/pci/ac97/ac97_codec.c:1554: AC'97 0:0 does not respond
- RESET [REC_GAIN = 0x0]
Jan  8 08:33:33 localhost kernel: Intel ICH soundcard not found or
device busy



Jan  8 03:40:47 localhost kernel: PCI: Found IRQ 11 for device 00:1f.5
Jan  8 03:40:47 localhost kernel: PCI: Sharing IRQ 11 with 00:1f.3
Jan  8 03:40:47 localhost kernel: PCI: Sharing IRQ 11 with 00:1f.6
Jan  8 03:40:47 localhost kernel: PCI: Sharing IRQ 11 with 02:00.1
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x26
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x0
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x26
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x20
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x26
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x2
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:546: codec_read 0: semaphore is not ready
for register 0x2
Jan  8 03:40:47 localhost last message repeated 9 times
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x2
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x4
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x6
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0xa
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0xc
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0xe
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x10
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x12
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x14
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x16
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x18
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x1a
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x1c
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x20
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x22
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x2a
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x2c
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x32
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x70
Jan  8 03:40:47 localhost kernel: ALSA
../alsa-kernel/pci/intel8x0.c:530: codec_write 0: semaphore is not ready
for register 0x74




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
