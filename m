From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002244]: Aureon 7.1 Universe speakers
	in incorrect order when doing a speaker-test
Date: Wed, 19 Jul 2006 18:22:22 +0200
Message-ID: <e2e2dc1b026b47658f910bf2405e8b68@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 195F3162
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 18:22:23 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2244> 
======================================================================
Reported By:                calestyo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2244
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
======================================================================
Date Submitted:             06-29-2006 01:35 CEST
Last Modified:              07-19-2006 18:22 CEST
======================================================================
Summary:                    Aureon 7.1 Universe speakers in incorrect order when
doing a speaker-test
Description: 
I use my Aureon 7.1 Universe with a TerraTec HomeAreon TXR 884 7.1 speaker
set.

I've connected the outputs of the soundard to those of the subwoofer
which
itself connects the small speakers the following way:

Soundcard -------------- Subwoofer --- Small Speakers
Out Front <---------+--> In FL <-----> Front Left Speaker
                    \--> In FR <-----> Font Right Speaker
Out Rear <----------+--> In SL <-----> Side Left Speaker
                    \--> In SR <-----> Side Right Speaker
Out Center/Subwoofer <-> In C <------> Center Speaker
                      \> In Subwoofer
Out Back Surround <----> In BL <-----> Back Left Speaker
                    \--> In BR <-----> Back Right Speaker

