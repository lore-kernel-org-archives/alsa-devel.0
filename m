From: "=?gb2312?B?wO69qMCk?=" <li_jiankun@hotmail.com>
Subject: Re: I want to dmix for my MIPS board, how can I do?
Date: Tue, 8 Mar 2005 11:03:57 +0800
Message-ID: <BAY16-DAV173B7C2F11720C4F0EA531E9500@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Everyone,

  There should sth more about dmix Segment Fault on my MIPS board. The error even occurs before excuting the mix_arears1()
and mix_arears2(). The trace of the code is as followed:
	
root@192.168.100.225:~/ljk/wavtest# aplay -D dmix window11025_stereo.wav 
Segmentation fault
root@192.168.100.225:~/ljk/wavtest# strace aplay -D dmix window11025_stereo.wav 
execve("/usr/bin/aplay", ["aplay", "-D", "dmix", "window11025_stereo.wav"], [/* 19 vars */]) = 0
uname({sys="Linux", node="192.168.100.225", ...}) = 0
brk(0)                                  = 0x10000530
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=16307, ...}) = 0
old_mmap(NULL, 16307, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2aac0000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\260q\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=4459102, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaa8000
old_mmap(NULL, 1258632, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2ab00000
mprotect(0x2abf0000, 275592, PROT_NONE) = 0
old_mmap(0x2ac2f000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xef000) = 0x2ac2f000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\260E\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0555, st_size=851507, ...}) = 0
old_mmap(NULL, 810304, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2ac40000
mprotect(0x2acc6000, 261440, PROT_NONE) = 0
old_mmap(0x2ad05000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x85000) = 0x2ad05000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\260\22"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0555, st_size=148921, ...}) = 0
old_mmap(NULL, 273440, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2ad40000
mprotect(0x2ad43000, 261152, PROT_NONE) = 0
old_mmap(0x2ad82000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x2ad82000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\240E\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0555, st_size=299404, ...}) = 0
old_mmap(NULL, 368864, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2adc0000
mprotect(0x2add4000, 286944, PROT_NONE) = 0
old_mmap(0x2ae13000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x13000) = 0x2ae13000
old_mmap(0x2ae1a000, 224, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ae1a000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\204Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0555, st_size=2200545, ...}) = 0
old_mmap(NULL, 1706272, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2ae40000
mprotect(0x2af96000, 305440, PROT_NONE) = 0
old_mmap(0x2afd5000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x155000) = 0x2afd5000
old_mmap(0x2afdd000, 14624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2afdd000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaa9000
munmap(0x2aac0000, 16307)               = 0
getpid()                                = 21801
getpid()                                = 21801
rt_sigaction(SIGRT_0, {SIG_DFL}, NULL, 16) = 0
rt_sigaction(SIGRT_1, {SIG_DFL}, NULL, 16) = 0
rt_sigaction(SIGRT_2, {SIG_DFL}, NULL, 16) = 0
rt_sigprocmask(SIG_BLOCK, [32], NULL, 16) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0x7fff7930, 32, (nil), 0}) = 0
brk(0)                                  = 0x10000530
brk(0x10000560)                         = 0x10000560
brk(0x10001000)                         = 0x10001000
stat("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8010, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8010, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaa000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0x10002000)                         = 0x10002000
brk(0x10003000)                         = 0x10003000
brk(0x10004000)                         = 0x10004000
brk(0x10005000)                         = 0x10005000
read(3, " FORMAT ]\n\t@args.FILE {\n\t\ttype s"..., 4096) = 3914
brk(0x10006000)                         = 0x10006000
brk(0x10007000)                         = 0x10007000
brk(0x10008000)                         = 0x10008000
brk(0x10009000)                         = 0x10009000
brk(0x1000a000)                         = 0x1000a000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x2aaaa000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = 0
open("/etc/asound.conf", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=600, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaa000
read(3, "\npcm.ossmix {\n   type dmix\n   ip"..., 4096) = 600
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x2aaaa000, 4096)                = 0
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
getuid()                                = 0
ipc(0x2)                                = 0
ipc(0x1)                                = 0
ipc(0x17)                               = 65536
ipc(0x15)                               = 0
mlock(0x2aac0000, 1008)                 = 0
ipc(0x18)                               = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

Can anyone see sth wrong with it?

Cheers,
Li Jian-kun  

li_jiankun@hotmail.com
	2005-03-08


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
