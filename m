From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: rc4
Date: Wed, 23 Oct 2002 19:51:39 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB67F3B.4090407@boosthardware.com>
References: <Pine.LNX.4.21.0210231231440.321-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA02594
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 12:53:12 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

tomasz motylewski wrote:
> I have just updated to CVS.
> 
> Debian 2.2
> 
> I needed to run autoconf; ./configure; make; ./configure; make
> 
> cd alsa-driver
> 
> ./configure
> [...]
> checking for USB... no
> checking for PCMCIA... yes
> ./configure: ALSA_TOPLEVEL_INIT: command not found
> ./configure: ALSA_TOPLEVEL_SELECT: command not found
> updating cache ./config.cache
> creating ./config.status
> creating version
> creating Makefile.conf
> creating snddevices
> creating utils/alsa-driver.spec
> creating utils/buildrpm
> creating toplevel.config
> sed: can't read ./toplevel.config.in: No such file or directory
> creating include/config.h
> creating include/config1.h
> cat: ./include/config1.h.in: No such file or directory
> creating include/version.h
> tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ make
> make  all-deps
> make[1]: Entering directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
> ln -sf ../alsa-kernel alsa-kernel
> gcc -Ialsa-kernel/scripts alsa-kernel/scripts/mod-deps.c -o utils/mod-deps
> cat alsa-kernel/scripts/Modules.dep utils/Modules.dep | utils/mod-deps
> --makeconf > toplevel.config.in
> cat alsa-kernel/scripts/Modules.dep utils/Modules.dep | utils/mod-deps
> --acinclude > acinclude.m4
> cat alsa-kernel/scripts/Modules.dep utils/Modules.dep | utils/mod-deps
> --include > include/config1.h.in
> make[1]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
> 
> Please, run the configure script as first...
> tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ ./configure 
> loading cache ./config.cache
> [...]
> checking for USB... no
> checking for PCMCIA... yes
> ./configure: ALSA_TOPLEVEL_INIT: command not found
> ./configure: ALSA_TOPLEVEL_SELECT: command not found
> creating ./config.status
> creating version
> creating Makefile.conf
> creating snddevices
> creating utils/alsa-driver.spec
> creating utils/buildrpm
> creating toplevel.config
> creating include/config.h
> include/config.h is unchanged
> creating include/config1.h
> creating include/version.h
> include/version.h is unchanged
> tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ make
> if [ ! -d include/sound -a ! -L include/sound ]; then \
>   ln -sf ../alsa-kernel/include include/sound ; \
> fi
> cp -auvf include/version.h include/sound/version.h
> include/version.h -> include/sound/version.h
> make dep
> make[1]: Entering directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
> make[2]: Entering directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore'
> make  -C ioctl32 fastdep
> make[3]: Entering directory
> `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore/ioctl32'
> /home/tom/devel/aeg/ALSA/cvs/alsa-driver/include/sndversions.h was updated
> gcc -M -D__KERNEL__ -DMODULE=1
> -I/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include
> -I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
> -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD
> hwdep32.c ioctl32.c pcm32.c rawmidi32.c seq32.c timer32.c > .depend
> make[3]: Leaving directory
> `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore/ioctl32'
> make  -C oss fastdep
> make[3]: Entering directory
> `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore/oss'
> /home/tom/devel/aeg/ALSA/cvs/alsa-driver/include/sndversions.h was not updated
> gcc -D__KERNEL__ -DMODULE=1 -I/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include
> -I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
> -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD  -E
> -D__GENKSYMS__ mixer_oss.c
> 
> - it sems to be OK at this point.
> 
> But then:
> 
> gcc -M -D__KERNEL__ -DMODULE=1
> -I/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include
> -I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
> -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD
> gus_dma.c gus_dram.c gus_instr.c gus_io.c gus_irq.c gus_lfo.c gus_main.c
> gus_mem.c gus_mem_proc.c gus_mixer.c gus_pcm.c gus_reset.c gus_sample.c
> gus_simple.c gus_synth.c gus_timer.c gus_uart.c gus_volume.c gusclassic.c
> gusextreme.c gusmax.c interwave-stb.c interwave.c > .depend
> make[3]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/isa/gus'
> make  -C msnd fastdep
> make: Entering an unknown directory
> make: *** msnd: No such file or directory.  Stop.
> make: Leaving an unknown directory
> make[2]: *** [_sfdep_msnd] Error 2
> make[2]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/isa'
> make[1]: *** [dep] Error 1
> make[1]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
> make: *** [include/sndversions.h] Error 2
> tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ 
> 
> 
> What is the "true one" method of compling ALSA CVS?
> 

It's in the online docs but for your convienience

./cvscompile --with-cards=snd-xxx;make;make install

where snd-xxx is the name of the module for your card.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
