From: Stephen Hassard <steve@hassard.net>
Subject: compile error w/ envy24ht + linux 2.5.67
Date: Mon, 14 Apr 2003 13:45:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030414204509.GA1263@www.angiotech.com>
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

Hi there,

When I try to compile a Linux 2.5.67 kernel with Alsa (from today's CVS) I get the following error:
gcc -Wp,-MD,sound/pci/ice1712/.ice1724.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ice1724 -DKBUILD_MODNAME=snd_ice1724 -c -o sound/pci/ice1712/ice1724.o sound/pci/ice1712/ice1724.c
sound/pci/ice1712/ice1724.c:1297: parse error before `__attribute__'
sound/pci/ice1712/ice1724.c:1214: warning: `snd_vt1724_pro_internal_clock_info' defined but not used
sound/pci/ice1712/ice1724.c:1243: warning: `snd_vt1724_pro_internal_clock_get' defined but not used
sound/pci/ice1712/ice1724.c:1266: warning: `snd_vt1724_pro_internal_clock_put' defined but not used
make[3]: *** [sound/pci/ice1712/ice1724.o] Error 1
make[2]: *** [sound/pci/ice1712] Error 2
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2

I have both gcc 2.95.4 and 3.2.3-0pre5 installed (debian - testing).

Any help would be appreciated.

Thanks,
Steve


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
