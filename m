From: Stephen Hassard <steve@hassard.net>
Subject: Broken emu10k1 driver in Alsa CVS
Date: Wed, 16 Apr 2003 16:33:56 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030416233356.GC15301@www.angiotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I'm trying to compile the emu10k1 driver using today's CVS against kernel v2.5.67 and am getting a bunch of compile errors in 'emufx.c' ..

>>>
gcc -Wp,-MD,sound/pci/emu10k1/.emufx.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=emufx -DKBUILD_MODNAME=snd_emu10k1 -c -o sound/pci/emu10k1/emufx.o sound/pci/emu10k1/emufx.c
sound/pci/emu10k1/emufx.c: In function `_snd_emu10k1_audigy_init_efx':
sound/pci/emu10k1/emufx.c:1506: syntax error before '<<' token
sound/pci/emu10k1/emufx.c:1240: warning: unused variable `err'
sound/pci/emu10k1/emufx.c:1244: warning: unused variable `seg'
sound/pci/emu10k1/emufx.c: At top level:
sound/pci/emu10k1/emufx.c:1509: syntax error before '==' token
sound/pci/emu10k1/emufx.c:1511: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1513: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1516: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1517: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1518: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1521: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1524: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1525: syntax error before '&' token
sound/pci/emu10k1/emufx.c:1533: warning: type defaults to `int' in declaration of `err'
sound/pci/emu10k1/emufx.c:1533: warning: data definition has no type or storage class
sound/pci/emu10k1/emufx.c:1534: syntax error before "goto"
sound/pci/emu10k1/emufx.c:1540: warning: type defaults to `int' in declaration of `seg'
sound/pci/emu10k1/emufx.c:1540: incompatible types in initialization
sound/pci/emu10k1/emufx.c:1540: initializer element is not constant
sound/pci/emu10k1/emufx.c:1540: warning: data definition has no type or storage class
sound/pci/emu10k1/emufx.c:1541: syntax error before '->' token
sound/pci/emu10k1/emufx.c:1543: warning: type defaults to `int' in declaration of `err'
sound/pci/emu10k1/emufx.c:1543: redefinition of `err'
sound/pci/emu10k1/emufx.c:1533: `err' previously defined here
sound/pci/emu10k1/emufx.c:1543: `emu' undeclared here (not in a function)
sound/pci/emu10k1/emufx.c:1543: `icode' undeclared here (not in a function)
sound/pci/emu10k1/emufx.c:1543: initializer element is not constant
sound/pci/emu10k1/emufx.c:1543: warning: data definition has no type or storage class
sound/pci/emu10k1/emufx.c:1544: warning: type defaults to `int' in declaration of `snd_leave_user'
sound/pci/emu10k1/emufx.c:1544: warning: parameter names (without types) in function declaration
sound/pci/emu10k1/emufx.c:1544: conflicting types for `snd_leave_user'
sound/pci/emu10k1/emufx.c:305: previous declaration of `snd_leave_user'
sound/pci/emu10k1/emufx.c:1544: warning: data definition has no type or storage class
sound/pci/emu10k1/emufx.c:1546: syntax error before ':' token
sound/pci/emu10k1/emufx.c:1548: warning: type defaults to `int' in declaration of `kfree'
sound/pci/emu10k1/emufx.c:1548: warning: parameter names (without types) in function declaration
sound/pci/emu10k1/emufx.c:1548: conflicting types for `kfree'
include/linux/slab.h:62: previous declaration of `kfree'
sound/pci/emu10k1/emufx.c:1548: warning: data definition has no type or storage class
sound/pci/emu10k1/emufx.c:1549: syntax error before "return"
{standard input}: Assembler messages:
{standard input}:3573: Error: symbol `err' is already defined
make[3]: *** [sound/pci/emu10k1/emufx.o] Error 1
make[2]: *** [sound/pci/emu10k1] Error 2
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2
<<<

0.9.2 doesn't seem to have this problem.

Thanks,
Stephen Hassard


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
