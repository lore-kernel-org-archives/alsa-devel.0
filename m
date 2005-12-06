From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001617]: "The field ipc_gid must be a valid group (create group audio)"
Date: Tue, 6 Dec 2005 11:41:02 +0100
Message-ID: <5cbb67a0de6d69e7ac57a6ac7915b207@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65D43187
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 11:41:03 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1617> 
======================================================================
Reported By:                db1802xx
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1617
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-04-2005 09:01 CET
Last Modified:              12-06-2005 11:41 CET
======================================================================
Summary:                    "The field ipc_gid must be a valid group (create
group audio)"
Description: 
After upgrading alsa packages a while ago, i got some problems...
I'm not sure if this has to du with the alsa upgrade, or if it's something
else.. Only thing I'm sure of is that it worked the last time I used
mplayer with alsa(3 months ago, or something/with last version of
alsa-libs)..

As user in group "audio" I can use alsamixer, xmms and bmp...
But when i try to run aplay, mplayer I get this message:
   "The field ipc_gid must be a valid group (create group audio)"
  ALSA Lib: something about pcm_dmix.c line 1102 or something.......
There is no error when running as root...

I've recently changed from devfs to udev, so I have been trying to change
the permissions, groups and so on, but with no luck... 

Finaly i opend the "pcm_dmix.c" file in the source, and commented away a
few things to check if it would work if i forced it to skip the gid
check:

		if (strcmp(id, "ipc_gid") == 0) {
			char *group;
			char *endp;
			err = snd_config_get_ascii(n, &group);
			if (err < 0) {
				SNDERR("The field ipc_gid must be a valid group");
				return err;
			}
			//if (isdigit(*group) == 0) {
			//	struct group *grp = getgrnam(group);
			//	if (grp == NULL) {
			//		SNDERR("The field ipc_gid must be a valid group (create group %s)",
group);
			//		free(group);
			//		return -EINVAL;
			//	}
			//	ipc_gid = grp->gr_gid;
			//} else {
				ipc_perm = strtol(group, &endp, 10);
			//}
			free(group);
			continue;

After this everything works fine...

