From: "Paul Berry" <pnberry@gustavus.ak.us>
Subject: configure error with alsa-driver-0.9.7a
Date: Wed, 8 Oct 2003 01:33:17 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000701c38d7f$538b31a0$fcf8e589@farnorth>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from aurora.uaf.edu (root@aurora.uaf.edu [137.229.18.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA24063
	for <alsa-devel@alsa-project.org>; Wed, 8 Oct 2003 11:38:10 +0200
Received: from farnorth (fai-252.vpdn.alaska.edu [137.229.248.252])
	by aurora.uaf.edu (8.11.6p3/8.11.6) with SMTP id h989c1f28935
	for <alsa-devel@alsa-project.org>; Wed, 8 Oct 2003 01:38:02 -0800 (AKDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello kind alsa developers:

I was attempting to upgrade the alsa-drivers in an old system,  Redhat 7.0
(upgraded to a custom compiled 2.2.20 kernel) that is presently using
alsa-driver-0.9.0rc6.
The system works fine, just wanted the latest drivers, but when I tried to
upgrade to the 0.9.7a drivers the configure script stopped midway. I'm
puzzled as I've compiled this kernel using the same gcc version (2.96) that
I am attempting to use on for the new drivers.

Here is the configure report as requested and thank you in advance for any
help.

Sincerely,
Paul

[root@FarNorth alsa-driver-0.9.7a]#
./configure --with-debug=full --with-isapnp=yes --with-sequencer=yes --with-
oss=yes
checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for executable suffix...
checking for object suffix... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for ranlib... ranlib
checking for a BSD compatible install... /usr/bin/install -c
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for gcc option to accept ANSI C... none needed
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory... /usr/local/src/alsa-driver-0.9.7a
checking cross compile...
checking for directory with kernel source... /lib/modules/2.2.20alsa/build
checking for kernel version... 2.2.20alsa
checking for GCC version... Kernel compiler: gcc egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release) Used compiler: 2.96
Fatal error: Compiler type does not match
Decoded kernel compiler: type=egcs version=2.91.66
Decoded used compiler: type=gcc version=2.96
Please, send ./configure output to <alsa-devel@alsa-project.org>
[root@FarNorth alsa-driver-0.9.7a]#




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
