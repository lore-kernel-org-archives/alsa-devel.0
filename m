From: Kristof vansant <de_lupus@pandora.be>
Subject: Can someone test my patch: without it alsa wouldn't build on
 kernel 2.6.1
Date: Wed, 11 Feb 2004 17:10:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076515853.10073.8.camel@D5E03F95.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-sgXn2XVPrdP7p055kr8H"
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


--=-sgXn2XVPrdP7p055kr8H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Warning I'm running kernel 2.6.1 from redhat so not vanilla. I don't
know for sure if the problem is with kernel 2.6.1 vanilla to.

After the patch it compiles normal :)

error:

make -C /lib/modules/2.6.1-1.65/build SUBDIRS=/home/lupus/alsa-driver-
1.0.2c/kbuild modules
make[1]: Entering directory `/lib/modules/2.6.1-1.65/build'
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
  CHK     include/asm-i386/asm_offsets.h
  CC [M]  /home/lupus/alsa-driver-1.0.2c/kbuild/../acore/memalloc.o
In file included from /home/lupus/alsa-driver-1.0.2c/acore/memalloc.
inc:13,
                 from /home/lupus/alsa-driver-1.0.2c/acore/memalloc.c:1:
/home/lupus/alsa-driver-1.0.2c/include/adriver.h:425: error: conflicting
types for `class_simple_device_add'
include/linux/device.h:255: error: previous declaration of
`class_simple_device_add'
/home/lupus/alsa-driver-1.0.2c/include/adriver.h:426: error: conflicting
types for `class_simple_device_remove'
include/linux/device.h:256: error: previous declaration of
`class_simple_device_remove'
make[3]: *** [/home/lupus/alsa-driver-1.0.2c/kbuild/../acore/memalloc.o]
Fout 1
make[2]: *** [/home/lupus/alsa-driver-1.0.2c/kbuild/../acore] Fout 2
make[1]: *** [/home/lupus/alsa-driver-1.0.2c/kbuild] Fout 2
make[1]: Leaving directory `/lib/modules/2.6.1-1.65/build'
make: *** [compile] Fout 2


--=-sgXn2XVPrdP7p055kr8H
Content-Disposition: attachment; filename=kernel261.patch
Content-Type: text/x-diff; name=kernel261.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ./include/adriver.h.kernel261	2004-02-11 16:57:13.708662312 +0100
+++ ./include/adriver.h	2004-02-11 16:57:25.869813536 +0100
@@ -420,7 +420,7 @@
 #endif
 
 /* sysfs */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 2)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1)
 struct class_simple;
 static inline void class_simple_device_add(struct class_simple *class, int devnum, ...) { return; }
 static inline void class_simple_device_remove(int devnum) { return; }

--=-sgXn2XVPrdP7p055kr8H--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
