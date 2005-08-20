From: Raymond <rayau@netvigator.com>
Subject: Re: Disagreement about versions following CVS update
Date: Sat, 20 Aug 2005 15:17:37 +0800
Message-ID: <4306D911.70101@netvigator.com>
References: <43063408.60402@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43063408.60402@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Philip Prindeville wrote:
> I did a CVS update yesterday, and a rebuild and tried to reinstall, and
> I'm seeing:
> 
> WARNING: Error inserting snd_seq_device 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/seq/snd-seq-device.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> WARNING: Error inserting snd_rawmidi 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-rawmidi.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> WARNING: Error inserting snd_mpu401_uart 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> WARNING: Error inserting snd_timer 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-timer.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> WARNING: Error inserting snd_timer 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-timer.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> FATAL: Error inserting snd_pcm 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-pcm.ko): Unknown 
> symbol in module, or unknown parameter (see dmesg)
> WARNING: Error running install command for snd_pcm
> WARNING: Error inserting snd_ac97_codec 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/pci/ac97/snd-ac97-codec.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> FATAL: Error inserting snd_via82xx 
> (/lib/modules/2.6.12-1.1372_FC3/kernel/sound/pci/snd-via82xx.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> 
> Stupid question:  did a version number get changed somewhere?  And if
> so, what's the fix?  I did a:
> 
> % make -C alsa-driver clean
> 
> and a rebuild, but I'm still seeing these.  What did I miss?
> 
> -Philip

It seem that ALSA version has been changed from 1.0.9b to 1.10.0-rc1 on CVS.

alsa-driver and alsa-lib can be rebuilded except alsa-utils.
I follow the instruction but cannot compile alsa-utils (CVS) on FC1.


cvs/alsa-utils]# ./cvscompile
Copying file ABOUT-NLS
Copying file config.rpath
Copying file mkinstalldirs
Not copying intl/ directory.
Copying file po/Makefile.in.in
Copying file po/boldquot.sed
Copying file po/en@boldquot.header
Copying file po/en@quot.header
Copying file po/insert-header.sin
Copying file po/Makevars.template
Copying file po/quot.sed
Copying file po/remove-potcdate.sin
Copying file po/Rules-quot
Copying file m4/codeset.m4
Copying file m4/gettext.m4
Copying file m4/glibc21.m4
Copying file m4/iconv.m4
Copying file m4/intdiv0.m4
Copying file m4/inttypes.m4
Copying file m4/inttypes_h.m4
Copying file m4/inttypes-pri.m4
Copying file m4/isc-posix.m4
Copying file m4/lcmessage.m4
Copying file m4/lib-ld.m4
Copying file m4/lib-link.m4
Copying file m4/lib-prefix.m4
Copying file m4/nls.m4
Copying file m4/po.m4
Copying file m4/progtest.m4
Copying file m4/stdint_h.m4
Copying file m4/uintmax_t.m4
Copying file m4/ulonglong.m4
Updating configure.in (backup is in configure.in~)

Please use AM_GNU_GETTEXT([external]) in order to cause autoconfiguration
to look for an external libintl.

Please run 'aclocal -I m4' to regenerate the aclocal.m4 file.
You need aclocal from GNU automake 1.5 (or newer) to do this.
Then run 'autoconf' to regenerate the configure file.

You might also want to copy the convenience header file gettext.h
from the /usr/share/gettext directory into your package.
It is a wrapper around <libintl.h> that implements the configure 
--disable-nls
option.

Press Return to acknowledge the previous three paragraphs.

CFLAGS=-O2 -Wall -pipe -g
./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for style of include used by make... GNU
checking for gcc... gcc32
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc32 accepts -g... yes
checking for gcc32 option to accept ANSI C... none needed
checking dependency style of gcc32... gcc3
checking build system type... i686-redhat-linux-gnu
checking host system type... i686-redhat-linux-gnu
checking for ld used by GCC... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for shared library run path origin... done
checking whether NLS is requested... yes
checking for GNU gettext in libc... yes
checking whether to use NLS... yes
checking where the gettext function comes from... libc
./configure: line 4415: syntax error near unexpected token `<<<'
./configure: line 4415: `<<<<<<< configure.in'


cvs/alsa-utils]# aclocal --version
aclocal (GNU automake) 1.7.8

cvs/alsa-utils]# aclocal -I m4

cvs/alsa-utils]# autoconf --version
autoconf (GNU Autoconf) 2.57

cvs/alsa-utils]# autoconf

cvs/alsa-utils]# ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for style of include used by make... GNU
checking for gcc... gcc32
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc32 accepts -g... yes
checking for gcc32 option to accept ANSI C... none needed
checking dependency style of gcc32... gcc3
checking build system type... i686-redhat-linux-gnu
checking host system type... i686-redhat-linux-gnu
checking for ld used by GCC... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for shared library run path origin... done
checking whether NLS is requested... yes
checking for GNU gettext in libc... yes
checking whether to use NLS... yes
checking where the gettext function comes from... libc
./configure: line 4415: syntax error near unexpected token `<<<'
./configure: line 4415: `<<<<<<< configure.in'







-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
