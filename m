From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Error compiling alsa-driver-1.0.1 on kernel 2.6.1 SMP: PDE
 (re)definition?
Date: Sun, 11 Jan 2004 13:24:50 -0000 (WET)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <32846.192.168.1.5.1073827490.squirrel@www.rncbc.org>
References: <32796.192.168.1.5.1072829449.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <32796.192.168.1.5.1072829449.squirrel@www.rncbc.org>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi again,

My status is yet having trouble compiling stock alsa-driver-1.0.1 for a
fresh linux-2.6.1 SMP kernel on a SuSE 9.0 box.

The modules supplied in the kernel tree (from alsa-bk-2004-01-09.patch.gz)
compiled and loaded almost fine and sounds as expected.  Currently using
snd-intell8x0 on a ASUS P4P800-Dlx mobo running P4 2.80C@3.36GHz SMP/HT
with 1GB DDR400. Guess I'm OK with that but I'm sending this note just for
the records.

When building from stock alsa-driver-1.0.1, the error is as follows:

make[1]: Entering directory `/usr/src/linux-2.6.1-0.smp'
  HOSTCC  scripts/fixdep
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/bin2c
  SPLIT   include/linux/autoconf.h -> include/config/*
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
  CC      arch/i386/kernel/asm-offsets.s
  CHK     include/asm-i386/asm_offsets.h
  UPD     include/asm-i386/asm_offsets.h
  CC [M]  /usr/src/source/alsa/alsa-driver-1.0.1/acore/hwdep.o
In file included from
/usr/src/source/alsa/alsa-driver-1.0.1/include/sound/driver.h:42,
                 from
/usr/src/source/alsa/alsa-driver-1.0.1/acore/hwdep.c:22:
/usr/src/source/alsa/alsa-driver-1.0.1/include/adriver.h:134: error:
redefinition of `PDE'
include/linux/proc_fs.h:255: error: `PDE' previously defined here
make[2]: *** [/usr/src/source/alsa/alsa-driver-1.0.1/acore/hwdep.o] Error 1
make[1]: *** [/usr/src/source/alsa/alsa-driver-1.0.1/acore] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.1-0.smp'
make: *** [compile] Error 1


Looks like the same ol'configure mistake: CONFIG_HAVE_PDE should be
undefined but somehow it isn't.

TIA.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
