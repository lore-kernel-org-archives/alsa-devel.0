From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001107]: amixer crashes with M-Audio Revolution 7.1 when value is given to numid=0
Date: Fri, 27 May 2005 12:26:49 +0200
Message-ID: <5aff984b0b41c99f3d6f8483e209400b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 009AF20D
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 12:26:49 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1107> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1107
Category:                   amixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-14-2005 02:50 CEST
Last Modified:              05-27-2005 12:26 CEST
======================================================================
Summary:                    amixer crashes with M-Audio Revolution 7.1 when
value is given to numid=0
Description: 
The following says it all:

"
[root@athlon ~]# cat /proc/asound/pcm
00-00: ICE1724 : ICE1724 : playback 1 : capture 1
00-01: IEC1724 IEC958 : IEC1724 IEC958 : playback 1
00-02: ICE1724 Surrounds : ICE1724 Surround PCM : playback 3
[root@athlon ~]# amixer  cset numid=0 50%
amixer: control.c:251: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)'failed.
Aborted (core dumped)
[root@athlon ~]#
".

The same configuration as in

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1106
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 ,
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1095 .

Thanks in advance,
  Sergei.

======================================================================

----------------------------------------------------------------------
 sst4 - 05-24-05 21:41 
----------------------------------------------------------------------
I hope the following screen output is what you need.

If you need somerhing else, please tell me commands of 'gdb' to use and on
what file(s).

Thanks,
  Sergei.

[11] 22:32 sergei@athlon.home.net:/ibm/home/sergei> gdb
GNU gdb 6.3-3mdk (Mandrakelinux)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "i586-mandrake-linux-gnu".
(gdb) file /usr/bin/amixer
Reading symbols from /usr/bin/amixer...(no debugging symbols
found)...done.
Using host libthread_db library "/lib/tls/libthread_db.so.1".
(gdb) set args cset numid=0 50%
(gdb) run
Starting program: /usr/bin/amixer cset numid=0 50%
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread -1210317120 (LWP 23625)]
(no debugging symbols found)
amixer: control.c:251: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)' failed.

