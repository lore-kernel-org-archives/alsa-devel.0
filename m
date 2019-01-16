From: makepost@firemail.cc
Subject: [PATCH] alsamixer: define _GNU_SOURCE to get exp10
Date: Wed, 16 Jan 2019 03:35:33 +0200
Message-ID: <a4d4f393cbf2c09fee38e9144429690c@firemail.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fixes Master, Headphones and Speaker stuck at -8 percentage after
building with Clang 7.0.1 and getting warned about implicit declaration
of exp10, which is behind _GNU_SOURCE as a non-standard feature. Thanks
Takashi Iwai for the CFLAGS suggestion on the mailing list. GCC build is
not affected, so not adding a compiler check to the configure script.

uClibc-ng has got exp10 since 1.0.12, so the fallback macro is no longer
needed. However, alsa-utils relies on gettext so might need further
patches to actually work on uClibc systems.

Signed-off-by: makepost <makepost@firemail.cc>

diff --git a/alsamixer/volume_mapping.c b/alsamixer/volume_mapping.c
index 94bd0fe..48cfbe2 100644
--- a/alsamixer/volume_mapping.c
+++ b/alsamixer/volume_mapping.c
@@ -36,11 +36,6 @@
  #include <stdbool.h>
  #include "volume_mapping.h"

-#ifdef __UCLIBC__
-/* 10^x = 10^(log e^x) = (e^x)^log10 = e^(x * log 10) */
-#define exp10(x) (exp((x) * log(10)))
-#endif /* __UCLIBC__ */
-
  #define MAX_LINEAR_DB_SCALE    24

  static inline bool use_linear_dB_scale(long dBmin, long dBmax)
diff --git a/configure.ac b/configure.ac
index 7938996..0d54942 100644
--- a/configure.ac
+++ b/configure.ac
@@ -350,6 +350,8 @@ if test x$alsamixer = xtrue; then


    AC_MSG_RESULT([$CURSESLIB])
+
+  CFLAGS="$CFLAGS -D_GNU_SOURCE"


  AC_SUBST(CURSESINC)
-- 
2.20.1
