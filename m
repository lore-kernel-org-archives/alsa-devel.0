From: William <walsac2@liam2.demon.co.uk>
Subject: CVS ALSA failed upgrade in Linux 2.6.3
Date: Tue, 2 Mar 2004 15:20:28 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403021520.PAA17194@liam2.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav wrote on alsa-project.org:

   "simply copy files from the ALSA's alsa-kernel CVS module to relevant
   locations in the 2.6 kernel tree."

This is one method of upgrading to CVS ALSA.
However, using this method with Linux 2.6.3 and current CVS alsa-kernel
gives errors:

 $ cd linux-2.6.3

Optionally remove the old sound: [ $ mv sound sound-default-2.6.3 ]

 $ date
Mon 01 March 2004
 $ cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login
[...]
 $ cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-kernel
[...]
 $ cp -fR alsa-kernel/* sound

 $ make oldconfig
 $ make xconfig
make[1]: `scripts/fixdep' is up to date.
scripts/kconfig/qconf arch/i386/Kconfig
sound/Kconfig:35: can't open file "sound/oss/dmasound/Kconfig"
make[1]: *** [xconfig] Error 1
make: *** [xconfig] Error 2

 $ make clean
  CLEAN   arch/i386/boot/compressed
  CLEAN   arch/i386/boot
  CLEAN   arch/i386/kernel
  CLEAN   drivers/char
  CLEAN   drivers/ieee1394
  CLEAN   drivers/pci
  CLEAN   drivers/scsi/aic7xxx
  CLEAN   init
  CLEAN   lib
sound/oss/Makefile:99: linux-2.6.3/Rules.make: No such file or directory
make[2]: *** No rule to make target `linux-2.6.3/Rules.make'.  Stop.
make[1]: *** [sound/oss] Error 2
make: *** [_clean_sound] Error 2

This doesn't work.
So, after recursively copying the contents of the old sound-default-2.6.3/oss
into the new ALSA CVS directory:

 $ cp -iR sound-default-2.6.3/oss sound
cp: overwrite `sound/oss/Makefile'? y

 $ make clean
  CLEAN   usr
  CLEAN   scripts/genksyms
  CLEAN   scripts/kconfig
  CLEAN   scripts
  RM  $(CLEAN_FILES)

 $ make oldconfig
  HOSTCC  scripts/fixdep
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -o arch/i386/Kconfig
[...]
  Digigram miXart (SND_MIXART) [N/m/?] (NEW)

 $ make
  CC [M]  sound/core/pcm.o
sound/core/pcm.c: In function `snd_pcm_substream_proc_hw_params_read':
sound/core/pcm.c:332: structure has no member named `period_frames'
sound/core/pcm.c: At top level:
sound/core/pcm.c:1064: `snd_pcm_limit_hw_rates' undeclared here (not in a function)
sound/core/pcm.c:1064: initializer element is not constant
sound/core/pcm.c:1064: (near initialization for `__ksymtab_snd_pcm_limit_hw_rates.value')
make[2]: *** [sound/core/pcm.o] Error 1
make[1]: *** [sound/core] Error 2
make: *** [sound] Error 2




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