Program received signal SIGABRT, Aborted.
[Switching to Thread -1210317120 (LWP 23625)]
0xffffe410 in ?? ()
(gdb) backtrace
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0xffffe410 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0xbfffed7c in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x00000006 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x00005c49 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0xb7de96e5 in raise ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0xb7deb049 in abort ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0xb7de2d71 in
__assert_fail () from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0xb7f2cc45 in
snd_ctl_elem_info () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8  0xb7fa4750 in ?? ()
from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9  0xb7fa3324 in ?? ()
from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 0x000000fb in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11 0xb7fa371e in ?? ()
from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12 0xb7f2cbe0 in
snd_ctl_elem_list () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 0x0804f802 in
_IO_stdin_used ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=15 0x0804ce29 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=16 0x08052150 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=17 0xbffff250 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=19 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=20 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=22 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=25 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=27 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=28 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=29 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=30 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=31 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=32 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=33 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=34 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=35 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=36 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=37 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=38 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=39 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=40 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=41 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=42 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=43 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=44 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=45 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=46 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=47 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=48 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=49 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=50 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=51 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=52 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=53 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=54 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=55 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=56 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=57 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=58 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=60 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=61 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=62 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=63 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=64 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=65 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=66 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=67 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=68 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=69 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=70 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=71 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=72 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=73 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=74 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=75 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=76 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=77 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=78 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=79 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=80 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=81 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=82 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=83 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=84 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=85 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=86 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=87 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=88 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=89 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=90 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=91 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=92 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=93 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=94 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=95 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=96 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=97 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=98 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=99 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=100 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=101 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=102 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=103 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=104 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=105 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=106 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=107 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=108 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=109 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=110 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=111 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=112 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=113 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=114 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=115 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=116 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=117 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=118 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=119 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=120 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=121 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=122 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=123 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=124 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=125 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=126 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=127 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=128 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=129 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=130 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=131 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=132 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=133 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=134 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=135 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=136 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=137 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=138 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=139 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=140 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=141 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=142 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=143 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=144 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=145 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=146 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=147 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=148 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=149 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=150 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=151 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=152 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=153 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=155 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=156 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=157 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=158 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=159 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=160 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=161 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=162 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=163 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=164 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=165 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=166 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=167 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=168 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=169 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=170 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=171 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=173 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=174 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=175 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=176 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=177 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=178 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=179 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=180 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=181 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=182 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=183 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=184 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=185 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=186 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=187 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=188 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=189 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=190 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=191 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=192 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=193 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=194 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=195 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=196 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=197 0xb8001508 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=198 0x000001f8 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=199 0x0804cbe8 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=200 0xbffff200 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=201 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=202 0x00000040 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=203 0x00000001 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=204 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=205 0x00000002 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=206 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=207 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=208 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=209 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=210 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=211 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=212 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=213 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=214 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=215 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=216 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=217 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=218 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=219 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=220 0xbffff250 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=221 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=222 0x00000110 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=223 0xb8000ff4 in ?? ()
from /lib/ld-linux.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=224 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=225 0x00000002 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=226 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=227 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=228 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=229 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=231 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=232 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=233 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=234 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=235 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=236 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=237 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=238 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=239 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=240 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=241 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=242 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=243 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=244 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=245 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=246 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=247 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=248 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=249 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=250 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=251 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=252 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=253 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=254 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=255 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=256 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=257 0x00000000 in ?? ()
---Type <return> to continue, or q <return> to quit---
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=258 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=259 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=260 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=261 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=262 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=263 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=264 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=265 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=266 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=267 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=268 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=269 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=270 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=271 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=272 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=273 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=274 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=275 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=276 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=277 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=278 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=279 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=280 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=281 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=282 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=283 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=284 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=285 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=286 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=287 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=288 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=289 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=290 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=291 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=292 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=293 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=294 0xbffff3f0 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=295 0xb8001508 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=296 0x08049c4b in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=297 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=298 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=299 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=300 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=301 0xb7dc60b0 in ?? ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=302 0xb7febca8 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=303 0x00000001 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=304 0x68746100 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305 0x2e6e6f6c in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306 0x656d6f68 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=307 0xbfffef20 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=308 0xbffff200 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=309 0xbffff250 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=310 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=311 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=312 0xbffff5ac in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=313 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=314 0xb7ee7ff4 in ?? ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=315 0x08052150 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=316 0x080515c8 in optarg
()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=317 0xbffff3f4 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=318 0xb7e6fb21 in confstr
() from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=319 0x0804ef59 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=320 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=321 0xbffff5a4 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=322 0x0804f9c0 in
_IO_stdin_used ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=323 0xbffff480 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=324 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=325 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=326 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=327 0x00000020 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=329 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=330 0xb7dd2b14 in ?? ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=331 0xb7dcd9e0 in ?? ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=332 0xb7dc5340 in ?? ()
from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=333 0xb7febca8 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=334 0x00000007 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=335 0xbffff765 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=336 0xb7dc1070 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=337 0x0177ff8e in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=338 0x08049ce5 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=339 0x00000001 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=340 0xbffff765 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=341 0x00000000 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=342 0xbffff528 in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=343 0xb7ff3d68 in
_dl_lookup_symbol_x (undef_name=0x804f9a9 "inactive",
undef_map=0x3eb, ref=0x0, symbol_scope=0x4, version=0xbffff5a4,
type_class=-1073744456, flags=-1207996396, skip_map=0xb7ee7ff4) at
dl-lookup.c:251
---Type <return> to continue, or q <return> to quit---
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=344 0xb7dd6e4b in
__libc_start_main () from /lib/tls/libc.so.6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=345 0x0804ac71 in ?? ()
(gdb)

----------------------------------------------------------------------
 sst4 - 05-27-05 12:26 
----------------------------------------------------------------------
By the way, this command line: 'amixer cget numid=0'

produces this:
"
amixer: control.c:251: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)' failed.
Abort
"
Probably useful for developers, but not for end users. Could you please
implement a more
useful error message explaining what's wrong ?

Thanks,
  Sergei.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-05 02:50 sst4           New Issue                                    
05-24-05 12:03 tiwai          Note Added: 0004713                          
05-24-05 21:41 sst4           Note Added: 0004730                          
05-27-05 12:26 sst4           Note Added: 0004747                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
