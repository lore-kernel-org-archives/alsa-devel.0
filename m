From: Jordi Mallach <jordi@debian.org>
Subject: Forwarding Debian bugs + patches
Date: Sat, 12 Apr 2003 18:11:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030412161149.GA6090@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
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


--EuxKj2iCbKjpUGkD
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alsa team!

We have a few bugs we'd like to report, and a pair of patches against
0.9.2.

*** Bug#187831: sparc64 compilation problems and fixes
Fabio Massimo Di Nitto reports that ALSA 0.9.2 doesn't compile on
sparc64. He provides a patch that fixes the compilation, but he gets an
unresolved symbol: virt_to_bus_not_defined_use_pci_map, which apparently
unveils non-portable code. The problem isn't present in 2.5.x ALSA.
The patch is attached.
http://bugs.debian.org/187831


*** Bug#187818: AC97 does not respond - RESET (EMU10K1/Audigy)
Fabio reports he's getting messages like
ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1960: AC'97 0:0 does not respo=
nd - RESET
EMU10K1/Audigy soundcard not found or device busy

with an Audigy 2 Platinum EX with card ID 0004.

Fabio has no problem providing a shell account to alsa developers. If
you need it, please contact me.
http://bugs.debian.org/187818


*** Bug#186403: Kernel oops on unloading snd-pcm-oss
Darren Salt reports that after trying to remove the alsa modules, he
gets an oops. Ksymoops are attached to this mail. Steve thinks it's a
devfs bug.
http://bugs.debian.org/186403, emu10k1 sound card.
This was reported against 0.9.1.


*** Bug#186240: alsa-source: ooops with 2.4.20
Kernel oops whenever he tries to use sound. ksymoops attached to the bug
report, too.
http://bugs.debian.org/186240


*** Bug#176166: alsa-source: alsa-driver .deb does not build with make -j
We just got a patch to Rules.make which fix this. Attached.


*** Bug#173291: alsa-source: cannot unload snd-trident-synth
Andrea can't unload the sound modules because modprobe -r
snd-trident-synth says the module is in use, even in single user mode.
He recently tried 0.9.2, no luck still.
http://bugs.debian.org/173291


*** Bug#183315: Opening /dev/sequencer will eventually cause a segfault or =
state D [emu10k1]
Darren has had this problem for some time now, which I reported on my
last mail, and some action was taken. Before, /dev/sequencer would
return ENOMEM with emu10k1. After the fixes in the rc8 series, the
ENOMEM problem was gone, but he started getting segfaults and sleeping
processes. We have no more input from success/failure on 0.9.2.
http://bugs.debian.org/183315.


*** Bug#183316: OSS-emulation MIDI timer problems
Quoting the bug seems quite appropiate:

> SEQ_START_TIMER(), if used more than once for a given /dev/sequencer sess=
ion,
> causes odd things to happen. I'm not quite sure what's going on here, but
> investigaton using lxmusserv and rosegarden shows that timer events seem =
to
> be occurring in bursts.
>=20
> With Doom, let some piece of music be repeated then try to do something
> (start a game, quit) and you'll find that it doesn't happen immediately;
> instead, it happens some time later; mwanwhile, the same music continues =
to
> be played as the game engine is blocked, waiting for musserv to read in t=
he
> new music data.
>=20
> With rosegarden, the effect can be seen by starting, stopping and restart=
ing
> the music: watch the timer apparently make several large jumps (each
> corresponding to many SNDCTL_SEQ_SYNC + SEQ_WAIT_TIME pairs) instead of l=
ots
> of small jumps (each of which corresponds to one SNDCTL_SEQ_SYNC +
> SEQ_WAIT_TIME pair).

I can't remember if this was included in our last mail. It was reported
against rc7, and we have no more info about it.


*** Bug#168448: 0.9rc5 impossible to load intel8x0 with 2.2.20 kernel
Reporter says that he can't load intel8x0 with 2.2.20, since he upgraded
=66rom beta10 to rc5. He gets the following message:
PCI: Increasing latency timer of device 00:01 to 64
ALSA ../alsa-kernel/pci/intel8x0.c:1739: AC'97 warm reset still in progress=
? [0xf0000907]
Intel ICH soundcard not found or device busy