You might have a look at soundcard manual page 8
(http://supportuk.terratec.net/modules.php?op=modload&name=Downloads&file=index&req=getit&lid=574)
and speaker manual page 12
(http://supportuk.terratec.net/modules.php?op=modload&name=Downloads&file=index&req=getit&lid=724)
My speakers are placed in my room in a configuration as the 7.1 shown on
page 12
in the speaker manual.

As you note the connection from rear to side is a little bit strange (at
least I
thought so,...) but this seems to be correct, because when I use the
windows
mixer supplied by TerraTec itself, there is a surround test included which
shows
the position of the 8 speakers and let me put the indiviually on and off
and
this leads always to the correct position.

The problem now: I tried the same as under Windows unter Linux with the
speaker-test tool.
I called it via speaker-test -t wav -c 8 and the following came out:
What wav file was played ----- in which speaker position the wav file was
played
"Front Left" ----------------- Front Left Speaker  (correct)
"Front Center" --------------- Center Speaker      (correct)
"Front Right" ---------------- Front Right Speaker (correct)
"Side Right" ----------------- Back Right Speaker  (probably wrong!)
"Rear Right" ----------------- Side Right Speaker  (probably wrong!)
"Rear Left" ------------------ Side Left Speaker  (probably wrong!)
"Side Left" ------------------ Back Left Speaker  (probably wrong!)
"LFE" ------------------------ Subwoofer (correct)

No one could think that I should just switch the speaker cables but that
can't
be a proper solution (not only because this would break settings in the
original
Windows driver (which I only use for Upgrading my Plextor drive firmware
;) ).
I think the configuration of the surround for the Aureon 7.1 Universe has
here
some mistake, hasn't it?
======================================================================

----------------------------------------------------------------------
 calestyo - 07-19-06 18:21 
----------------------------------------------------------------------
>Seem alsa-lib cannot find some conf file
Ok,.. I suppose you've seen the notes that are gone
Yes,.. as I've posted I've had noted this too. I've also checked if the
files in /usr/share/alsa/ are there and have correct permissions...

One other thing that I've noticed.
When using the hg-repos kernel drivers with Debian sid alsalibs (but
changing the alias name in /usr/shar/alsa/cards ... specfing stuff like -D
plug:side or plug:rear works just fine...
Without the "plug:" it doesn't work however.
So the most recent problems may be unrelated to ice1724...
Anyway,... the order of the boxes still seems to be wrong ;)

----------------------------------------------------------------------
 calestyo - 07-19-06 18:22 
----------------------------------------------------------------------
$ strace aplay /usr/share/sounds/alsa/Noise.wav
execve("/usr/bin/aplay", ["aplay", "/usr/share/sounds/alsa/Noise.wav"...],
[/* 31 vars */]) = 0
uname({sys="Linux", node="euler", ...}) = 0
brk(0)                                  = 0x50c000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2ae8e835e000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=73267, ...}) = 0
mmap(NULL, 73267, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2ae8e8360000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\356"..., 640)
= 640
fstat(3, {st_mode=S_IFREG|0755, st_size=3296456, ...}) = 0
mmap(NULL, 1930632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0x2ae8e845f000
mprotect(0x2ae8e852f000, 1078664, PROT_NONE) = 0
mmap(0x2ae8e862f000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd0000) = 0x2ae8e862f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320=\0\0"..., 640)
= 640
fstat(3, {st_mode=S_IFREG|0644, st_size=548016, ...}) = 0
mmap(NULL, 1593800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0x2ae8e8637000
mprotect(0x2ae8e86bc000, 1049032, PROT_NONE) = 0
mmap(0x2ae8e87bb000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x84000) = 0x2ae8e87bb000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\20\0\0"..., 640)
= 640
fstat(3, {st_mode=S_IFREG|0644, st_size=10392, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2ae8e87bd000
mmap(NULL, 1057000, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0x2ae8e87be000
mprotect(0x2ae8e87c0000, 1048808, PROT_NONE) = 0
mmap(0x2ae8e88bf000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x2ae8e88bf000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0PV\0\0\0"..., 640)
= 640
fstat(3, {st_mode=S_IFREG|0644, st_size=97401, ...}) = 0
mmap(NULL, 1131368, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0x2ae8e88c1000
mprotect(0x2ae8e88d1000, 1065832, PROT_NONE) = 0
mmap(0x2ae8e89d0000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x2ae8e89d0000
mmap(0x2ae8e89d2000, 13160, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ae8e89d2000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\305"..., 640)
= 640
lseek(3, 624, SEEK_SET)                 = 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0"..., 32) =
32
fstat(3, {st_mode=S_IFREG|0755, st_size=1295640, ...}) = 0
mmap(NULL, 2354344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0x2ae8e89d6000
mprotect(0x2ae8e8afa000, 1158312, PROT_NONE) = 0
mmap(0x2ae8e8bf9000, 98304, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x123000) = 0x2ae8e8bf9000
mmap(0x2ae8e8c11000, 15528, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ae8e8c11000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2ae8e8c15000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2ae8e8c16000
mprotect(0x2ae8e8bf9000, 86016, PROT_READ) = 0
arch_prctl(ARCH_SET_FS, 0x2ae8e8c161c0) = 0
munmap(0x2ae8e8360000, 73267)           = 0
set_tid_address(0x2ae8e8c16250)         = 11689
rt_sigaction(SIGRTMIN, {0x2ae8e88c61e0, [], SA_RESTORER|SA_SIGINFO,
0x2ae8e88cd7a0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x2ae8e88c6260, [],
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x2ae8e88cd7a0}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0x7fffc275fb80, 44, (nil), 0}) = 0
brk(0)                                  = 0x50c000
brk(0x52d000)                           = 0x52d000
open("/usr/lib/locale/locale-archive", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=1179088, ...}) = 0
mmap(NULL, 1179088, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2ae8e8c17000
close(3)                                = 0
stat("/root/test/alsa/hgrepos/alsa-lib//share/alsa/alsa.conf",
0x7fffc275fba0) = -1 EACCES (Permission denied)
write(2, "ALSA lib pcm.c:2143:(snd_pcm_ope"..., 44ALSA lib
pcm.c:2143:(snd_pcm_open_noupdate) ) = 44
write(2, "Unknown PCM default", 19Unknown PCM default)     = 19
write(2, "\n", 1
)                       = 1
write(2, "aplay: main:547: ", 17aplay: main:547: )       = 17
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2582, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2ae8e8d37000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2582
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x2ae8e8d37000, 4096)            = 0
open("/usr/share/locale/en_DE/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT
(No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT
(No such file or directory)
open("/usr/share/locale/en_GB/LC_MESSAGES/libc.mo", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=1474, ...}) = 0
mmap(NULL, 1474, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2ae8e8d37000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No such
file or directory)
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=45660, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2ae8e8d38000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
read(3, "lias\tJS//\t\t\tJUS_I.B1.002//\nalias"..., 4096) = 4096
read(3, "ule\tINTERNAL\t\tISO-8859-3//\t\tISO8"..., 4096) = 4096
read(3, "lias\tISO-IR-199//\t\tISO-8859-14//"..., 4096) = 4096
read(3, "\t\tto\t\t\tmodule\t\tcost\nalias\tCSEBCD"..., 4096) = 4096
read(3, "ule\t\tcost\nalias\tCP284//\t\t\tIBM284"..., 4096) = 4096
read(3, "lias\tCP864//\t\t\tIBM864//\nalias\t86"..., 4096) = 4096
read(3, "module\tIBM937//\t\tINTERNAL\t\tIBM93"..., 4096) = 4096
read(3, "\tEUC-JP//\nalias\tUJIS//\t\t\tEUC-JP/"..., 4096) = 4096
read(3, "module\t\tcost\nalias\tISO-IR-143//\t"..., 4096) = 4096
read(3, "-BOX//\nmodule\tISO_10367-BOX//\t\tI"..., 4096) = 4096
read(3, "module\tINTERNAL\t\tEUC-JISX0213//\t"..., 4096) = 604
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x2ae8e8d38000, 4096)            = 0
futex(0x2ae8e8c10bb0, FUTEX_WAKE, 2147483647) = 0
brk(0x54e000)                           = 0x54e000
open("/usr/share/locale/en_DE/LC_MESSAGES/alsa-utils.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/alsa-utils.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/alsa-utils.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en_GB/LC_MESSAGES/alsa-utils.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
write(2, "audio open error: No such file o"..., 43audio open error: No
such file or directory) = 43
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?
Process 11689 detached

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:35 calestyo       New Issue                                    
06-29-06 01:35 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:35 calestyo       Kernel Version            => 2.6.17          
06-29-06 01:36 calestyo       Note Added: 0010634                          
06-29-06 01:36 calestyo       Issue Monitored: calestyo                    
06-29-06 15:29 Raymond        Note Added: 0010647                          
06-29-06 15:36 calestyo       Note Added: 0010648                          
06-29-06 15:37 calestyo       Note Added: 0010649                          
06-29-06 15:40 Raymond        Note Added: 0010650                          
06-29-06 15:45 calestyo       Note Added: 0010651                          
06-29-06 15:52 Raymond        Note Added: 0010652                          
06-29-06 15:54 Raymond        Note Edited: 0010652                         
06-29-06 15:56 calestyo       Note Added: 0010653                          
06-29-06 15:58 Raymond        Note Added: 0010654                          
06-29-06 16:01 calestyo       Note Added: 0010655                          
06-29-06 16:04 Raymond        Note Added: 0010656                          
06-29-06 16:07 calestyo       Note Added: 0010657                          
06-29-06 16:08 Raymond        Note Edited: 0010656                         
06-29-06 16:12 Raymond        Note Added: 0010658                          
06-29-06 16:19 calestyo       Note Added: 0010659                          
06-29-06 17:50 tiwai          Note Added: 0010677                          
06-29-06 19:05 calestyo       Note Added: 0010695                          
06-30-06 02:02 Raymond        Note Added: 0010709                          
06-30-06 02:14 rlrevell       Note Added: 0010711                          
06-30-06 05:13 Raymond        Note Edited: 0010709                         
07-03-06 19:28 calestyo       Note Added: 0010803                          
07-03-06 19:37 rlrevell       Note Added: 0010804                          
07-17-06 20:49 calestyo       Note Added: 0011049                          
07-18-06 03:23 calestyo       Note Added: 0011051                          
07-18-06 03:23 calestyo       Note Deleted: 0011049                        
07-18-06 05:54 Raymond        Note Added: 0011052                          
07-18-06 05:58 Raymond        Note Edited: 0011052                         
07-18-06 13:37 calestyo       Note Added: 0011054                          
07-18-06 14:24 Raymond        Note Added: 0011058                          
07-18-06 14:25 Raymond        Note Edited: 0011058                         
07-18-06 14:34 calestyo       Note Added: 0011059                          
07-18-06 17:35 Raymond        Note Added: 0011067                          
07-18-06 17:39 Raymond        Note Edited: 0011067                         
07-18-06 18:03 calestyo       Note Added: 0011068                          
07-18-06 18:12 Raymond        Note Added: 0011069                          
07-18-06 18:30 calestyo       Note Added: 0011070                          
07-19-06 03:36 Raymond        Note Added: 0011077                          
07-19-06 05:50 Raymond        Note Edited: 0011077                         
07-19-06 11:50 calestyo       Note Added: 0011084                          
07-19-06 12:03 Raymond        Note Added: 0011085                          
07-19-06 12:06 Raymond        Note Edited: 0011085                         
07-19-06 12:11 calestyo       Note Added: 0011086                          
07-19-06 16:46 Raymond        Note Added: 0011087                          
07-19-06 18:21 calestyo       Note Added: 0011091                          
07-19-06 18:22 calestyo       Note Added: 0011092                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
