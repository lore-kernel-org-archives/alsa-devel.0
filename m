From: Matt Walker <mwalker@attbi.com>
Subject: problems compiling rc3 drivers
Date: Thu, 15 Aug 2002 17:44:30 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020815224601.RBKV13899.sccrmhc02.attbi.com@there>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I had successfully compiled rc2 when it came out, so I don't see any wildly 
off-base config problems. I have SuSE 7.3 on AMD K6,  with a Creative SB 
Vibra-16x and Midisport 2x2 --

./configure --with-cards=sb16,usb-midi --with-sequencer=yes --with-isapnp=yes
make
make[1]: Entering directory `/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/acore'
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include 
-I/lib/modules/2.4.10-4GB/build/include -O2 -mpreferred-stack-boundary=2 
-march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe   
-DEXPORT_SYMTAB -c hwdep.c
In file included from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/adriver.h:124,
                 from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
                 from ../alsa-kernel/core/hwdep.c:22,
                 from hwdep.c:1:
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
`struct isapnp_card_id' declared inside parameter list
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
its scope is only this definition or declaration, which is probably not what 
you want.
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include 
-I/lib/modules/2.4.10-4GB/build/include -O2 -mpreferred-stack-boundary=2 
-march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe   
-DEXPORT_SYMTAB -c pcm.c
In file included from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/adriver.h:124,
                 from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
                 from ../alsa-kernel/core/pcm.c:22,
                 from pcm.c:1:
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
`struct isapnp_card_id' declared inside parameter list
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
its scope is only this definition or declaration, which is probably not what 
you want.
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include 
-I/lib/modules/2.4.10-4GB/build/include -O2 -mpreferred-stack-boundary=2 
-march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  
-DKBUILD_BASENAME=pcm_native   -c -o pcm_native.o pcm_native.c
In file included from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/adriver.h:124,
                 from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
                 from ../alsa-kernel/core/pcm_native.c:22,
                 from pcm_native.c:2:
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
`struct isapnp_card_id' declared inside parameter list
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
its scope is only this definition or declaration, which is probably not what 
you want.
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include 
-I/lib/modules/2.4.10-4GB/build/include -O2 -mpreferred-stack-boundary=2 
-march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe   
-DEXPORT_SYMTAB -c pcm_lib.c
In file included from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/adriver.h:124,
                 from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
                 from ../alsa-kernel/core/pcm_lib.c:23,
                 from pcm_lib.c:2:
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
`struct isapnp_card_id' declared inside parameter list
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
its scope is only this definition or declaration, which is probably not what 
you want.
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include 
-I/lib/modules/2.4.10-4GB/build/include -O2 -mpreferred-stack-boundary=2 
-march=i586 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  
-DKBUILD_BASENAME=info_oss   -c -o info_oss.o info_oss.c
In file included from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/adriver.h:124,
                 from 
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
                 from ../alsa-kernel/core/info_oss.c:22,
                 from info_oss.c:2:
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
`struct isapnp_card_id' declared inside parameter list
/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/include/linux/isapnp.h:368: warning: 
its scope is only this definition or declaration, which is probably not what 
you want.
.
.
.... and many more of the same form....
.
.
.
rm -f snd-hwdep.o
ld  -r -o snd-hwdep.o hwdep.o
rm -f snd-pcm.o
ld  -r -o snd-pcm.o pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o 
pcm_memory.o pcm_sgbuf.o
pcm_native.o: In function `isapnp_wake':
pcm_native.o(.text+0x0): multiple definition of `isapnp_wake'
pcm.o(.text+0x0): first defined here
pcm_native.o: In function `isapnp_device':
pcm_native.o(.text+0x4): multiple definition of `isapnp_device'
pcm.o(.text+0x4): first defined here
pcm_native.o: In function `isapnp_activate':
pcm_native.o(.text+0x8): multiple definition of `isapnp_activate'
pcm.o(.text+0x8): first defined here
pcm_native.o: In function `isapnp_deactivate':
pcm_native.o(.text+0xc): multiple definition of `isapnp_deactivate'
pcm.o(.text+0xc): first defined here
pcm_native.o: In function `isapnp_find_card':
pcm_native.o(.text+0x10): multiple definition of `isapnp_find_card'
pcm.o(.text+0x10): first defined here
pcm_native.o: In function `isapnp_find_dev':
pcm_native.o(.text+0x14): multiple definition of `isapnp_find_dev'
pcm.o(.text+0x14): first defined here
pcm_native.o: In function `isapnp_probe_cards':
pcm_native.o(.text+0x18): multiple definition of `isapnp_probe_cards'
pcm.o(.text+0x18): first defined here
pcm_native.o: In function `isapnp_resource_change':
pcm_native.o(.text+0x1c): multiple definition of `isapnp_resource_change'
pcm.o(.text+0x1c): first defined here
.
.
.... and so on, several dozen more like that
.
.
make[1]: *** [snd-pcm.o] Error 1
make[1]: Leaving directory `/home/matt/alsa/rc3/alsa-driver-0.9.0rc3/acore'
make: *** [compile] Error 1


any thoughts?

Thanks,

Matt Walker


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
