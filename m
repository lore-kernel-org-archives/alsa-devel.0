From: Dmitry Goroh <solaris2001@bk.ru>
Subject: alsa-driver-1.0.0rc2 compilation error with linux-2.6.0-test11
Date: Fri, 5 Dec 2003 22:19:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031205221945.1eb64044.solaris2001@bk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi!
I have compilation problems with alsa-driver-1.0.0rc2:

--- skip ----
make[1]: Entering directory `/usr/src/linux-2.6.0-test11'
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  /home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/acore/hwdep.o
In file included from
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/includ
e/sound/driver.h:42,                 from
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/acore/ hwdep.c:22:
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/include/adriver.h:281:
redef inition of `devfs_remove'
include/linux/devfs_fs_kernel.h:44: `devfs_remove' previously defined here
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/include/adriver.h:372:
redef inition of `module_put'
include/linux/module.h:318: `module_put' previously defined here
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/include/adriver.h: In
functi on `module_put':
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/include/adriver.h:374:
warni ng: implicit declaration of function `__MOD_DEC_USE_COUNT'
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/acore/hwdep.c: In
function ` snd_hwdep_open':
/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/acore/hwdep.c:110:
warning: implicit declaration of function `try_inc_mod_count'
make[2]: ***
[/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/acore/hwdep.o] Error 1
make[1]: *** [/home/dmitry/work/tmp/new/alsa/alsa-driver-1.0.0rc2/acore]
Error 2 make[1]: Leaving directory `/usr/src/linux-2.6.0-test11'
make: *** [compile] Error 1
[root@thunder alsa-driver-1.0.0rc2]#

My system is:
AMD K6-2 400, 128 RAM, Opti-931 isa soundcard
RH 9 with new linux-2.6.0-test11 kernel
GCC 3.2.2
LIBC 2.3.2

my "configure" invoked like that:
./configure --with-cards=opti93x --with-oss=yes --with-sequencer=no
--with-isapnp=yes

I had the same problem with previous "rc1" version but I solved this by
recompiling my kernel and reinstalling modules. Then I've built
alsa-driver. I wonder why alsa depends on kernel recompilation.
Unfortunately, "rc2" doesn't compile in this way: I recompile my kernel with
my previous .config (so I don't need to reinstall files) and... nothing
happens. Error still occurs.

It's seems there are redefinitions problems in a couple of files (see log
above). Any ideas how to fix that?

Thanks.
-----
Dmitry


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
