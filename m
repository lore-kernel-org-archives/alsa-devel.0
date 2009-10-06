From: Harish Kumar <harishkumarb7@gmail.com>
Subject: alsa-utils cross compilation error
Date: Tue, 6 Oct 2009 19:49:09 +0530
Message-ID: <7df11cd50910060719t66c353b0jc865f04e09f49c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f194.google.com (mail-px0-f194.google.com
	[209.85.216.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 627C5103821
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 16:19:10 +0200 (CEST)
Received: by pxi32 with SMTP id 32so3746944pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2009 07:19:09 -0700 (PDT)
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

Hi,

I am trying to cross compile the alsa utils for PPC and as well as arm
architecture. the compilation of alsa-libs was successful with their
respective toolchains. But configuring the alsa-util is failing. I am
using alsa-utils-1.0.11rc2,alsa-lib-1.0.11rc2.  I am getting the error
checking for libasound headers version >= 1.0.9... not present.
configure: error: Sufficiently new version of libasound not found. I
feel i have to provide the path of the include files but not sure
which path to be passed and how it needs to be passed to configure.

Request your help to resolve the same.

I invoked the configure using the following command and the output of
the configure is as below.

root@localhost alsa-utils-1.0.11rc2]# CC=arm-linux-gcc ./configure
--target=arm-linux --host=i686-linux
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i686-linux-strip... no
checking for strip... strip
checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for style of include used by make... GNU
checking for i686-linux-gcc... arm-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gcc accepts -g... yes
checking for arm-linux-gcc option to accept ANSI C... none needed
checking dependency style of arm-linux-gcc... gcc3
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for ld used by GCC...
/opt/GARZ/CROSSTOOLS/arm-2007q3/arm-none-linux-gnueabi/bin/ld
checking if the linker
(/opt/GARZ/CROSSTOOLS/arm-2007q3/arm-none-linux-gnueabi/bin/ld) is GNU
ld... yes
checking for shared library run path origin... done
checking whether NLS is requested... yes
checking for GNU gettext in libc... yes
checking whether to use NLS... yes
checking where the gettext function comes from... libc
checking for i686-linux-gcc... (cached) arm-linux-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether arm-linux-gcc accepts -g... (cached) yes
checking for arm-linux-gcc option to accept ANSI C... (cached) none needed
checking dependency style of arm-linux-gcc... (cached) gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.9... not present.
configure: error: Sufficiently new version of libasound not found.
[2]+  Done                    gedit configure
[root@localhost alsa-utils-1.0.11rc2]#


Thanks and Regards
Harish Kumar.B
