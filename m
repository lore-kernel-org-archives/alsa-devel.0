From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: commit bd5389278c96f585afcac4058420e4f3ac201d2a
 introduce big problem
Date: Tue, 15 Nov 2011 14:26:58 +0800
Message-ID: <CAHG8p1DnQz-Dju1jY4fFu+b=N_qzOKJuEKKDgiU=7W1usmfwhA@mail.gmail.com>
References: <CAHG8p1DmEcTs7Mzmy8F0Aon3SGog9q+CpOX7SS+vFFkmeVWGcw@mail.gmail.com>
	<s5hbosngd04.wl%tiwai@suse.de>
	<CAHG8p1BZ5gV3xAb5QRgc1eEMQ9gB44y+8aoMPcP3R-Th5PESJw@mail.gmail.com>
	<CAHG8p1AHr6Z7VY+6zVhGk6AkbZxdS+firK4eFVrg81NWJnEVNA@mail.gmail.com>
	<s5h8vni6ac4.wl%tiwai@suse.de>
	<CAHG8p1BnW6v9uqFJq_UHif5Hqu9K9qZ_QZYL0SbBFxF+iJVhHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7100324597
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 07:26:59 +0100 (CET)
Received: by vcbfy13 with SMTP id fy13so6539114vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:26:58 -0800 (PST)
In-Reply-To: <CAHG8p1BnW6v9uqFJq_UHif5Hqu9K9qZ_QZYL0SbBFxF+iJVhHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> I found this bug was introduced by this commit I mentioned.
> From aplay info above, it seems if there is no plugin prior to
> mmap-emul, alsa lib will never send start cmd to driver.
>
Add some strace info,
For S32_LE:
ioctl(4, SNDRV_PCM_IOCTL_HW_REFINE, 0x2cbd854) = 0
ioctl(4, SNDRV_PCM_IOCTL_HW_PARAMS, 0x2cbd854) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4b718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SW_PARAMS, 0x2cbd044) = 0
ioctl(4, SNDRV_PCM_IOCTL_SW_PARAMS, 0x2cbd39c) = 0
ioctl(4, SNDRV_PCM_IOCTL_SW_PARAMS, 0x2cbd718) = 0
ioctl(4, SNDRV_PCM_IOCTL_PREPARE, 0xfffff000) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4b718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4b718) = 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE,
MAP_SHARED|MAP_ANONYMOUS|0x4000000, 0, 0) = 0x2e54000
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B57600 opost isig icanon echo ...}) = 0
fcntl(0, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(0, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
ioctl(0, SNDCTL_TMR_START or SNDRV_TIMER_IOCTL_TREAD or TCSETS,
{B57600 opost isig -icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B57600 opost isig -icanon echo ...}) = 0
rmdir("1.wav")                          = -1 ENOENT (No such file or directory)
open("1.wav", O_WRONLY|O_CREAT|O_LARGEFILE, 0644) = 3
write(3, "RIFF$\224\21\0WAVE", 12)      = 12
write(3, "fmt \20\0\0\0", 8)            = 8
write(3, "\1\0\2\0\200\273\0\0\0\334\5\0\10\0 \0", 16) = 16
write(3, "data\0\224\21\0", 8)          = 8
read(0, 0x2cbdb2f, 1)                   = -1 EAGAIN (Resource
temporarily unavailable)
ioctl(4, SNDRV_PCM_IOCTL_READI_FRAMES, 0x2cbdb2c) = -1 EIO (Input/output error)
write(2, "arecord", 7arecord)                  = 7
write(2, ": ", 2: )                       = 2
write(2, "pcm_read", 8pcm_read)                 = 8
write(2, ":", 1:)                        = 1
write(2, "1773", 41773)                     = 4
write(2, ": ", 2: )                       = 2
write(2, "read error: ", 12read error: )            = 12
write(2, "Input/output error", 18Input/output error)      = 18
write(2, "\n", 1

And for S16_LE:
ioctl(4, SNDRV_PCM_IOCTL_HW_REFINE, 0x2cbd0d4) = 0
ioctl(4, SNDRV_PCM_IOCTL_HW_PARAMS, 0x2cbd0d4) = -1 EINVAL (Invalid argument)
ioctl(4, SNDRV_PCM_IOCTL_HW_REFINE, 0x2cbd0d4) = 0
ioctl(4, SNDRV_PCM_IOCTL_HW_PARAMS, 0x2cbd0d4) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SW_PARAMS, 0x2cbccdc) = 0
ioctl(4, SNDRV_PCM_IOCTL_SW_PARAMS, 0x2cbd034) = 0
mmap2(NULL, 36864, PROT_READ|PROT_WRITE,
MAP_SHARED|MAP_ANONYMOUS|0x4000000, 0, 0) = 0x2e60000
ioctl(4, SNDRV_PCM_IOCTL_SW_PARAMS, 0x2cbd39c) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_PREPARE, 0xfffff000) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE,
MAP_SHARED|MAP_ANONYMOUS|0x4000000, 0, 0) = 0x2e54000
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B57600 opost isig icanon echo ...}) = 0
fcntl(0, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(0, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
ioctl(0, SNDCTL_TMR_START or SNDRV_TIMER_IOCTL_TREAD or TCSETS,
{B57600 opost isig -icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
TCGETS, {B57600 opost isig -icanon echo ...}) = 0
rmdir("1.wav")                          = -1 ENOENT (No such file or directory)
open("1.wav", O_WRONLY|O_CREAT|O_LARGEFILE, 0644) = 3
write(3, "RIFF$\312\10\0WAVE", 12)      = 12
write(3, "fmt \20\0\0\0", 8)            = 8
write(3, "\1\0\2\0\200\273\0\0\0\356\2\0\4\0\20\0", 16) = 16
write(3, "data\0\312\10\0", 8)          = 8
read(0, 0x2cbdb2f, 1)                   = -1 EAGAIN (Resource
temporarily unavailable)
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_START, 0xfffff000) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ppoll([{fd=4, events=POLLIN|POLLERR|POLLNVAL}], 1, NULL, NULL, 8) = 1
([{fd=4, revents=POLLIN}])
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_READI_FRAMES, 0x2cbd9d4) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
write(3, "\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0\352\0"...,
4096) = 4096
read(0, 0x2cbdb2f, 1)                   = -1 EAGAIN (Resource
temporarily unavailable)
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_READI_FRAMES, 0x2cbd9d4) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x2e4c718) = 0
ioctl(4, SNDRV_PCM_IOCTL_READI_FRAMES, 0x2cbd9d4) = 0

So we can see ioctl(4, SNDRV_PCM_IOCTL_START, 0xfffff000) was missed
before ioctl(4, SNDRV_PCM_IOCTL_READI_FRAMES, 0x2cbd9d4) in S32_LE
format test case.

Regards,
Scott