Steve, from the Debian team, says he can reproduce it (has the hardware), a=
nd
would be happy to test possible patches, etc.

Thanks for the comments,
Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_sparc64_fixes.dpatch"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh -e

# 01_sparc_fixes.dpatch by Steve Kowalik and Fabio Massimo Di Nitto

# DP: Correct build-failure on sparc64.

=2E debian/patches/patch-opts

if [ $# -ne 1 ]; then
    echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
    exit 1
fi
case "$1" in
    -patch) patch $patch_opts < $0;;
    -unpatch) patch $patch_opts -R < $0;;
    *)
        echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
        exit 1;;
esac

exit 0

diff -Naurd alsa-driver.ORIG/include/adriver.h alsa-driver/include/adriver.h
--- alsa-driver.ORIG/include/adriver.h	2003-03-08 14:38:29.000000000 +0100
+++ alsa-driver/include/adriver.h	2003-04-06 10:36:17.000000000 +0200
@@ -323,7 +323,6 @@
 /* vmalloc_to_page wrapper */
 #ifndef CONFIG_HAVE_VMALLOC_TO_PAGE
 struct page *snd_compat_vmalloc_to_page(void *addr);
-#define vmalloc_to_page(addr) snd_compat_vmalloc_to_page(addr)
 #endif
=20
 #include "amagic.h"

*) 64bit call to ld

diff -Naurd alsa-driver.ORIG/configure alsa-driver/configure
--- alsa-driver.ORIG/configure	2003-03-19 19:50:30.000000000 +0100
+++ alsa-driver/configure	2003-04-06 10:33:35.000000000 +0200
@@ -3385,7 +3385,7 @@
     $CC -m64 -mcmodel=3Dmedlow -S -o /dev/null -xc /dev/null >/dev/null 2>=
&1 && NEW_GCC=3Dy
     $LD --version 2>&1 | grep 'elf64_sparc' > /dev/null && NEW_GAS=3Dy
     $CC -c -x assembler /dev/null -Wa,--help | grep undeclared-regs > /dev=
/null || CC_UNDECL=3D"-Wa,--undeclared-regs"
-    if test $NEW_GAS !=3D y; then
+    if test $NEW_GAS =3D y; then
       LD=3Dsparc64-linux-ld
     else
       LD=3D"$LD -m elf64_sparc"
diff -Naurd alsa-driver.ORIG/configure.in alsa-driver/configure.in
--- alsa-driver.ORIG/configure.in	2003-03-19 18:51:40.000000000 +0100
+++ alsa-driver/configure.in	2003-04-06 10:33:51.000000000 +0200
@@ -542,7 +542,7 @@
     $CC -m64 -mcmodel=3Dmedlow -S -o /dev/null -xc /dev/null >/dev/null 2>=
&1 && NEW_GCC=3Dy
     $LD --version 2>&1 | grep 'elf64_sparc' > /dev/null && NEW_GAS=3Dy
     $CC -c -x assembler /dev/null -Wa,--help | grep undeclared-regs > /dev=
/null || CC_UNDECL=3D"-Wa,--undeclared-regs"
-    if test $NEW_GAS !=3D y; then
+    if test $NEW_GAS =3D y; then
       LD=3Dsparc64-linux-ld
     else
       LD=3D"$LD -m elf64_sparc"

*) sbus dma call

diff -Naurd alsa-driver.ORIG/alsa-kernel/core/memalloc.c alsa-driver/alsa-k=
ernel/core/memalloc.c
--- alsa-driver.ORIG/alsa-kernel/core/memalloc.c	2003-03-05 12:30:15.000000=
000 +0100
+++ alsa-driver/alsa-kernel/core/memalloc.c	2003-04-06 10:41:05.000000000 +=
0200
@@ -181,7 +181,7 @@
 #endif
 #ifdef CONFIG_SBUS
 	case SNDRV_DMA_TYPE_SBUS:
-		snd_free_sbus_pages(dev->dev.sbus, dmab->size, dmab->are, dmab->addr);
+		snd_free_sbus_pages(dev->dev.sbus, dmab->bytes, dmab->area, dmab->addr);
 		break;
 #endif
 	default:

*) ioctl32 compilation

