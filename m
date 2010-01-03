From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Cross-compile problem with alsa-driver version
	1.0.22
Date: Sun, 3 Jan 2010 12:09:19 +0100
Message-ID: <201001031209.19987.marek.vasut@gmail.com>
References: <462453116.31236@nudt.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FAEE243AB
	for <alsa-devel@alsa-project.org>; Sun,  3 Jan 2010 12:10:57 +0100 (CET)
Received: by fxm4 with SMTP id 4so47390020fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 03 Jan 2010 03:10:56 -0800 (PST)
In-Reply-To: <462453116.31236@nudt.edu.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, jjinfo@nudt.edu.cn
List-Id: alsa-devel@alsa-project.org

Dne So 2. ledna 2010 18:38:41 Jie Jiang napsal(a):
> Hi all,
> 
> Recently I downloaded alsa-driver 1.0.22 and tried to build for i.MX27
> platform.
> 
> The "INSTALL" file enclosed in this release requires
> "--with-cross=arm-linux-" configuration option to cross-compile alsa
> driver for this ARM platform.
> 
> Here is my build process
> 
> #./configure --with-cross=arm-linux-
> --with-kernel=/home/working/bsp/Kernel/linux-2.6.19.2
> --with-build=/home/working/bsp/    Kernel/linux-2.6.19.2
> --with-moddir=/home/working/bsp/tmp --with-debug=full
> --enable-dynamic-minors --with-cards=all
> 
> checking for gcc... arm-linux-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... configure: error: cannot run C
> compiled programs.
> If you meant to cross compile, use `--host'.
> See `config.log' for more details.
> 
> 
> It seems that "--host=arm-linux" should be provided to configure script.

Host is the thing you are compiling it at ...

> However, when given the --host option, in the generated "Makefile.conf",
> I saw the following outputs, which are very confusing:
> 
>  NEW_KBUILD       =
> 
>   mainsrcdir  = .
>   MAINSRCDIR  = /work/63/alsa/alsa-driver-1.0.22
> 
>   CROSS_COMPILE   ?= arm-linux-
>   ARCH            ?=
>   ifdef NEW_KBUILD
>   CC      = $(CROSS_COMPILE)arm-linux-gcc

should be ... 'CC      = $(CROSS_COMPILE)gcc', see below, others DTTO

>   CPP     = $(CROSS_COMPILE)arm-linux-gcc -E
>   export CROSS_COMPILE ARCH
>   else
>   AS      = $(CROSS_COMPILE)as
>   LD      = $(CROSS_COMPILE)ld
>   CC      = $(CROSS_COMPILE)arm-linux-gcc
>   CPP     = $(CROSS_COMPILE)arm-linux-gcc -E
>   AR      = $(CROSS_COMPILE)ar
>   MODFLAGS    = -DMODULE=1
>   CFLAGS_KERNEL   =
>   GENKSYMS    = /sbin/genksyms -k 0.0.0
>   endif
> 
> Obviously, the CC and CPP variables are not expected as "arm-linux-gcc".
> (There is one more $(CROSS_COMPILE)!)

yeah ... CROSS_COMPILE is set to the cross-toolchain prefix ... so in your case 
it should be 'CROSS_COMPILE=arm-linux-', that's all, nothing else. It's the same 
with linux kernel etc.
> 
> 
> I overcome this problem by providing CC and CROSS_COMPILE variables with
> configure script:
> CC=gcc CROSS_COMPILE=arm-linux-gcc  ./configure --with-cross=arm-linux-
> --with-kernel=/home/working/bsp/Kernel/linux-2.6.19.2
> --with-build=/home/working/bsp/Kernel/linux-2.6.19.2
> --with-moddir=/home/working/bsp/tmp --with-debug=full
> --enable-dynamic-minors --with-cards=all
> 
> Then things become OK.
> 
> What's wrong with the "INSTALL" file?
> 
Nothing ?

> 
> Another problem.
> Even if "--with-cards=all" is given,  codes in soc/codecs, soc/imx, and
> many other subdirs are not built. It seems that the configure script
> sets some variables according to the kernel version and target platform
> and outputs into "toplevel.config".  Is it possible to manually edit
> "toplevel.config" file (after configure process) to get soc/codecs,
> soc/imx codes compiled?

Yes, it builds what it can according to the setup of your kernel ... eg. you 
wont be able to use chips connected over the ac97 interface if there's no driver 
for the ac97 interface in your kernel etc.
> 
> 
> Regards,
> Jie
Cheers!
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
