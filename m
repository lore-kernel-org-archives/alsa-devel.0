From: Bob Ham <node@users.sourceforge.net>
Subject: Errors compiling alsa-drivers rc3
Date: 16 Aug 2002 01:58:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1029459538.10040.166.camel@insanity>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa-driver-0.9.0rc3/include -I/lib/modules/2.4.19-lowlatency/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  -DKBUILD_BASENAME=als100   -c -o als100.o als100.c
In file included from /usr/src/alsa-driver-0.9.0rc3/include/adriver.h:124,
                 from /usr/src/alsa-driver-0.9.0rc3/include/sound/driver.h:43,
                 from ../alsa-kernel/isa/als100.c:23,
                 from als100.c:1:
/usr/src/alsa-driver-0.9.0rc3/include/linux/isapnp.h:334: warning: `struct isapnp_card_id' declared inside parameter list
/usr/src/alsa-driver-0.9.0rc3/include/linux/isapnp.h:334: warning: its scope is only this definition or declaration, which is probably not what you want.
In file included from als100.c:1:
../alsa-kernel/isa/als100.c:121: elements of array `snd_als100_pnpids' have incomplete type
../alsa-kernel/isa/als100.c:123: warning: implicit declaration of function `ISAPNP_CARD_ID'
../alsa-kernel/isa/als100.c:123: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:123: warning: (near initialization for `snd_als100_pnpids[0]')
../alsa-kernel/isa/als100.c:123: unknown field `devs' specified in initializer
../alsa-kernel/isa/als100.c:123: extra brace group at end of initializer
../alsa-kernel/isa/als100.c:123: (near initialization for `snd_als100_pnpids[0]')
../alsa-kernel/isa/als100.c:123: warning: implicit declaration of function `ISAPNP_DEVICE_ID'
../alsa-kernel/isa/als100.c:123: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:123: warning: (near initialization for `snd_als100_pnpids[0]')
../alsa-kernel/isa/als100.c:125: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:125: warning: (near initialization for `snd_als100_pnpids[1]')
../alsa-kernel/isa/als100.c:125: unknown field `devs' specified in initializer
../alsa-kernel/isa/als100.c:125: extra brace group at end of initializer
../alsa-kernel/isa/als100.c:125: (near initialization for `snd_als100_pnpids[1]')
../alsa-kernel/isa/als100.c:125: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:125: warning: (near initialization for `snd_als100_pnpids[1]')
../alsa-kernel/isa/als100.c:127: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:127: warning: (near initialization for `snd_als100_pnpids[2]')
../alsa-kernel/isa/als100.c:127: unknown field `devs' specified in initializer
../alsa-kernel/isa/als100.c:127: extra brace group at end of initializer
../alsa-kernel/isa/als100.c:127: (near initialization for `snd_als100_pnpids[2]')
../alsa-kernel/isa/als100.c:127: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:127: warning: (near initialization for `snd_als100_pnpids[2]')
../alsa-kernel/isa/als100.c:129: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:129: warning: (near initialization for `snd_als100_pnpids[3]')
../alsa-kernel/isa/als100.c:129: unknown field `devs' specified in initializer
../alsa-kernel/isa/als100.c:129: extra brace group at end of initializer
../alsa-kernel/isa/als100.c:129: (near initialization for `snd_als100_pnpids[3]')
../alsa-kernel/isa/als100.c:129: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:129: warning: (near initialization for `snd_als100_pnpids[3]')
../alsa-kernel/isa/als100.c:131: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:131: warning: (near initialization for `snd_als100_pnpids[4]')
../alsa-kernel/isa/als100.c:131: unknown field `devs' specified in initializer
../alsa-kernel/isa/als100.c:131: extra brace group at end of initializer
../alsa-kernel/isa/als100.c:131: (near initialization for `snd_als100_pnpids[4]')
../alsa-kernel/isa/als100.c:131: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:131: warning: (near initialization for `snd_als100_pnpids[4]')
../alsa-kernel/isa/als100.c:132: `ISAPNP_CARD_END' undeclared here (not in a function)
../alsa-kernel/isa/als100.c:132: warning: excess elements in struct initializer
../alsa-kernel/isa/als100.c:132: warning: (near initialization for `snd_als100_pnpids[5]')
../alsa-kernel/isa/als100.c:133: invalid use of undefined type `struct isapnp_card_id'
../alsa-kernel/isa/als100.c:135: warning: type defaults to `int' in declaration of `ISAPNP_CARD_TABLE'
../alsa-kernel/isa/als100.c:135: warning: parameter names (without types) in function declaration
../alsa-kernel/isa/als100.c:135: warning: data definition has no type or storage class
../alsa-kernel/isa/als100.c: In function `snd_card_als100_isapnp':
../alsa-kernel/isa/als100.c:149: dereferencing pointer to incomplete type
../alsa-kernel/isa/als100.c:149: dereferencing pointer to incomplete type
../alsa-kernel/isa/als100.c:154: dereferencing pointer to incomplete type
../alsa-kernel/isa/als100.c:154: dereferencing pointer to incomplete type
../alsa-kernel/isa/als100.c:159: dereferencing pointer to incomplete type
../alsa-kernel/isa/als100.c:159: dereferencing pointer to incomplete type
../alsa-kernel/isa/als100.c: In function `alsa_card_als100_init':
../alsa-kernel/isa/als100.c:371: warning: passing arg 1 of `isapnp_probe_cards_R1d966f40' from incompatible pointer type
../alsa-kernel/isa/als100.c:371: warning: passing arg 2 of `isapnp_probe_cards_R1d966f40' from incompatible pointer type
make[1]: *** [als100.o] Error 1
make[1]: Leaving directory `/usr/src/alsa-driver-0.9.0rc3/isa'
make: *** [compile] Error 1

That's using gcc 2.95.4, kernel is 2.4.19.

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
