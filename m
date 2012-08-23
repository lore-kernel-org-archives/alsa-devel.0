From: Tim Jiang <tim.jiang77@live.com>
Subject: [Cross compile issue] - I met problem when to cross
 compile alsa-lib and alsa-utils.Could you please help on it?
Date: Thu, 23 Aug 2012 10:46:39 +0000
Message-ID: <COL116-W40A81806CE366DDEFB100396BE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s6.col0.hotmail.com (col0-omc3-s6.col0.hotmail.com
 [65.55.34.144]) by alsa0.perex.cz (Postfix) with ESMTP id 10563265CB4
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 12:46:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Hi experts,

#My question: I met problem when to cross compile alsa-lib and alsa-utils.Could you please help on it?
Thanks in advance.

#details
My host PC: ubuntu 11.10 64-bit; 
Alsa-lib source code version: 1.0.23;
Alsa-utils source code version: 1.0.23;
My target platform: PandaBoard;
My build shell script:
#!/bin/bash
echo "=======================start build alsa-lib-1.0.23=============="
cd ./alsa-lib-1.0.23/
export CC=arm-linux-gnueabi-gcc
echo "-------------->`pwd`"
./configure  --target=arm-linux  --host=i686-linux  --prefix=/home/tim/work/dev_board/tools/ALSA/output/alsa_lib   --disable-python
make clean
make
make install
cd -
echo "========================end  build alsa-lib-1.0.23==============="

echo "=======================start build alsa-utils-1.0.23===================="
cd ./alsa-utils-1.0.23/
echo "-------------->`pwd`"
./configure --target=arm-linux  --host=i686-linux --with-alsa-inc-prefix=/home/tim/work/dev_board/tools/ALSA/output/alsa_lib/include --with-alsa-prefix=/home/tim/work/dev_board/tools/ALSA/output/alsa_lib/lib --disable-alsamixer --disable-xmlto 
make 

I can build Alsa-lib successfully but error happened when to build Alsa-utils.
=======================start build alsa-utils-1.0.23====================
-------------->/home/tim/work/dev_board/tools/ALSA/alsa-utils-1.0.23
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking for i686-linux-strip... no
checking for strip... strip
checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for style of include used by make... GNU
checking for i686-linux-gcc... arm-linux-gnueabi-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gnueabi-gcc accepts -g... yes
checking for arm-linux-gnueabi-gcc option to accept ISO C89... none needed
checking dependency style of arm-linux-gnueabi-gcc... gcc3
checking build system type... x86_64-unknown-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for ld used by GCC... /usr/arm-linux-gnueabi/bin/ld
checking if the linker (/usr/arm-linux-gnueabi/bin/ld) is GNU ld... yes
checking for shared library run path origin... done
checking for CFPreferencesCopyAppValue... no
checking for CFLocaleCopyCurrent... no
checking for GNU gettext in libc... yes
checking whether to use NLS... yes
checking where the gettext function comes from... libc
checking for i686-linux-gcc... (cached) arm-linux-gnueabi-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether arm-linux-gnueabi-gcc accepts -g... (cached) yes
checking for arm-linux-gnueabi-gcc option to accept ISO C89... (cached) none needed
checking dependency style of arm-linux-gnueabi-gcc... (cached) gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ALSA CFLAGS...  -I/home/tim/work/dev_board/tools/ALSA/output/alsa_lib/include
checking for ALSA LDFLAGS...  -L/home/tim/work/dev_board/tools/ALSA/output/alsa_lib/lib -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.16... found.
checking for snd_ctl_open in -lasound... no
configure: error: No linkable libasound was found.
make: *** No targets specified and no makefile found.  Stop.



Best Regards,
Tim

 		 	   		  
