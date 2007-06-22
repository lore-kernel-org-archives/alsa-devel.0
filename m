From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Sat, 23 Jun 2007 04:46:29 +0530
Message-ID: <61445c750706221616k5327f20et8df50fca406c630d@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE802439F
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2007 01:16:29 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so951630wag
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 16:16:29 -0700 (PDT)
In-Reply-To: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>So basically the problem is in trigger where it waits for something
>and then winds up things

It is not a problem with trigger, Strace revealed that this is an
ioctl error and after that the aplay pcm write fails. I do not get the
DMA interrupts which I should be getting.

Here is the entire log:

execve("/usr/local/bin/aplay", ["aplay", "-Dplughw:0,0",
"--rate=44100", "--format=S16", "--channels=2", "startup.wav"], [/* 7
vars */]) = 0
uname({sys="Linux", node="192.168.200.214", ...}) = 0
brk(0)                                  = 0x20000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12436, ...}) = 0
mmap2(NULL, 12436, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/usr/local/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\314\353\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0775, st_size=2164893, ...}) = 0
mmap2(NULL, 777620, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x4001e000
mprotect(0x400d0000, 48532, PROT_NONE)  = 0
mmap2(0x400d8000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb2) = 0x400d8000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\00003\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=778699, ...}) = 0
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
fstat64(3, {st_mode=S_IFREG|0644, st_size=16868, ...}) = 0
mmap2(NULL, 41152, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x4018b000
mprotect(0x4018d000, 32960, PROT_NONE)  = 0
mmap2(0x40194000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x40194000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0p?\0\0004"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=99172, ...}) = 0
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
fstat64(3, {st_mode=S_IFREG|0644, st_size=1424946, ...}) = 0
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
getpid()                                = 586
rt_sigaction(SIGRTMIN, {0x4019e980, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x4019ea3c, [RTMIN], 0x4000000 /* SA_??? */},
NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x4019eba8, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbe863ad8, 40, (nil), 0}) = 0
brk(0)                                  = 0x20000
brk(0x41000)                            = 0x41000
stat64("/usr/local/share/alsa/alsa.conf", {st_mode=S_IFREG|0664,
st_size=7764, ...}) = 0
open("/usr/local/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0664, st_size=7764, ...}) = 0
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
fstat64(3, {st_mode=S_IFREG|0664, st_size=690, ...}) = 0
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
ioctl(3, USBDEVFS_CONTROL, 0xbe863874)  = 0
ioctl(3, 0x4snd_card_omap_alsa_open start
eac->base = c4954000        = 0

open("/dev/snd/pcmC0D0p", O_RDWBefore audio init
R|O_NONBLOCKomap850_audio_init start
eac->base = c4954000
CSMI: csmi_ctl_snd_res failed
CSMI: csmi_ctl_snd failed
eac_enable_clocks start
Clocks are already enabled
omap850_audio_init end
omap850_audio_init failed
after audio init
snd_card_omap_alsa_open end
) = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbe863778) = 0
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(4, AGPIOC_INFO, 0xbe8636f0)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbe8636ec) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = -1 ENXIO (No
such device or address)
ioctl(4, 0xc0844123, 0xbe8636f4)        = 0
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(4, F_SETFL, O_RDWR)             = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbe863ccc) = 0
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
ioctl(4, 0xc25c4110, 0xbe8635f4)        = 0
ioctl(4, 0xc25c4110, 0xbe8632e8)        = 0
ioctl(4, 0xc25c4110, 0xbe8632e8)        = 0
ioctl(4, 0xc25c4110, 0xbe8635f4)        = 0
ioctl(4, 0xc25c4110, 0xbe8632e8)        = 0
ioctl(4, 0xc25c4110, 0xbe8632e8)        = 0
ioctl(4, 0xc25c4110, 0xbe8635f4)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(snd_omap_alsa_hw_params start
4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xcsnd_omap_alsa_prepare start
snd_omap_alsa_prepare end   = 0

ioctl(4, 0xc25c4110, 0xbe86305cSNDRV_PCM_IOCTL1_RESET
)        = 0
ioctl(4, 0xc25c411Inside snd_pcm_lib_ioctl_reset
0, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe86305c)        = 0
ioctl(4, 0xc25c4110, 0xbe863368)        = 0
ioctl(4, 0xc25c4110, 0xbe862e6c)        = 0
ioctl(4, 0xc25c4110, 0xbe862b60)        = 0
ioctl(4, 0xc25c4110, 0xbe862b60)        = 0
ioctl(4, 0xc25c4110, 0xbe862e6c)        = 0
ioctl(4, 0xc25c4110, 0xbe862b60)        = 0
ioctl(4, 0xc25c4110, 0xbe862b60)        = 0
ioctl(4, 0xc25c4110, 0xbe862e6c)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe8630d4)        = 0
ioctl(4, 0xc25c4110, 0xbe863564)        = 0
ioctl(4, 0xc25c4110, 0xbe863564)        = 0
ioctl(4, 0xc25c4110, 0xbe863564)        = 0
ioctl(4, 0xc25c4110, 0xbe863564)        = 0
ioctl(4, 0xc25c4110, 0xbe863564)        = 0
ioctl(4, 0xc25c4110, 0xbe863904)        = 0
ioctl(4, 0xc25c4111, 0xbe863904)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
ioctl(4, 0xc0684113, 0xbe8634c4)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
ioctl(4, 0x4140, 0x400c3ed4)            = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
ioctl(4, 0xc0684113, 0xbe863898)        = 0
read(3, "\377\377\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\377\377\0\0\1\0\0\0\0\0\0\0\377\377\376\377\0\0\3\0\377"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\374\377\7\0\0\0\0\0\372\377\0\0\376\377\3\0\3\0\373\377"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\373\377\1\0\377\377\5\0\376\377\372\377\377\377\7\0\6"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\212\377{\377\212\377\210\377\220\377\226\377\214\377\213"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, ".\324\326\3438\323Q\343\375\322\34\343\254\323\223\343"...,
8192Inside snd_pcm_do_start
snd_omap_alsa_trigger start
audio_start_dma_chain start
Inside omap_start_dma 1
Inside omap_start_dma 2
Inside omap_start_dma 3
audio_start_dma_chain end
snd_omap_alsa_trigger end
) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           =Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
Count is 34
 Offset is 4294967288 and buffer size is 16384
Inside snd_pcm_update_hw_ptr_pos, pos is 0
 0
read(3, "\2\fK\0x\v\220\375\361\n_\373\246\n\270\371\235\n;\371"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "\336\327R\357\277\330\361\357\256\331\211\360d\332(\361"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = 0
ioctl(4, 0xc0844123, 0x27e10)           = 0
read(3, "H\343#\355\233\342\317\355\377\341\312\356\216\341\250"...,
8192) = 8192
ioctl(4, 0x400c4150, 0xbe863bf0)        = -1 EIO (Input/output error)
write(2, "aplay: pcm_write:1268: ", 23aplay: pcm_write:1268: ) = 23
write(2Inside snd_pcm_do_stop
snd_omap_alsa_trigger start
audio_stop_dma start
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
submit(0x1, 0, 0x4eac_disable_clocks start
eac_disable_clocks end
CSMI: csmi_ctl_snd_res failed
CSMI: csmi_ctl_snd failed
omap850_audio_shutdown end
snd_card_omap_alsa_close end
 <unfinished ... exit status 1>
Process 586 detached

On 6/23/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi
>
> I am testing my audio driver using aplay. I trying to play an audio file
> using:
>
> #aplay -Dplughw:0,0 --rate=44100 --format=S16 --channels=2 test.wav
>  The log is as follows,
>
> snd_card_omap_alsa_open start
> snd_card_omap_alsa_open end
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> snd_omap_alsa_hw_params start
> snd_omap_alsa_prepare start
> snd_omap_alsa_prepare end
> snd_omap_alsa_trigger start
> audio_start_dma_chain start
> audio_start_dma_chain end
> omap_start_alsa_sound_dma end
> snd_omap_alsa_trigger end
> snd_omap_alsa_pointer start
> audio_get_dma_pos start
> audio_get_dma_pos end
>
> It waits here for sometime and then I get
> snd_omap_alsa_trigger starte error: Input/output error
>
> Then the things are wound up as:
>
> audio_stop_dma start
> omap_stop_alsa_sound_dma start
> omap_stop_alsa_sound_dma end
> omap_clear_alsa_sound_dma start
> omap_clear_alsa_sound_dma end
> snd_omap_alsa_trigger end
>
> snd_omap_alsa_hw_free start
> snd_omap_alsa_hw_free end
> snd_card_omap_alsa_close start
> snd_card_omap_alsa_close end
>
>
> So basically the problem is in trigger where it waits for something
> and then winds up things. Any idea, what could be the reason. I am
> thinking it has to do something with
> DMA interrupts etc.
>
