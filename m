From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: rc4
Date: Wed, 23 Oct 2002 12:37:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0210231231440.321-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.33.0210231206090.5772-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailserver.intern.bfad.de (mail.bfad.de [212.62.208.67])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA02317
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 12:36:05 +0200
Received: from localhost (tom@localhost)
	by mailserver.intern.bfad.de (8.9.3+3.2W/8.9.3/Debian 8.9.3-21) with ESMTP id MAA04778
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 12:37:11 +0200
In-Reply-To: <Pine.LNX.4.33.0210231206090.5772-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


I have just updated to CVS.

Debian 2.2

I needed to run autoconf; ./configure; make; ./configure; make

cd alsa-driver

./configure
[...]
checking for USB... no
checking for PCMCIA... yes
./configure: ALSA_TOPLEVEL_INIT: command not found
./configure: ALSA_TOPLEVEL_SELECT: command not found
updating cache ./config.cache
creating ./config.status
creating version
creating Makefile.conf
creating snddevices
creating utils/alsa-driver.spec
creating utils/buildrpm
creating toplevel.config
sed: can't read ./toplevel.config.in: No such file or directory
creating include/config.h
creating include/config1.h
cat: ./include/config1.h.in: No such file or directory
creating include/version.h
tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ make
make  all-deps
make[1]: Entering directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
ln -sf ../alsa-kernel alsa-kernel
gcc -Ialsa-kernel/scripts alsa-kernel/scripts/mod-deps.c -o utils/mod-deps
cat alsa-kernel/scripts/Modules.dep utils/Modules.dep | utils/mod-deps
--makeconf > toplevel.config.in
cat alsa-kernel/scripts/Modules.dep utils/Modules.dep | utils/mod-deps
--acinclude > acinclude.m4
cat alsa-kernel/scripts/Modules.dep utils/Modules.dep | utils/mod-deps
--include > include/config1.h.in
make[1]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'

Please, run the configure script as first...
tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ ./configure 
loading cache ./config.cache
[...]
checking for USB... no
checking for PCMCIA... yes
./configure: ALSA_TOPLEVEL_INIT: command not found
./configure: ALSA_TOPLEVEL_SELECT: command not found
creating ./config.status
creating version
creating Makefile.conf
creating snddevices
creating utils/alsa-driver.spec
creating utils/buildrpm
creating toplevel.config
creating include/config.h
include/config.h is unchanged
creating include/config1.h
creating include/version.h
include/version.h is unchanged
tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ make
if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
include/version.h -> include/sound/version.h
make dep
make[1]: Entering directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
make[2]: Entering directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore'
make  -C ioctl32 fastdep
make[3]: Entering directory
`/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore/ioctl32'
/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include/sndversions.h was updated
gcc -M -D__KERNEL__ -DMODULE=1
-I/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include
-I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD
hwdep32.c ioctl32.c pcm32.c rawmidi32.c seq32.c timer32.c > .depend
make[3]: Leaving directory
`/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore/ioctl32'
make  -C oss fastdep
make[3]: Entering directory
`/home/tom/devel/aeg/ALSA/cvs/alsa-driver/acore/oss'
/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include/sndversions.h was not updated
gcc -D__KERNEL__ -DMODULE=1 -I/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include
-I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD  -E
-D__GENKSYMS__ mixer_oss.c

- it sems to be OK at this point.

But then:

gcc -M -D__KERNEL__ -DMODULE=1
-I/home/tom/devel/aeg/ALSA/cvs/alsa-driver/include
-I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD
gus_dma.c gus_dram.c gus_instr.c gus_io.c gus_irq.c gus_lfo.c gus_main.c
gus_mem.c gus_mem_proc.c gus_mixer.c gus_pcm.c gus_reset.c gus_sample.c
gus_simple.c gus_synth.c gus_timer.c gus_uart.c gus_volume.c gusclassic.c
gusextreme.c gusmax.c interwave-stb.c interwave.c > .depend
make[3]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/isa/gus'
make  -C msnd fastdep
make: Entering an unknown directory
make: *** msnd: No such file or directory.  Stop.
make: Leaving an unknown directory
make[2]: *** [_sfdep_msnd] Error 2
make[2]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver/isa'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/tom/devel/aeg/ALSA/cvs/alsa-driver'
make: *** [include/sndversions.h] Error 2
tom@PC18:~/devel/aeg/ALSA/cvs/alsa-driver$ 


What is the "true one" method of compling ALSA CVS?

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
