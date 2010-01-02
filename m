From: Jie Jiang <jjinfo@nudt.edu.cn>
Subject: Cross-compile problem with alsa-driver version 1.0.22
Date: Sun, 03 Jan 2010 01:38:41 +0800
Message-ID: <462453116.31236@nudt.edu.cn>
Reply-To: jjinfo@nudt.edu.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nudt.edu.cn (mail.nudt.edu.cn [202.197.0.188])
	by alsa0.perex.cz (Postfix) with SMTP id 9CDB7244C6
	for <alsa-devel@alsa-project.org>; Sat,  2 Jan 2010 18:38:52 +0100 (CET)
Received: from [192.168.1.2] (unknown [218.76.61.127])
	(Authenticated sender: jjinfo)
	by ksg.nudt.edu.cn (KILL Mail Shield Gateway) with ESMTP id A392F1AFE00
	for <alsa-devel@alsa-project.org>; Sun,  3 Jan 2010 01:38:43 +0800 (CST)
Message-Id: <1262453921.27961.1.camel@UT43>
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

Hi all,

Recently I downloaded alsa-driver 1.0.22 and tried to build for i.MX27
platform.

The "INSTALL" file enclosed in this release requires
"--with-cross=arm-linux-" configuration option to cross-compile alsa
driver for this ARM platform. 

Here is my build process

#./configure --with-cross=arm-linux-
--with-kernel=/home/working/bsp/Kernel/linux-2.6.19.2
--with-build=/home/working/bsp/    Kernel/linux-2.6.19.2
--with-moddir=/home/working/bsp/tmp --with-debug=full
--enable-dynamic-minors --with-cards=all

checking for gcc... arm-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... configure: error: cannot run C
compiled programs.
If you meant to cross compile, use `--host'.
See `config.log' for more details.


It seems that "--host=arm-linux" should be provided to configure script.
However, when given the --host option, in the generated "Makefile.conf",
I saw the following outputs, which are very confusing:

 NEW_KBUILD       =
  
  mainsrcdir  = .
  MAINSRCDIR  = /work/63/alsa/alsa-driver-1.0.22
  
  CROSS_COMPILE   ?= arm-linux-
  ARCH            ?=
  ifdef NEW_KBUILD
  CC      = $(CROSS_COMPILE)arm-linux-gcc
  CPP     = $(CROSS_COMPILE)arm-linux-gcc -E
  export CROSS_COMPILE ARCH
  else
  AS      = $(CROSS_COMPILE)as
  LD      = $(CROSS_COMPILE)ld
  CC      = $(CROSS_COMPILE)arm-linux-gcc
  CPP     = $(CROSS_COMPILE)arm-linux-gcc -E
  AR      = $(CROSS_COMPILE)ar
  MODFLAGS    = -DMODULE=1
  CFLAGS_KERNEL   =
  GENKSYMS    = /sbin/genksyms -k 0.0.0
  endif

Obviously, the CC and CPP variables are not expected as "arm-linux-gcc".
(There is one more $(CROSS_COMPILE)!)


I overcome this problem by providing CC and CROSS_COMPILE variables with
configure script:
CC=gcc CROSS_COMPILE=arm-linux-gcc  ./configure --with-cross=arm-linux-
--with-kernel=/home/working/bsp/Kernel/linux-2.6.19.2
--with-build=/home/working/bsp/Kernel/linux-2.6.19.2
--with-moddir=/home/working/bsp/tmp --with-debug=full
--enable-dynamic-minors --with-cards=all

Then things become OK.

What's wrong with the "INSTALL" file?


Another problem.
Even if "--with-cards=all" is given,  codes in soc/codecs, soc/imx, and
many other subdirs are not built. It seems that the configure script
sets some variables according to the kernel version and target platform
and outputs into "toplevel.config".  Is it possible to manually edit
"toplevel.config" file (after configure process) to get soc/codecs,
soc/imx codes compiled?


Regards,
Jie 
