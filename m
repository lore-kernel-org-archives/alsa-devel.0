From: earl <earl@stanfordalumni.org>
Subject: Patch for alsa-lib build failure with kernel 2.6.9 headers
Date: Tue, 28 Dec 2004 21:13:47 -0800
Message-ID: <41D23D0B.9010808@stanfordalumni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

When building alsa-lib 1.0.7 against the headers from the 2.6.9 kernel i 
get errors like below.  At the bottom is a patch that works around the 
problem.

gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT 
fm.lo -MD -MP -MF .deps/fm.Tpo -c fm.c  -fPIC -DPIC -o .libs/fm.o
In file included from linux/include/asm/byteorder.h:57,
                 from fm.c:33:
linux/include/linux/byteorder/little_endian.h:43: error: parse error 
before "__cpu_to_le64p"
linux/include/linux/byteorder/little_endian.h: In function `__cpu_to_le64p':
linux/include/linux/byteorder/little_endian.h:45: error: `__le64' 
undeclared (first use in this function)
linux/include/linux/byteorder/little_endian.h:45: error: (Each 
undeclared identifier is reported only once
linux/include/linux/byteorder/little_endian.h:45: error: for each 
function it appears in.)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:47: error: parse error 
before '*' token
linux/include/linux/byteorder/little_endian.h: In function `__le64_to_cpup':
linux/include/linux/byteorder/little_endian.h:49: error: `p' undeclared 
(first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:51: error: parse error 
before "__cpu_to_le32p"
linux/include/linux/byteorder/little_endian.h: In function `__cpu_to_le32p':
linux/include/linux/byteorder/little_endian.h:53: error: `__le32' 
undeclared (first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:55: error: parse error 
before '*' token
linux/include/linux/byteorder/little_endian.h: In function `__le32_to_cpup':
linux/include/linux/byteorder/little_endian.h:57: error: `p' undeclared 
(first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:59: error: parse error 
before "__cpu_to_le16p"
linux/include/linux/byteorder/little_endian.h: In function `__cpu_to_le16p':
linux/include/linux/byteorder/little_endian.h:61: error: `__le16' 
undeclared (first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:63: error: parse error 
before '*' token
linux/include/linux/byteorder/little_endian.h: In function `__le16_to_cpup':
linux/include/linux/byteorder/little_endian.h:65: error: `p' undeclared 
(first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:67: error: parse error 
before "__cpu_to_be64p"
linux/include/linux/byteorder/little_endian.h: In function `__cpu_to_be64p':
linux/include/linux/byteorder/little_endian.h:69: error: `__be64' 
undeclared (first use in this function)
linux/include/linux/byteorder/little_endian.h:69: error: parse error 
before "__swab64p"
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:71: error: parse error 
before '*' token
linux/include/linux/byteorder/little_endian.h: In function `__be64_to_cpup':
linux/include/linux/byteorder/little_endian.h:73: error: `p' undeclared 
(first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:75: error: parse error 
before "__cpu_to_be32p"
linux/include/linux/byteorder/little_endian.h: In function `__cpu_to_be32p':
linux/include/linux/byteorder/little_endian.h:77: error: `__be32' 
undeclared (first use in this function)
linux/include/linux/byteorder/little_endian.h:77: error: parse error 
before "__swab32p"
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:79: error: parse error 
before '*' token
linux/include/linux/byteorder/little_endian.h: In function `__be32_to_cpup':
linux/include/linux/byteorder/little_endian.h:81: error: `p' undeclared 
(first use in this function)
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:83: error: parse error 
before "__cpu_to_be16p"
linux/include/linux/byteorder/little_endian.h: In function `__cpu_to_be16p':
linux/include/linux/byteorder/little_endian.h:85: error: `__be16' 
undeclared (first use in this function)
linux/include/linux/byteorder/little_endian.h:85: error: parse error 
before "__swab16p"
linux/include/linux/byteorder/little_endian.h: At top level:
linux/include/linux/byteorder/little_endian.h:87: error: parse error 
before '*' token
linux/include/linux/byteorder/little_endian.h: In function `__be16_to_cpup':
linux/include/linux/byteorder/little_endian.h:89: error: `p' undeclared 
(first use in this function)
fm.c: In function `snd_instr_fm_convert_to_stream':
fm.c:81: error: `__be32' undeclared (first use in this function)
fm.c:81: error: parse error before '{' token
fm.c:81: error: parse error before ')' token
fm.c:81: error: `__x' undeclared (first use in this function)
fm.c: At top level:
fm.c:81: error: parse error before ')' token
fm.c:106: error: `put' undeclared here (not in a function)
fm.c:106: warning: data definition has no type or storage class
fm.c:107: warning: initialization makes pointer from integer without a cast
fm.c:107: warning: data definition has no type or storage class
fm.c:108: error: parse error before "return"
make[3]: *** [fm.lo] Error 1
make[3]: Leaving directory `src/instr'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `src'
make[1]: *** [all-recursive] Error 1


Here's the patch:

_____________________________________________________________________________________________________________

Earl Levine 2004 December 28
This patch is like the one here
http://twomix.devolution.com/pipermail/sdl/2004-November/065818.html
which says, quote:

there is a bug that was introduced in the kernel headers for 2.6.9
which is fixed in 2.6.10. This bug *will* byte when compiling the cdrom
subsystem. A patch that works around this bug is attached. Note that
users affected are not those running 2.6.9, but those using the 2.6.9
kernel headers for their system (i.e. whose libc is built against 2.6.9
headers).

diff -Naur alsa-lib-1.0.7-orig/src/instr/fm.c alsa-lib-1.0.7/src/instr/fm.c
--- alsa-lib-1.0.7-orig/src/instr/fm.c    2002-02-04 03:18:40.000000000 
-0800
+++ alsa-lib-1.0.7/src/instr/fm.c    2004-12-28 20:38:41.000000000 -0800
@@ -30,6 +30,17 @@
 #include <sys/stat.h>
 #include <stdio.h>
 #include "local.h"
+/* linux 2.6.9 workaround */
+#include <linux/version.h>
+#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,9)
+#include <asm/types.h>
+#define __le64 __u64
+#define __le32 __u32
+#define __le16 __u16
+#define __be64 __u64
+#define __be32 __u32
+#define __be16 __u16
+#endif /* linux 2.6.9 workaround */
 #include <asm/byteorder.h>
 #include <sound/ainstr_fm.h>
 
diff -Naur alsa-lib-1.0.7-orig/src/instr/iwffff.c 
alsa-lib-1.0.7/src/instr/iwffff.c
--- alsa-lib-1.0.7-orig/src/instr/iwffff.c    2004-04-20 
06:42:48.000000000 -0700
+++ alsa-lib-1.0.7/src/instr/iwffff.c    2004-12-28 20:39:04.000000000 -0800
@@ -31,6 +31,17 @@
 #include <sys/stat.h>
 #include <stdio.h>
 #include "local.h"
+/* linux 2.6.9 workaround */
+#include <linux/version.h>
+#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,9)
+#include <asm/types.h>
+#define __le64 __u64
+#define __le32 __u32
+#define __le16 __u16
+#define __be64 __u64
+#define __be32 __u32
+#define __be16 __u16
+#endif /* linux 2.6.9 workaround */
 #include <sound/ainstr_iw.h>
 
 /*
diff -Naur alsa-lib-1.0.7-orig/src/instr/simple.c 
alsa-lib-1.0.7/src/instr/simple.c
--- alsa-lib-1.0.7-orig/src/instr/simple.c    2002-02-04 
03:18:40.000000000 -0800
+++ alsa-lib-1.0.7/src/instr/simple.c    2004-12-28 20:38:52.000000000 -0800
@@ -31,6 +31,17 @@
 #include <sys/stat.h>
 #include <stdio.h>
 #include "local.h"
+/* linux 2.6.9 workaround */
+#include <linux/version.h>
+#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,9)
+#include <asm/types.h>
+#define __le64 __u64
+#define __le32 __u32
+#define __le16 __u16
+#define __be64 __u64
+#define __be32 __u32
+#define __be16 __u16
+#endif /* linux 2.6.9 workaround */
 #include <asm/byteorder.h>
 #include <sound/ainstr_simple.h>
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