diff -Naurd alsa-driver.ORIG/alsa-kernel/core/ioctl32/pcm32.c alsa-driver/a=
lsa-kernel/core/ioctl32/pcm32.c
--- alsa-driver.ORIG/alsa-kernel/core/ioctl32/pcm32.c	2003-02-06 18:59:15.0=
00000000 +0100
+++ alsa-driver/alsa-kernel/core/ioctl32/pcm32.c	2003-04-06 11:24:48.000000=
000 +0200
@@ -138,7 +138,6 @@
=20
 struct timeval32 {
 	s32 tv_sec;
-	s32 tv_usec;
 } __attribute__((packed));
=20
 struct sndrv_pcm_status32 {
@@ -159,9 +158,7 @@
 {\
 	COPY(state);\
 	COPY(trigger_tstamp.tv_sec);\
-	COPY(trigger_tstamp.tv_usec);\
 	COPY(tstamp.tv_sec);\
-	COPY(tstamp.tv_usec);\
 	COPY(appl_ptr);\
 	COPY(hw_ptr);\
 	COPY(delay);\
diff -Naurd alsa-driver.ORIG/alsa-kernel/core/ioctl32/rawmidi32.c alsa-driv=
er/alsa-kernel/core/ioctl32/rawmidi32.c
--- alsa-driver.ORIG/alsa-kernel/core/ioctl32/rawmidi32.c	2003-02-06 18:59:=
15.000000000 +0100
+++ alsa-driver/alsa-kernel/core/ioctl32/rawmidi32.c	2003-04-06 11:25:09.00=
0000000 +0200
@@ -44,7 +44,6 @@
=20
 struct timeval32 {
 	s32 tv_sec;
-	s32 tv_usec;
 } __attribute__((packed));
=20
 struct sndrv_rawmidi_status32 {
@@ -59,7 +58,6 @@
 {\
 	COPY(stream);\
 	COPY(tstamp.tv_sec);\
-	COPY(tstamp.tv_usec);\
 	COPY(avail);\
 	COPY(xruns);\
 }
diff -Naurd alsa-driver.ORIG/alsa-kernel/core/ioctl32/timer32.c alsa-driver=
/alsa-kernel/core/ioctl32/timer32.c
--- alsa-driver.ORIG/alsa-kernel/core/ioctl32/timer32.c	2003-02-06 18:59:16=
=2E000000000 +0100
+++ alsa-driver/alsa-kernel/core/ioctl32/timer32.c	2003-04-06 11:25:43.0000=
00000 +0200
@@ -31,7 +31,6 @@
 	s32 card;
 	unsigned char id[64];
 	unsigned char name[80];
-	u32 ticks;
 	u32 resolution;
 	unsigned char reserved[64];
 };
@@ -42,13 +41,11 @@
 	COPY(card);\
 	memcpy(dst->id, src->id, sizeof(src->id));\
 	memcpy(dst->name, src->name, sizeof(src->name));\
-	COPY(ticks);\
 	COPY(resolution);\
 }
=20
 struct timeval32 {
 	s32 tv_sec;
-	s32 tv_usec;
 };
=20
 struct sndrv_timer_status32 {
@@ -63,7 +60,6 @@
 #define CVT_sndrv_timer_status()\
 {\
 	COPY(tstamp.tv_sec);\
-	COPY(tstamp.tv_usec);\
 	COPY(resolution);\
 	COPY(lost);\
 	COPY(overrun);\


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="04_make_minus_j_fix.dpatch"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh -e

# 04_make_minus_j_fix.dpatch by Steve Kowalik and Colm Buckley

# DP: Fix building with 'make -j'.

=2E debian/patches/patch-opts

if [ $# -ne 1 ]; then
    echo >&2 "`basename $0`: script expects -patch|-unpatch as argument"
    exit 1
fi

case "$1" in
       -patch) patch $patch_opts -p1 < $0;;
       -unpatch) patch $patch_opts -p1 -R < $0;;
        *)
                echo >&2 "`basename $0`: script expects -patch|-unpatch as =
argument"
                exit 1;;
esac

exit 0

diff -urNad alsa-driver/Rules.make~ alsa-driver/Rules.make
--- alsa-driver/Rules.make~	2003-04-11 22:44:11.000000000 +1000
+++ alsa-driver/Rules.make	2003-04-12 17:09:05.000000000 +1000
@@ -221,7 +221,7 @@
 	genksyms_smp_prefix :=3D=20
 endif
=20
-$(MODINCL)/$(MODPREFIX)%.ver: %.c
+$(MODINCL)/$(MODPREFIX)%.ver: %.c update-sndvers
 	@if [ ! -r $(MODINCL)/$(MODPREFIX)$*.stamp -o $(MODINCL)/$(MODPREFIX)$*.s=
tamp -ot $< ]; then \
 		echo '$(CC) -D__KERNEL__ $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<'=
; \
 		echo '| $(GENKSYMS) $(genksyms_smp_prefix) > $@.tmp'; \
@@ -239,7 +239,8 @@
 endif # export-objs=20
=20
 define update-sndvers
-	@(echo "#ifndef _LINUX_SNDVERSIONS_H"; \
+	(tmpfile=3D`mktemp $(SNDVERSIONS).XXXXXXXXXXXX`; \
+	(echo "#ifndef _LINUX_SNDVERSIONS_H"; \
 	  echo "#define _LINUX_SNDVERSIONS_H"; \
 	  echo "#include <linux/modsetver.h>"; \
 	  cd $(TOPDIR)/include/modules; \
@@ -247,14 +248,14 @@
 	    if [ -f $$f ]; then echo "#include \"modules/$${f}\""; fi; \
 	  done; \
 	  echo "#endif"; \
-	) > $(SNDVERSIONS).tmp
-	@if [ -r $(SNDVERSIONS) ] && cmp -s $(SNDVERSIONS) $(SNDVERSIONS).tmp; th=
en \
+	) > $${tmpfile}; \
+	if [ -r $(SNDVERSIONS) ] && cmp -s $(SNDVERSIONS) $${tmpfile}; then \
 		echo $(SNDVERSIONS) was not updated; \
-		rm -f $(SNDVERSIONS).tmp; \
+		rm -f $${tmpfile}; \
 	else \
 		echo $(SNDVERSIONS) was updated; \
-		mv -f $(SNDVERSIONS).tmp $(SNDVERSIONS); \
-	fi
+		mv -f $${tmpfile} $(SNDVERSIONS); \
+	fi)
 endef
=20
 $(SNDVERSIONS):

--vtzGhvizbBRQ85DL
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <steven@slinky.int.wedontsleep.org>
X-Original-To: jordi@localhost
Delivered-To: jordi@localhost
Received: from localhost (localhost [127.0.0.1])
	by nubol.int.oskuro.net (Postfix) with ESMTP id C749170A741
	for <jordi@localhost>; Sat, 12 Apr 2003 17:56:55 +0200 (CEST)
Delivered-To: jordi@sindominio.net
Received: from fanelli.sindominio.net [213.172.36.134]
	by localhost with POP3 (fetchmail-6.1.2)
	for jordi@localhost (single-drop); Sat, 12 Apr 2003 17:56:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by fanelli.sindominio.net (Postfix) with ESMTP id 427028F9CD
	for <jordi@sindominio.net>; Sat, 12 Apr 2003 17:51:00 +0200 (CEST)
Received: from master.debian.org (master.debian.org [65.125.64.135])
	by fanelli.sindominio.net (Postfix) with ESMTP id 0E1A68F73C
	for <jordi@sindominio.net>; Sat, 12 Apr 2003 17:50:58 +0200 (CEST)
Received: from grunt21.ihug.com.au [203.109.249.141]
	by master.debian.org with esmtp (Exim 3.12 1 (Debian))
	id 194NIO-0008Tk-00; Sat, 12 Apr 2003 10:52:00 -0500
Received: from synergy.wedontsleep.org [203.109.141.128]
	by grunt21.ihug.com.au with esmtp (Exim 3.35 #1 (Debian))
	id 194NIM-0004o9-00; Sun, 13 Apr 2003 01:51:58 +1000
Received: from slinky.int.wedontsleep.org ([192.168.66.1])
	by synergy.wedontsleep.org with esmtp (Exim 3.35 #1 (Debian))
	id 194NIM-0000Cr-00
	for <jordi@debian.org>; Sun, 13 Apr 2003 01:51:58 +1000
Received: from broken (broken.int.wedontsleep.org [192.168.66.2])
	by slinky.int.wedontsleep.org (Postfix) with ESMTP id 1DAE67F93
	for <jordi@debian.org>; Sun, 13 Apr 2003 01:51:57 +1000 (EST)
Received: from steven by broken with local (Exim 3.36 #1 (Debian))
	id 194NIK-0008Aq-00
	for <jordi@debian.org>; Sun, 13 Apr 2003 01:51:56 +1000
Date: Sun, 13 Apr 2003 01:51:56 +1000
From: Steve Kowalik <steven@wedontsleep.org>
To: Jordi Mallach <jordi@debian.org>
Subject: Oops
Message-ID: <20030412155156.GA31379@broken>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux broken 2.4.20-1-k7-smp i686
X-Subliminal-Message: Debian Rocks!
X-Cabal: There is no cabal.
User-Agent: Mutt/1.5.4i
Sender: Steve Kowalik <steven@broken.int.wedontsleep.org>
X-Virus-Scanned: by AMaViS new-20020517
X-Razor-id: cf5606b07b1bf8c3784467f8dc585e90468a4b6e
X-Spam-Status: No, hits=-12.9 required=5.0
	tests=BAYES_01,USER_AGENT_MUTT
	autolearn=ham version=2.53
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.53 (1.174.2.15-2003-03-30-exp)

steven@broken:~$ ksymoops -k ./ksyms -l ./modules-2.4.20-1-k7-smp -o
/lib/modules/2.4.20-1-k7-smp -m /boot/System.map-2.4.20-1-k7-smp 
ksymoops 2.4.8 on i686 2.4.20-1-k7-smp.  Options used
     -V (default)
     -k ./ksyms (specified)
     -l ./modules-2.4.20-1-k7-smp (specified)
     -o /lib/modules/2.4.20-1-k7-smp (specified)
     -m /boot/System.map-2.4.20-1-k7-smp (specified)

Warning (expand_objects): object
/lib/modules/2.4.20-1-k7-smp/kernel/fs/ext3/ext
3.o for module ext3 has changed since load
Warning (expand_objects): object
/lib/modules/2.4.20-1-k7-smp/kernel/fs/jbd/jbd.
o for module jbd has changed since load
Warning (expand_objects): object
/lib/modules/2.4.20-1-k7-smp/kernel/drivers/ide
/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object
/lib/modules/2.4.20-1-k7-smp/kernel/drivers/ide
/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object
/lib/modules/2.4.20-1-k7-smp/kernel/drivers/ide
/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object
/lib/modules/2.4.20-1-k7-smp/kernel/net/unix/un
ix.o for module unix has changed since load
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 67150277
 printing eip:
c0167323
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0167323>]    Tainted: P 
EFLAGS: 00010216
eax: 67150277   ebx: de269340   ecx: d982b840   edx: e09c5fd0
esi: 00000004   edi: 00000000   ebp: d982b800   esp: c35cdf10
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 31266, stackpage=c35cd000)
Stack: dd0b3400 e09c5144 de269340 00000003 e09c528c e09c5fd0 00000004
e09c5435 
       e09c5fd0 00000004 e09cd5b2 00000004 d1a71400 e0aa48c4 e09f7c00
bfffec08 
       e09cf884 e0a9fa8c 00000002 d1a71600 00000000 d1a71400 e0a9facb
d1a71400 
Call Trace:    [<e09c5144>] [<e09c528c>] [<e09c5fd0>] [<e09c5435>]
[<e09c5fd0>]
  [<e09cd5b2>] [<e0aa48c4>] [<e09f7c00>] [<e09cf884>] [<e0a9fa8c>]
[<e0a9facb>]
  [<e09ea52d>] [<e0a9fbac>] [<e0aa48c4>] [<c011cff7>] [<c011c29f>]
[<c0108b97>]

Code: f0 81 28 00 00 00 01 0f 85 39 25 00 00 53 8b 43 20 50 e8 36 
Unable to handle kernel paging request at virtual address 67150277
c0167323
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0167323>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: 67150277   ebx: de269340   ecx: d982b840   edx: e09c5fd0
esi: 00000004   edi: 00000000   ebp: d982b800   esp: c35cdf10
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 31266, stackpage=c35cd000)
Stack: dd0b3400 e09c5144 de269340 00000003 e09c528c e09c5fd0 00000004
e09c5435 
       e09c5fd0 00000004 e09cd5b2 00000004 d1a71400 e0aa48c4 e09f7c00
bfffec08 
       e09cf884 e0a9fa8c 00000002 d1a71600 00000000 d1a71400 e0a9facb
d1a71400 
Call Trace:    [<e09c5144>] [<e09c528c>] [<e09c5fd0>] [<e09c5435>]
[<e09c5fd0>]
  [<e09cd5b2>] [<e0aa48c4>] [<e09f7c00>] [<e09cf884>] [<e0a9fa8c>]
[<e0a9facb>]
  [<e09ea52d>] [<e0a9fbac>] [<e0aa48c4>] [<c011cff7>] [<c011c29f>]
[<c0108b97>]
Code: f0 81 28 00 00 00 01 0f 85 39 25 00 00 53 8b 43 20 50 e8 36 


>>EIP; c0167323 <devfs_unregister+13/40>   <=====

>>ebx; de269340 <_end+1df7dbd0/205218f0>
>>ecx; d982b840 <_end+195400d0/205218f0>
>>edx; e09c5fd0 <[soundcore].data.end+49/20d9>
>>ebp; d982b800 <_end+19540090/205218f0>
>>esp; c35cdf10 <_end+32e27a0/205218f0>

Trace; e09c5144 <[soundcore]__sound_remove_unit+24/60>
Trace; e09c528c <[soundcore]sound_remove_unit+1c/30>
Trace; e09c5fd0 <[soundcore].data.end+49/20d9>
Trace; e09c5435 <[soundcore]unregister_sound_special+15/20>
Trace; e09c5fd0 <[soundcore].data.end+49/20d9>
Trace; e09cd5b2 <[snd]snd_unregister_oss_device+d2/110>
Trace; e0aa48c4 <[snd-pcm-oss]snd_pcm_oss_notify+0/14>
Trace; e09f7c00 <[snd-pcm]snd_pcm_devices+0/1460>
Trace; e09cf884 <[snd]sound_oss_mutex+0/14>
Trace; e0a9fa8c <[snd-pcm-oss]snd_pcm_oss_disconnect_minor+2c/60>
Trace; e0a9facb <[snd-pcm-oss]snd_pcm_oss_unregister_minor+b/50>
Trace; e09ea52d <[snd-pcm]snd_pcm_notify+4d/b0>
Trace; e0a9fbac <[snd-pcm-oss]alsa_pcm_oss_exit+c/10>
Trace; e0aa48c4 <[snd-pcm-oss]snd_pcm_oss_notify+0/14>
Trace; c011cff7 <free_module+17/b0>
Trace; c011c29f <sys_delete_module+11f/240>
Trace; c0108b97 <system_call+33/38>

Code;  c0167323 <devfs_unregister+13/40>
00000000 <_EIP>:
Code;  c0167323 <devfs_unregister+13/40>   <=====
   0:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)   <=====
Code;  c016732a <devfs_unregister+1a/40>
   7:   0f 85 39 25 00 00         jne    2546 <_EIP+0x2546>
Code;  c0167330 <devfs_unregister+20/40>
   d:   53                        push   %ebx
Code;  c0167331 <devfs_unregister+21/40>
   e:   8b 43 20                  mov    0x20(%ebx),%eax
Code;  c0167334 <devfs_unregister+24/40>
  11:   50                        push   %eax
Code;  c0167335 <devfs_unregister+25/40>
  12:   e8 36 00 00 00            call   4d <_EIP+0x4d>

This looks to be a bug in the depths of devfs, but I don't know.

-- 
                                           Steve
* vorlon installs ntop to look at the copyright file, and finds that he
          can't purge it because of a broken maintainer script. Heh.
<luca> vorlon: this is your punishment for questioning the Luca

--vtzGhvizbBRQ85DL--

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mDrFJYSUupF6Il4RAsmMAJ9cRPhS+vV4aRFUmRLZBWO3Bpr1uQCg586P
HAVM1qsfg11AZNaDJV93eDI=
=mxY7
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
