From: listreq@tlen.pl
Subject: BUG reported by alsa-driver-0.9.1(2) (gusclassic)
Date: Sun, 20 Apr 2003 21:08:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0304200526300.1551-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hello,

I have problem with: alsa-driver-0.9.1 (gusclassic),
I try 0.9.2 - the same problem

compile options:
./configure --with-cards=gusclassic --with-isapnp=no --with-sequencer=no
--with-oss=yes --with-debug=full

kernel - 2.2.24

programs: xmms(XWindow, OSS), mpg123(console, Esound)

problem:
when I listen music sometimes right canal is blocked (some noise -
like play some part of soundcard memory, repeated until music stop).

My log (Alsa 0.9.1):

-----
Mar 18 04:16:30 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:215:
Unexpected hw_pointer value (stream = 0, delta: -42, max jitter = 8192):
wrong interrupt acknowledge?

Mar 18 04:16:46 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x7fffff0, buffer size = 0x4000, period size =
0x400

Mar 18 04:16:46 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156:
Unexpected hw_pointer value (stream = 0, delta: -1024, max jitter = 8192):
wrong interrupt acknowledge?

Mar 18 04:16:46 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156:
Unexpected hw_pointer value (stream = 0, delta: -1024, max jitter = 8192):
wrong interrupt acknowledge?
        
Mar 18 04:18:36 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:215:
Unexpected hw_pointer value (stream = 0, delta: -43, max jitter = 8192):
wrong interrupt acknowledge?

Mar 18 04:18:37 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x7fffff0, buffer size = 0x4000, period size =
0x400

Mar 18 04:18:37 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:156:
Unexpected hw_pointer value (stream = 0, delta: -1024, max jitter = 8192):
wrong interrupt acknowledge?
-----

BUG could be also (I remove "Unexpected..." errors):

Mar 18 05:19:31 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x7fffff1, buffer size = 0x4000, period size = 0x400

Mar 18 05:29:11 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x400

Mar 18 05:31:19 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x7fffff1, buffer size = 0x4000, period size = 0x400

Mar 18 05:35:52 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x4001, buffer size = 0x4000, period size = 0x400

Mar 18 05:43:34 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x400

Mar 18 05:50:28 localhost kernel: ALSA ../alsa-kernel/core/pcm_lib.c:204:
BUG: stream = 0, pos = 0x7fffff0, buffer size = 0x4000, period size = 0x400

best regards.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
