From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Mon, 25 Jun 2007 19:05:23 +0530
Message-ID: <61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
	<61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 464C010380B
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 15:35:25 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1216846nzf
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 06:35:24 -0700 (PDT)
In-Reply-To: <61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is the log, it seems that the pointer function is not working. I
am not supposed to use printks in many automic functions but I dont
have any other debugging option.


snd_card_omap_alsa_open start

omap850_audio_init start

eac_enable_clocks start
Clocks are already enabled
eac_set_samplerate start

eac_set_samplerate end

audio_dma_request start
omap_request_alsa_sound_dma start
omap_request_alsa_sound_dma end
snd_card_omap_alsa_open end
Playing WAVE 'startup.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
snd_omap_alsa_hw_params start
data format is 2 -- Channel 0 rate =2 and buffer size is ac44
snd_omap_alsa_hw_params end
snd_omap_alsa_prepare start
audio_configure_dma_channel start
dma_size is 2000
dma_ptr is c3fa0000
snd_omap_alsa_prepare end
SNDRV_PCM_IOCTL1_RESET
Inside snd_pcm_lib_ioctl_reset
Inside snd_pcm_do_start
snd_omap_alsa_trigger start
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
Inside omap_start_dma 1
Inside omap_start_dma 2
Inside omap_start_dma 3
audio_start_dma_chain end
Reading from c4954180
snd_omap_alsa_trigger end
sound_dma_irq_handler start
!!! In DMA IRQ handler
lch=0,status=0x20, dma_status=32, data=c3cb5104
callback_omap_alsa_sound_dma start
Inside /snd_pcm_period_elapsed
Inside snd_pcm_update_hw_ptr_interrupt
Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
 audio stream->offset is 1000000
 runtime->framebits is 20
Count is 8192
 Offset is 4192256 and buffer size is 16384
Inside snd_pcm_update_hw_ptr_pos, pos is 0
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
audio_start_dma_chain end
Reading from c4954180
sound_dma_irq_handler end

Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
 audio stream->offset is 2000
 runtime->framebits is 20
Count is 8192
 Offset is 0 and buffer size is 16384
Inside snd_pcm_update_hw_ptr_pos, pos is 0
/*Is waits here for sometime and then following error*/

Inside snd_pcm_do_stop write error: Input/output error


snd_omap_alsa_trigger start
audio_stop_dma start
omap_stop_alsa_sound_dma end
omap_clear_alsa_sound_dma start
omap_clear_alsa_sound_dma end
snd_omap_alsa_trigger end

snd_omap_alsa_hw_free start
snd_omap_alsa_hw_free end
snd_card_omap_alsa_close start
omap850_audio_shutdown start

eac_disable_clocks start
eac_disable_clocks end
omap850_audio_shutdown end
audio_dma_free start
omap_free_alsa_sound_dma start
omap_sound_dma_unlink_lch start
omap_sound_dma_unlink_lch end
omap_free_alsa_sound_dma end
snd_card_omap_alsa_close end


And detailed log using strace


