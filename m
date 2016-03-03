From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 1/5] Introduce bswap.h for portable definitions
	of byte swap macros.
Date: Thu,  3 Mar 2016 15:08:00 +0100
Message-ID: <1457014084-27694-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-3.mx.upcmail.net
 (vie01a-dmta-pe04-3.mx.upcmail.net [62.179.121.165])
 by alsa0.perex.cz (Postfix) with ESMTP id EF99B2606CF
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 15:08:50 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1abTvu-0006Kl-KL
 for alsa-devel@alsa-project.org; Thu, 03 Mar 2016 15:08:50 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

Signed-off-by: Thomas Klausner <wiz@NetBSD.org>
---
 include/Makefile.am        |  2 +-
 include/bswap.h            | 39 +++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_adpcm.c        |  2 +-
 src/pcm/pcm_alaw.c         |  2 +-
 src/pcm/pcm_copy.c         |  2 +-
 src/pcm/pcm_dmix_generic.c |  2 +-
 src/pcm/pcm_file.c         |  2 +-
 src/pcm/pcm_iec958.c       |  2 +-
 src/pcm/pcm_lfloat.c       |  2 +-
 src/pcm/pcm_linear.c       |  2 +-
 src/pcm/pcm_meter.c        |  2 +-
 src/pcm/pcm_misc.c         |  2 +-
 src/pcm/pcm_mulaw.c        |  2 +-
 src/pcm/pcm_null.c         |  2 +-
 src/pcm/pcm_rate.c         |  2 +-
 src/pcm/pcm_rate_linear.c  |  2 +-
 src/pcm/pcm_route.c        |  2 +-
 src/pcm/pcm_softvol.c      |  2 +-
 18 files changed, 56 insertions(+), 17 deletions(-)
 create mode 100644 include/bswap.h

diff --git a/include/Makefile.am b/include/Makefile.am
index 8c83c11..31a3f74 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -59,7 +59,7 @@ alsainclude_HEADERS += alisp.h
 endif
 
 noinst_HEADERS = alsa sys.h search.h list.h aserver.h local.h alsa-symbols.h \
-	asoundlib-head.h asoundlib-tail.h type_compat.h
+	asoundlib-head.h asoundlib-tail.h bswap.h type_compat.h
 
 DISTCLEANFILES = stamp-vh version.h alsa asoundlib.h
 
diff --git a/include/bswap.h b/include/bswap.h
new file mode 100644
index 0000000..68adce3
--- /dev/null
+++ b/include/bswap.h
@@ -0,0 +1,39 @@
+/*
+ *  ALSA lib - compatibility header for providing byte swapping macros
+ *  Copyright (c) 2016 by  Thomas Klausner <wiz@NetBSD.org>
+ *
+ *
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __BSWAP_H
+#define __BSWAP_H
+
+#if defined(__FreeBSD__) || defined(__DragonFly__) || defined(__NetBSD__)
+#include <sys/endian.h>
+#define bswap_16 bswap16
+#define bswap_32 bswap32
+#define bswap_64 bswap64
+#elif defined (__sun)
+#include <sys/byteorder.h>
+#define bswap_16 BSWAP_16
+#define bswap_32 BSWAP_32
+#define bswap_64 BSWAP_64
+#else
+#include <byteswap.h>
+#endif
+
+#endif
diff --git a/src/pcm/pcm_adpcm.c b/src/pcm/pcm_adpcm.c
index 1a83c5a..1c88c83 100644
--- a/src/pcm/pcm_adpcm.c
+++ b/src/pcm/pcm_adpcm.c
@@ -56,7 +56,7 @@ IMA compatibility project proceedings, Vol 2, Issue 2, May 1992.
   come across a good description of XA yet.
  */
 
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_alaw.c b/src/pcm/pcm_alaw.c
index db759e3..fa58441 100644
--- a/src/pcm/pcm_alaw.c
+++ b/src/pcm/pcm_alaw.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_copy.c b/src/pcm/pcm_copy.c
index 66d3a47..0dbd5bd 100644
--- a/src/pcm/pcm_copy.c
+++ b/src/pcm/pcm_copy.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_dmix_generic.c b/src/pcm/pcm_dmix_generic.c
index 9e9d3c3..40c0874 100644
--- a/src/pcm/pcm_dmix_generic.c
+++ b/src/pcm/pcm_dmix_generic.c
@@ -125,7 +125,7 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 	 (1ULL << SND_PCM_FORMAT_S24_LE) | (1ULL << SND_PCM_FORMAT_S24_3LE) | \
 	 (1ULL << SND_PCM_FORMAT_U8))
 
-#include <byteswap.h>
+#include "bswap.h"
 
 static void generic_mix_areas_16_native(unsigned int size,
 					volatile signed short *dst,
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 9ab6964..92eb072 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include <ctype.h>
 #include <string.h>
 #include "pcm_local.h"
diff --git a/src/pcm/pcm_iec958.c b/src/pcm/pcm_iec958.c
index 38c4ce7..86ac9cf 100644
--- a/src/pcm/pcm_iec958.c
+++ b/src/pcm/pcm_iec958.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_lfloat.c b/src/pcm/pcm_lfloat.c
index 2f3e578..22201f8 100644
--- a/src/pcm/pcm_lfloat.c
+++ b/src/pcm/pcm_lfloat.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
index 9a92abd..50df779 100644
--- a/src/pcm/pcm_linear.c
+++ b/src/pcm/pcm_linear.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index 034f582..1b0ccb4 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -27,7 +27,7 @@
  */
   
 
-#include <byteswap.h>
+#include "bswap.h"
 #include <time.h>
 #include <pthread.h>
 #include <dlfcn.h>
diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index 5870f82..7d2b05d 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -23,7 +23,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 
 
diff --git a/src/pcm/pcm_mulaw.c b/src/pcm/pcm_mulaw.c
index 011b2a5..15dbdc1 100644
--- a/src/pcm/pcm_mulaw.c
+++ b/src/pcm/pcm_mulaw.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index 5e63caa..685618e 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include <limits.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index c76db25..41bddac 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -28,7 +28,7 @@
  *
  */
 #include <inttypes.h>
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 #include "pcm_rate.h"
diff --git a/src/pcm/pcm_rate_linear.c b/src/pcm/pcm_rate_linear.c
index 7481b38..70399e0 100644
--- a/src/pcm/pcm_rate_linear.c
+++ b/src/pcm/pcm_rate_linear.c
@@ -21,7 +21,7 @@
  */
 
 #include <inttypes.h>
-#include <byteswap.h>
+#include "bswap.h"
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 #include "pcm_rate.h"
diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 646517d..3611603 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -26,7 +26,7 @@
  *
  */
   
-#include <byteswap.h>
+#include "bswap.h"
 #include <math.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index c6cfd88..802aa4b 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -26,7 +26,7 @@
  *
  */
 
-#include <byteswap.h>
+#include "bswap.h"
 #include <math.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
-- 
2.7.1
