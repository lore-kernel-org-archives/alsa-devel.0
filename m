From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] aplay - How to use device 3 of card 0 ?
Date: Wed, 09 Mar 2005 17:17:41 +0800
Message-ID: <422EBF35.708@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > 2) How did you perform your "WT DMA" test ?

> Using:
> aplay -d hw:0,1 test.wav

> The result for me was that aplay did newer finish, because data was
> never being transfered. After some time it timed out with an error.

The correct syntax should be  "aplay -D hw:0,3 piano.wav"


# strace aplay --verbose -D hw:0,3 piano.wav
execve("/usr/bin/aplay", ["aplay", "--verbose", "-D", "hw:0,3", 
"piano.wav"], [/* 35 vars */]) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0)                                  = 0x9b82000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=82204, ...}) = 0
old_mmap(NULL, 82204, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbf592000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\352"..., 
512) = 512fstat64(3, {st_mode=S_IFREG|0755, st_size=1901275, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xbf591000
old_mmap(NULL, 659328, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xf57000
old_mmap(0xff4000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0x9d000) = 0xff4000
close(3)                                = 0
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\365\202"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=213244, ...}) = 0
old_mmap(0x82c000, 138000, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
0x82c000
old_mmap(0x84d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x20000) = 0x84d000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\32\205"..., 
512) = 512fstat64(3, {st_mode=S_IFREG|0755, st_size=16312, ...}) = 0
old_mmap(0x850000, 12148, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x850000
old_mmap(0x852000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x1000) = 0x852000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\367"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=101264, ...}) = 0
old_mmap(0x97b000, 62436, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x97b000
old_mmap(0x988000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xd000) = 0x988000
old_mmap(0x989000, 5092, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x989000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`hp\000"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1578228, ...}) = 0
old_mmap(0x6f1000, 1281996, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
0x6f1000
old_mmap(0x824000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0x132000) = 0x824000
old_mmap(0x828000, 8140, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x828000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xbf590000
set_thread_area({entry_number:-1 -> 6, base_addr:0xbf590640, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xbf592000, 82204)               = 0
set_tid_address(0xbf590688)             = 12732
rt_sigaction(SIGRTMIN, {0x97f680, [], SA_RESTORER|SA_SIGINFO, 0x9860b0}, 
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x9b82000
brk(0x9ba3000)                          = 0x9ba3000
brk(0)                                  = 0x9ba3000
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467, 
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7467, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xbf5a6000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
read(3, "if cards.pcm.iec958\npcm.modem ca"..., 4096) = 3371
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf5a6000, 4096)                = 0
futex(0x852f70, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or 
directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or 
directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff0906c)  = 0
ioctl(3, 0x40045532, 0xbff09094)        = 0
open("/dev/snd/pcmC0D3p", O_RDWR)       = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbff08f60) = 0
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
ioctl(4, AGPIOC_INFO, 0xbff08f5c)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbff08f58) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = 0xbf5a6000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000) = 0xbf5a5000
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbff093b0) = 0
rt_sigaction(SIGINT, {0x804ac0c, [INT], SA_RESTORER|SA_RESTART, 
0x718a58}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804ac0c, [TERM], SA_RESTORER|SA_RESTART, 
0x718a58}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x804ac0c, [ABRT], SA_RESTORER|SA_RESTART, 
0x718a58}, {SIG_DFL}, 8) = 0
open("piano.wav", O_RDONLY|O_LARGEFILE) = 3
read(3, "RIFF\260O\7\0WAVEfmt \20\0\0\0\1\0\1\0", 24) = 24
read(3, "D\254", 2)                     = 2
read(3, "\0\0\210X\1\0\2\0\20\0", 10)   = 10
read(3, "data\214O\7\0", 8)             = 8
write(2, "Playing WAVE \'piano.wav\' : ", 27Playing WAVE 'piano.wav' : ) 
= 27
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian, 
) = 29
write(2, "Rate 44100 Hz, ", 15Rate 44100 Hz, )         = 15
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff08b00)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4110, 0xbff09090)        = 0
ioctl(4, 0xc25c4111, 0xbff09090)        = 0
ioctl(4, 0xc0684113, 0xbff08f60)        = 0
ioctl(4, 0x4140, 0x566)                 = 0
ioctl(4, 0xc0684113, 0xbff09020)        = 0
open("/dev/snd/controlC0", O_RDWR)      = 5
ioctl(5, USBDEVFS_CONTROL, 0xbff08dbc)  = 0
ioctl(5, UI_DEV_CREATE, 0xbff08e20)     = 0
close(5)                                = 0
write(2, "Hardware PCM card 0 \'au8830\' dev"..., 50Hardware PCM card 0 
'au8830' device 3 subdevice 0
) = 50
write(2, "\nIts setup is:\n", 15
Its setup is:
)       = 15
write(2, "stream       : PLAYBACK\n", 24stream       : PLAYBACK
) = 24
write(2, "access       : RW_INTERLEAVED\n", 30access       : RW_INTERLEAVED
) = 30
write(2, "format       : S16_LE\n", 22format       : S16_LE
) = 22
write(2, "subformat    : STD\n", 19subformat    : STD
)    = 19
write(2, "channels     : 1\n", 17channels     : 1
)      = 17
write(2, "rate         : 44100\n", 21rate         : 44100
)  = 21
write(2, "exact rate   : 44100 (44100/1)\n", 31exact rate   : 44100 
(44100/1)
) = 31
write(2, "msbits       : 16\n", 18msbits       : 16
)     = 18
write(2, "buffer_size  : 22528\n", 21buffer_size  : 22528
)  = 21
write(2, "period_size  : 2048\n", 20period_size  : 2048
)   = 20
write(2, "period_time  : 46439\n", 21period_time  : 46439
)  = 21
write(2, "tick_time    : 10000\n", 21tick_time    : 10000
)  = 21
write(2, "tstamp_mode  : NONE\n", 20tstamp_mode  : NONE
)   = 20
write(2, "period_step  : 1\n", 17period_step  : 1
)      = 17
write(2, "sleep_min    : 0\n", 17sleep_min    : 0
)      = 17
write(2, "avail_min    : 2048\n", 20avail_min    : 2048
)   = 20
write(2, "xfer_align   : 2048\n", 20xfer_align   : 2048
)   = 20
write(2, "start_threshold  : 22528\n", 25start_threshold  : 22528
) = 25
write(2, "stop_threshold   : 22528\n", 25stop_threshold   : 22528
) = 25
write(2, "silence_threshold: 0\n", 21silence_threshold: 0
)  = 21
write(2, "silence_size : 0\n", 17silence_size : 0
)      = 17
write(2, "boundary     : 1476395008\n", 26boundary     : 1476395008
) = 26
read(3, ">\375g\375\224\375\304\375\6\376Z\376\277\376=\377\316"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "\251\1\255\1\262\1\301\1\330\1\355\1\2\2\35\0025\2H\2N"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "\370\377\363\377\355\377\336\377\316\377\303\377\270\377"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "^\376\344\376|\377+\0\360\0\311\1\257\2\224\3z\4O\5\6\6"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "D\1)\1\20\1\357\0\325\0\276\0\237\0\207\0q\0]\0V\0J\000"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "|\2<\2\1\2\316\1\227\1n\1a\1T\1<\1\'\1\17\1\372\0\326\0"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "N\375\372\374\253\374`\374\"\374\366\373\333\373\317\373"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "\347\1\261\1|\1Q\0014\1%\1\25\1\f\1\t\1\1\1\367\0\347\0"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "\314\376\344\376\371\376\16\377\34\377\'\3778\377U\377"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "\r\4\7\4\365\3\325\3\247\3t\3=\3\2\3\300\2w\2 \2\302\1"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "\317\0!\1i\1\254\1\331\1\350\1\343\1\310\1\235\1h\1$\1"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = 0
read(3, "}\3\272\3\357\3\30\4:\4`\4\203\4\245\4\314\4\353\4\t\5"..., 
4096) = 4096
ioctl(4, 0x400c4150, 0xbff092b0)        = -1 EIO (Input/output error)
write(2, "aplay: pcm_write:1146: ", 23aplay: pcm_write:1146: ) = 23
write(2, "write error: Input/output error", 31write error: Input/output 
error) = 31
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?


I can only hear "hmm" sound from the speakers until the program abort.
1) Do strace indicate "data was never being transfered" ?


#dmesg

vortex: WT PARM3: 0
vortex: WT GMODE: ffffffff
vortex: WT GMODE 2 : ffffffff
vortex: wt start 0
vortex: wt stop 0
vortex: WT PARM3: cff1c810
vortex: WT GMODE: ffffffff
vortex: WT GMODE 2 : fffffffe









-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