# strace aplay -Dplughw:0,0 --rate=44100 --format=S16 --channels=2 startup.wav
execve("/usr/local/bin/aplay", ["aplay", "-Dplughw:0,0",
"--rate=44100", "--format=S16", "--channels=2", "startup.wav"], [/* 7
vars */]) = 0
uname({sys="Linux", node="192.168.200.217", ...}) = 0
brk(0)                                  = 0x20000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0777, st_size=12436, ...}) = 0
mmap2(NULL, 12436, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/usr/local/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\314\353\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0777, st_size=2164893, ...}) = 0
mmap2(NULL, 777620, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x4001e000
mprotect(0x400d0000, 48532, PROT_NONE)  = 0
mmap2(0x400d8000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb2) = 0x400d8000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\00003\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0777, st_size=778699, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40019000
mmap2(NULL, 713068, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x400dc000
mprotect(0x40182000, 33132, PROT_NONE)  = 0
mmap2(0x40189000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa5) = 0x40189000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\344\v\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0777, st_size=16868, ...}) = 0
mmap2(NULL, 41152, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x4018b000
mprotect(0x4018d000, 32960, PROT_NONE)  = 0
mmap2(0x40194000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x40194000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0p?\0\0004"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0777, st_size=99172, ...}) = 0
mmap2(NULL, 367928, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40196000
mprotect(0x401a5000, 306488, PROT_NONE) = 0
mmap2(0x401ac000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe) = 0x401ac000
mmap2(0x401ae000, 269624, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401ae000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0HM\1\0004"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0777, st_size=1424946, ...}) = 0
mmap2(NULL, 1132932, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0x401f0000
mprotect(0x402f7000, 55684, PROT_NONE)  = 0
mmap2(0x402ff000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x107) = 0x402ff000
mmap2(0x40303000, 6532, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40303000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001a000
mprotect(0x402ff000, 8192, PROT_READ)   = 0
mprotect(0x401ac000, 4096, PROT_READ)   = 0
mprotect(0x40194000, 4096, PROT_READ)   = 0
mprotect(0x40189000, 4096, PROT_READ)   = 0
mprotect(0x4001c000, 4096, PROT_READ)   = 0
munmap(0x40015000, 12436)               = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 613
rt_sigaction(SIGRTMIN, {0x4019e980, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x4019ea3c, [RTMIN], 0x4000000 /* SA_??? */},
NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x4019eba8, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbed04ad8, 40, (nil), 0}) = 0
brk(0)                                  = 0x20000
brk(0x41000)                            = 0x41000
stat64("/usr/local/share/alsa/alsa.conf", {st_mode=S_IFREG|0777,
st_size=7764, ...}) = 0
open("/usr/local/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0777, st_size=7764, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40015000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
read(3, "cards.pcm.surround40\npcm.surroun"..., 4096) = 3668
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = 0
open("/etc/asound.conf", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0777, st_size=690, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40015000
read(3, "pcm.headset {\n\t@args [BDADDR TIM"..., 4096) = 690
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
access("//.asoundrc", R_OK)             = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbed04874)  = 0
ioctl(3, 0x4snd_card_omap_alsa_open start
eac->base = c4954000        = 0

open("/dev/snd/pcmC0D0p", O_RDWBefore audio init
R|O_NONBLOCKomap850_audio_init start
eac_enable_clocks start
Clocks are already enabled
eac_set_samplerate start
Reading from c4954178
eac_set_samplerate end
after audio init
audio_dma_request start
omap_request_alsa_sound_dma start
omap_request_alsa_sound_dma end
snd_card_omap_alsa_open end
) = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbed04778) = 0
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(4, AGPIOC_INFO, 0xbed046f0)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbed046ec) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = -1 ENXIO (No
such device or address)
ioctl(4, 0xc0844123, 0xbed046f4)        = 0
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(4, F_SETFL, O_RDWR)             = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbed04ccc) = 0
rt_sigaction(SIGINT, {0x401a28ac, [INT], SA_RESTART|0x4000000},
{SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x401a28ac, [TERM], SA_RESTART|0x4000000},
{SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x401a28ac, [ABRT], SA_RESTART|0x4000000},
{SIG_DFL}, 8) = 0
open("startup.wav", O_RDONLY|O_LARGEFILE) = 3
read(3, "RIFF(\310\24\0WAVEfmt \20\0\0\0\1\0\2\0", 24) = 24
read(3, "D\254\0\0", 4)                 = 4
read(3, "\20\261\2\0\4\0\20\0", 8)      = 8
read(3, "data\4\310\24\0", 8)           = 8
write(2, "Playing WAVE \'startup.wav\' : ", 29Playing WAVE
'startup.wav' : ) = 29
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian, ) = 29
write(2, "Rate 44100 Hz, ", 15Rate 44100 Hz, )         = 15
write(2, "Stereo", 6Stereo)                   = 6
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbed045f4)        = 0
ioctl(4, 0xc25c4110, 0xbed042e8)        = 0
ioctl(4, 0xc25c4110, 0xbed042e8)        = 0
ioctl(4, 0xc25c4110, 0xbed045f4)        = 0
ioctl(4, 0xc25c4110, 0xbed042e8)        = 0
ioctl(4, 0xc25c4110, 0xbed042e8)        = 0
ioctl(4, 0xc25c4110, 0xbed045f4)        = 0
ioctl(4, 0xc25c4110, 0xbed04368)        = 0
ioctl(4, 0xc25c4110, 0xbed0405c)        = 0
ioctl(4, 0xc25c4110, 0xbed0405c)        = 0
ioctl(4, 0xc25c4110, 0xbed04368)        = 0
ioctl(4, 0xc25c4110, 0xbed04368)        = 0
ioctl(4, 0xc25c4110, 0xbed0405c)        = 0
ioctl(4, 0xc25c4110, 0xbed0405c)        = 0
ioctl(4, 0xc25c4110, 0xbed04368)        = 0
ioctl(4, 0xc25c4110snd_omap_alsa_hw_params start
, 0xbed0405c)        = 0
ioctl(data format is 2 -- Channel 0 rate =2 and buffer size is ac44
4, 0xc25c4110, 0xbed0405c)      snd_omap_alsa_hw_params end
  = 0
ioctl(4, 0xc25c4110, 0xbed04368)        = 0
snd_omap_alsa_prepare start4368)        = 0

ioctl(4, 0xc25c4110, 0xbed0405caudio_configure_dma_channel start
)        = 0
ioctl(4, 0xc25c411dma_size is 2000
0, 0xbed0405c)        = 0
ioctldma_ptr is c3f20000
(4, 0xc25c4110, 0xbed04368)     snd_omap_alsa_prepare end
   = 0
ioctl(4, 0xc25c4110, 0xbSNDRV_PCM_IOCTL1_RESET
ed0405c)        = 0
ioctl(4, 0xInside snd_pcm_lib_ioctl_reset
c25c4110, 0xbed0405c)        = 0
ioctl(4, 0xc25c4110, 0xbed04368)        = 0
ioctl(4, 0xc25c4110, 0xbed03e6c)        = 0
ioctl(4, 0xc25c4110, 0xbed03b60)        = 0
ioctl(4, 0xc25c4110, 0xbed03b60)        = 0
ioctl(4, 0xc25c4110, 0xbed03e6c)        = 0
ioctl(4, 0xc25c4110, 0xbed03b60)        = 0
ioctl(4, 0xc25c4110, 0xbed03b60)        = 0
ioctl(4, 0xc25c4110, 0xbed03e6c)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed040d4)        = 0
ioctl(4, 0xc25c4110, 0xbed04564)        = 0
ioctl(4, 0xc25c4110, 0xbed04564)        = 0
ioctl(4, 0xc25c4110, 0xbed04564)        = 0
ioctl(4, 0xc25c4110, 0xbed04564)        = 0
ioctl(4, 0xc25c4110, 0xbed04564)        = 0
ioctl(4, 0xc25c4110, 0xbed04904)        = 0
ioctl(4, 0xc25c4111, 0xbed04904)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
ioctl(4, 0xc0684113, 0xbed044c4)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
ioctl(4, 0x4140, 0x400c3ed4)            = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
ioctl(4, 0xc0684113, 0xbed04898)        = 0
read(3, "\377\377\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\377\377\0\0\1\0\0\0\0\0\0\0\377\377\376\377\0\0\3\0\377"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\374\377\7\0\0\0\0\0\372\377\0\0\376\377\3\0\3\0\373\377"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\373\377\1\0\377\377\5\0\376\377\372\377\377\377\7\0\6"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\212\377{\377\212\377\210\377\220\377\226\377\214\377\213"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, ".\324\326\3438\323Q\343\375\322\34\343\254\323\223\343"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\2\fK\0x\v\220\375\361\n_\373\246\n\270\371\235\n;\Inside
snd_pcm_do_start
snd_omap_alsa_trigger start
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
Inside omap_start_dma 1
Inside omap_start_dma 2
Inside omap_start_dma 3
audio_start_dma_chain end
Reading from c4954180
snd_omap_alsa_trigger end
371"..., 8192) = 8192
ioctl(4, sound_dma_irq_handler start
0x400c4150, 0xbed04bf0)        =!!! In DMA IRQ handler
lch=0,status=0x20, dma_status=32, data=c3cb9884
 0
ioctl(4, 0xc0844123, 0x27e10callback_omap_alsa_sound_dma start
)           = 0
read(3, "\336\3Inside /snd_pcm_period_elapsed
27R\357\277\330\361\357\256\331\Inside snd_pcm_update_hw_ptr_interrupt
Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
 audio stream->offset is 1000000
 runtime->framebits is 20
Count is 8192
 Offset is 4192256 and buffer size is 16384
Inside snd_pcm_update_hw_ptr_pos, pos is 0
211\360d\332(\361"..., 8192) = 8audio_set_dma_params_play start
192
ioctl(4, 0x400c4150audio_set_dma_params_play end
audio_start_dma_chain start
audio_start_dma_chain end
Reading from c4954180
sound_dma_irq_handler end
, 0xbed04bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "H\343#\3Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
 audio stream->offset is 2000
 runtime->framebits is 20
Count is 8192
 Offset is 0 and buffer size is 16384
Inside snd_pcm_update_hw_ptr_pos, pos is 0
55\233\342\317\355\377\341\312\356\216\341\250"..., 8192) = 8192
ioctl(4, 0x400c4150


/**********waits here **************/
0xbed04bf0)        = -1 EIO (Input/output error)
write(2, "aplay: pcm_write:1268: ", 23aplay: pcm_write:1268: ) = 23
write(2Inside snd_pcm_do_stop
snd_omap_alsa_trigger start
audio_stop_dma start
Reading from c4954180
before writing to EAC_AGCTR = 60
aftere writing to EAC_AGCTR = 60
omap_stop_alsa_sound_dma end
omap_clear_alsa_sound_dma start
omap_clear_alsa_sound_dma end
snd_omap_alsa_trigger end
, "write error: Input/output errsnd_omap_alsa_hw_free start
or", 31write error: Input/outputsnd_omap_alsa_hw_free end
 error) = 31
write(2, "\n", 1
snd_card_omap_alsa_close start
)                       = 1
io_omap850_audio_shutdown start
submit(0x1, 0, 0x4Reading from c4954180
eac_disable_clocks start
eac_disable_clocks end

omap850_audio_shutdown end
audio_dma_free start
omap_free_alsa_sound_dma start
omap_sound_dma_unlink_lch start
omap_sound_dma_unlink_lch end
omap_free_alsa_sound_dma end
snd_card_omap_alsa_close end
 <unfinished ... exit status 1>
Process 613 detached




On 6/25/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> On 6/25/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > Pharaoh . wrote:
> > > >The ALSA framework will stop the stream and return the error code EIO
> > > >when there was no interrupt for ten seconds, i.e., when
> > > >snd_pcm_period_elapsed() was not called.
> > >
> > > I am getting the interrupts, but why there wont be any interrupt for
> > > 10 seconds?
> >
> > I don't quite understand this sentence.  You do get interrupts?
> > And snd_pcm_period_elapsed() is not called?
> >
> > > I am setting the periods in prepare as periods = runtime->period, so
> > > interrupts should at period boundaries.
> >
> > runtime->periods is the number of periods.  I don't know how your
> > hardware works, but I guess it wants to know the period size, i.e.,
> > runtime->period_size converted to bytes.
> >
> >
> > Regards,
> > Clemens
> >
>
>
> Apologie for being ambiguous...
>
> 1. When I posted the question, I was not even getting the DMA
> interrupts. The input/output error was present.
>
> 2. After modifying the code a little I started getting the DMA
> interrupts, but the input/output error still persists. So I am
> doubting I might have messed up with the
> period size etc.
>
> 3. I am assigning s->periods = runtime->period i.e. without converting
> them in bytes, in prepare (I have seen some standard omap drivers
> doing the same, so I am not converting it to bytes, frames should be
> okay, but I will check this in h/w manual) and I take care in trigger
> too by updating the s->periods field.
>
> 4. Also, s->period is locked appropriately so dont think it is corrupted.
>
> I am attaching the source file, I have attached only 1 file since I
> think it is relevant. Will send the log once I get chance to test it
> again.
>