The question is:
Is this a ALSA related question (as in I've fucked up somthing in my OS),
or has this something to do with the latest alsa-lib(1.3.3)?
======================================================================

----------------------------------------------------------------------
 db1802xx - 12-05-05 20:28 
----------------------------------------------------------------------
user_in_audio_group $ strace aplay

execve("/usr/bin/aplay", ["aplay"], [/* 55 vars */]) = 0
uname({sys="Linux", node="localhost", ...}) = 0
brk(0)                                  = 0x8054000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=120226, ...}) = 0
mmap2(NULL, 120226, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f2d000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\362\1"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=774864, ...}) = 0
mmap2(NULL, 766596, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7e71000
mmap2(0xb7f28000, 20480, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb7) = 0xb7f28000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p3\0\000"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=153240, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7e70000
mmap2(NULL, 139424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7e4d000
mmap2(0xb7e6e000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20) = 0xb7e6e000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\v\0"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=10440, ...}) = 0
mmap2(NULL, 12392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7e49000
mmap2(0xb7e4b000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7e4b000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320B\0"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=141357, ...}) = 0
mmap2(NULL, 332928, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7df7000
mmap2(0xb7e05000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb7e05000
mmap2(0xb7e07000, 267392, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7e07000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20V\1\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1199648, ...}) = 0
mmap2(NULL, 1146164, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7cdf000
mmap2(0xb7df1000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x111) = 0xb7df1000
mmap2(0xb7df5000, 7476, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7df5000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7cde000
mprotect(0xb7df1000, 4096, PROT_READ)   = 0
mprotect(0xb7e05000, 4096, PROT_READ)   = 0
mprotect(0xb7f61000, 4096, PROT_READ)   = 0
munmap(0xb7f2d000, 120226)              = 0
brk(0)                                  = 0x8054000
brk(0x8075000)                          = 0x8075000
brk(0)                                  = 0x8075000
set_thread_area({entry_number:-1 -> 6, base_addr:0x80548c0, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}) = 0
getpid()                                = 32239
rt_sigaction(SIGRTMIN, {0xb7dff850, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb7dff9a0, [RTMIN], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0xb7dffb80, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbff5e1b8, 39, (nil), 0}) = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\311\255\271\301", 4)          = 4
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7501,
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7501, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f4a000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
read(3, "if cards.pcm.iec958\npcm.modem ca"..., 4096) = 3405
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f4a000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("/home/thor-erik/.asoundrc", R_OK) = -1 ENOENT (No such file or
directory)
open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1186, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f4a000
read(3, "#\n#  Define aliases for various "..., 4096) = 1186
open("/usr/share/alsa/pcm/default.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=507, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n# Default output\n#\n\npcm.!defau"..., 4096) = 507
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/dmix.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1069, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n# dmix output\n#\n\npcm.!dmix {\n\t"..., 4096) = 1069
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/dsnoop.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1071, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n# dsnoop\n#\n\npcm.!dsnoop {\n\t@ar"..., 4096) = 1071
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f4a000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7501,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff5e05c)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff5e068)     = 0
close(3)                                = 0
access("/usr/share/alsa/cards/ICH.conf", R_OK) = 0
open("/usr/share/alsa/cards/ICH.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3042, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f4a000
read(3, "#\n# Configuration for the Intel "..., 4096) = 3042
open("/usr/share/alsa/pcm/front.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=596, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n# Hardware output from front s"..., 4096) = 596
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/surround40.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=749, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n#  Hardware output from 4.0 sp"..., 4096) = 749
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/surround41.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=893, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n#  Hardware output from 4.1 sp"..., 4096) = 893
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/surround50.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=896, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n#  Hardware output from 5.0 sp"..., 4096) = 896
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/surround51.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=783, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n#  Hardware output from 5.1 sp"..., 4096) = 783
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
open("/usr/share/alsa/pcm/iec958.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1030, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f49000
read(4, "#\n#  Hardware output from iec958"..., 4096) = 1030
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f49000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f4a000, 4096)                = 0
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7501,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff5dddc)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff5dde8)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7501,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff5d9cc)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff5d9d8)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7501,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff5d9cc)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff5d9d8)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7501,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff5d9cc)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff5d9d8)     = 0
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1
ENOENT (No such file or directory)
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1
ENOENT (No such file or directory)
close(3)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=503, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0xb7f4a000
read(3, "# /etc/nsswitch.conf:\n# $Header:"..., 4096) = 503
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f4a000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=120226, ...}) = 0
mmap2(NULL, 120226, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f2d000
close(3)                                = 0
open("/lib/libnss_compat.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\20"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=30928, ...}) = 0
mmap2(NULL, 33392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7cd5000
mmap2(0xb7cdc000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7cdc000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@5\0\000"..., 512)
= 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=75176, ...}) = 0
mmap2(NULL, 83968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7cc0000
mmap2(0xb7cd1000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10) = 0xb7cd1000
mmap2(0xb7cd3000, 6144, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7cd3000
close(3)                                = 0
munmap(0xb7f2d000, 120226)              = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=120226, ...}) = 0
mmap2(NULL, 120226, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f2d000
close(3)                                = 0
open("/lib/libnss_nis.so.2", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\34\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=35408, ...}) = 0
mmap2(NULL, 37416, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7cb6000
mmap2(0xb7cbe000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7cbe000
close(3)                                = 0
open("/lib/libnss_files.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\33\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=35240, ...}) = 0
mmap2(NULL, 37516, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0xb7cac000
mmap2(0xb7cb4000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7cb4000
close(3)                                = 0
munmap(0xb7f2d000, 120226)              = 0
open("/etc/group", O_RDONLY)            = -1 EACCES (Permission denied)
write(2, "ALSA lib pcm_dmix.c:1102:(_snd_p"..., 46ALSA lib
pcm_dmix.c:1102:(_snd_pcm_dmix_open) ) = 46
write(2, "The field ipc_gid must be a vali"..., 60The field ipc_gid must
be a valid group (create group audio)) = 60
write(2, "\n", 1
)                       = 1
write(2, "aplay: main:544: ", 17aplay: main:544: )       = 17
write(2, "audio open error: Invalid argume"..., 34audio open error:
Invalid argument) = 34
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?

----------------------------------------------------------------------
 perex - 12-06-05 11:41 
----------------------------------------------------------------------
> open("/etc/group", O_RDONLY) = -1 EACCES (Permission denied)

Do you see it? The file /etc/group should have read permissions for all
users. It not definitely an ALSA bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 09:01 db1802xx       New Issue                                    
12-04-05 09:04 db1802xx       Note Added: 0006906                          
12-04-05 10:21 perex          Note Added: 0006907                          
12-04-05 10:21 perex          Note Edited: 0006907                         
12-05-05 20:28 db1802xx       Note Added: 0006915                          
12-06-05 11:41 perex          Status                   new => resolved     
12-06-05 11:41 perex          Resolution               open => fixed       
12-06-05 11:41 perex          Assigned To               => perex           
12-06-05 11:41 perex          Note Added: 0006922                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
