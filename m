From: Ilya Bagrak <gte654n@mail.gatech.edu>
Subject: cross compiling alsa-utils for arm (fwd)
Date: Wed, 2 Jul 2003 01:18:36 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.SOL.4.33.0307020117370.3412-100000@acmey.gatech.edu>
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

A bit of background:

I have an arm toolchain installed in /usr/local/arm. I have successfully
cross-compiled alsa-lib, but while trying to ./configure alsa-utils I am
getting the following error. It seems like it cannot find the cross-compiled
library, even though I copied it into the toolchain.


CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-suse-linux
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i686-suse-linux-strip... no
checking for strip... strip
checking for i686-suse-linux-gcc... arm-linux-gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gcc accepts -g... yes
checking for arm-linux-gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of arm-linux-gcc... gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 0.9.0... found.
checking for snd_ctl_open in -lasound... no
configure: error: No linkable libasound was found.

Where can I place my freshly cross-compiled libs, so they are picked up by
configure script? I am not a configure expert by any stretch of imagination,
i.e. it's quite possible I am missing something obvious here.

Thank you for you help.

Ilya


--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
