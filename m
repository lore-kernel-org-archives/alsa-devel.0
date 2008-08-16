From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Re: Configure and use dmix with a new ASoC driver
Date: Sat, 16 Aug 2008 19:17:19 +0000 (UTC)
Message-ID: <loom.20080816T190958-341@post.gmane.org>
References: <loom.20080816T061550-625@post.gmane.org>
	<20080816165641.GA24879@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F3A6243BA
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 21:17:31 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KURHD-0005YL-VL
	for alsa-devel@alsa-project.org; Sat, 16 Aug 2008 19:17:28 +0000
Received: from modemcable024.51-130-66.mc.videotron.ca ([66.130.51.24])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2008 19:17:27 +0000
Received: from bidou by modemcable024.51-130-66.mc.videotron.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2008 19:17:27 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie <at> sirena.org.uk> writes:

> 
> On Sat, Aug 16, 2008 at 06:27:02AM +0000, Simon Tremblay wrote:
> 
> > # aplay -v -D plug:dmix /media/usb0/tada.wav
> > aplay: main:545: audio open error: Operation not permitted
> 
> This doesn't ring any specific bells for me but since you are cross
> building and can play without dmix I would be looking at installation
> issues with your ALSA user space or a missing device file it needs.
> stracing aplay may well provide a useful clue as to what's missing.
> 

Thanks for the help, I used strace on aplay and I think it's that ouput is wrong:


open("/usr/lib/libasound.so.2", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=712960, ...}) = 0
close(3)                                = 0
open("/etc/group", O_RDONLY)            = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbedc77a0) = -1 ENOTTY (Inappropriate
ioctl for device)
read(3, "root:x:0:\ndaemon:x:1:\nbin:x:2:\ns"..., 4096) = 204
close(3)                                = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 1966080
SYS_300(0x1e0000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x1e0000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x1e0000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x1e0000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 1998848
SYS_300(0x1e8000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x1e8000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x1e8000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x1e8000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2031616
SYS_300(0x1f0000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x1f0000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x1f0000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x1f0000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2064384
SYS_300(0x1f8000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x1f8000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x1f8000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x1f8000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2097152
SYS_300(0x200000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x200000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x200000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x200000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2129920
SYS_300(0x208000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x208000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x208000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x208000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2162688
SYS_300(0x210000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x210000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x210000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x210000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2195456
SYS_300(0x218000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x218000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x218000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x218000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2228224
SYS_300(0x220000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x220000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x220000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x220000, 0, 0x100, 0, 0x26d00) = 0
SYS_299(0x56a4d5, 0x1, 0x3b0, 0xffffffff, 0x26d00) = 2260992
SYS_300(0x228000, 0, 0x102, 0xbedc7850, 0) = 0
SYS_300(0x228000, 0, 0x101, 0xbedc7850, 0) = 0
SYS_298(0x228000, 0xbedc788c, 0x2, 0x10, 0) = -1 EFBIG (File too large)
SYS_300(0x228000, 0, 0x100, 0, 0x26d00) = 0
write(2, "aplay", 5aplay)                    = 5
write(2, ": ", 2: )                       = 2
write(2, "main", 4main)                     = 4
write(2, ":", 1:)                        = 1
write(2, "545", 3545)                      = 3
write(2, ": ", 2: )                       = 2
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
write(2, "audio open error: ", 18audio open error: )      = 18
write(2, "Operation not permitted", 23Operation not permitted) = 23
write(2, "\n", 1
)                       = 1
exit(1)                                 = ?
Process 1190 detached


I don't know what is SYS_xxx but EFBIG (File too large) seems to refer that
something is too big to be opened?

When I check ulimit I get this:

# ulimit -a
time(seconds)        unlimited
file(blocks)         unlimited
data(kbytes)         unlimited
stack(kbytes)        8192
coredump(blocks)     0
memory(kbytes)       unlimited
locked memory(kbytes) 32
process              512
nofiles              1024
vmemory(kbytes)      unlimited
locks                unlimited

I think all it's ok about that and since it's the same file I want to play with
-D plug:dmix ...

Humm I will check with ALSA installation issues...

Must I create a .conf file for my tlv320aic23b codec or it's ok if I don't have
one?
