From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 2/4] alsa: multisound.sh: fix script to make it
	build with modern tools
Date: Tue, 26 Jun 2018 06:24:38 -0300
Message-ID: <23ff79af9b3a8bf1f1a5a19508b735fc620c0a13.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com (osg.samsung.com [64.30.133.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E0A2267875
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:24:48 +0200 (CEST)
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

The script is old and produce some warnings and errors, because
it lacks including stdlib.h and io.h is at sys/io.h.

Fix it to run with the tools found on modern Linux distros.

Tested building it on Fedora 28.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sound/cards/multisound.sh | 30 +++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/sound/cards/multisound.sh b/Documentation/sound/cards/multisound.sh
index 7a7a88256dfd..0e0cb029421b 100755
--- a/Documentation/sound/cards/multisound.sh
+++ b/Documentation/sound/cards/multisound.sh
@@ -381,11 +381,11 @@
 # This shar contains:
 # length mode       name
 # ------ ---------- ------------------------------------------
-#   2046 -rw-rw-r-- MultiSound.d/setdigital.c
-#  10235 -rw-rw-r-- MultiSound.d/pinnaclecfg.c
+#   2064 -rw-rw-r-- MultiSound.d/setdigital.c
+#  10224 -rw-rw-r-- MultiSound.d/pinnaclecfg.c
 #    106 -rw-rw-r-- MultiSound.d/Makefile
-#    141 -rw-rw-r-- MultiSound.d/conv.l
-#   1472 -rw-rw-r-- MultiSound.d/msndreset.c
+#    146 -rw-rw-r-- MultiSound.d/conv.l
+#   1491 -rw-rw-r-- MultiSound.d/msndreset.c
 #
 save_IFS="${IFS}"
 IFS="${IFS}:"
@@ -471,6 +471,7 @@ X *
 X ********************************************************************/
 X
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -538,8 +539,8 @@ e87217fc3e71288102ba41fd81f71ec4  MultiSound.d/setdigital.c
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/setdigital.c'`"
-    test 2046 -eq "$shar_count" ||
-    $echo 'MultiSound.d/setdigital.c:' 'original size' '2046,' 'current size' "$shar_count!"
+    test 2064 -eq "$shar_count" ||
+    $echo 'MultiSound.d/setdigital.c:' 'original size' '2064,' 'current size' "$shar_count!"
   fi
 fi
 # ============= MultiSound.d/pinnaclecfg.c ==============
@@ -581,8 +582,8 @@ X
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
-#include <asm/io.h>
 #include <asm/types.h>
+#include <sys/io.h>
 X
 #define IREG_LOGDEVICE		0x07
 #define IREG_ACTIVATE		0x30
@@ -992,8 +993,8 @@ SHAR_EOF
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/pinnaclecfg.c'`"
-    test 10235 -eq "$shar_count" ||
-    $echo 'MultiSound.d/pinnaclecfg.c:' 'original size' '10235,' 'current size' "$shar_count!"
+    test 10224 -eq "$shar_count" ||
+    $echo 'MultiSound.d/pinnaclecfg.c:' 'original size' '10224,' 'current size' "$shar_count!"
   fi
 fi
 # ============= MultiSound.d/Makefile ==============
@@ -1039,7 +1040,7 @@ DB
 [0-9A-Fa-f]+H	{ int n; sscanf(yytext, "%xH", &n); printf("%c", n); }
 %%
 int yywrap() { return 1; }
-main() { yylex(); }
+void main() { yylex(); }
 SHAR_EOF
   $shar_touch -am 0828231798 'MultiSound.d/conv.l' &&
   chmod 0664 'MultiSound.d/conv.l' ||
@@ -1052,8 +1053,8 @@ d2411fc32cd71a00dcdc1f009e858dd2  MultiSound.d/conv.l
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/conv.l'`"
-    test 141 -eq "$shar_count" ||
-    $echo 'MultiSound.d/conv.l:' 'original size' '141,' 'current size' "$shar_count!"
+    test 146 -eq "$shar_count" ||
+    $echo 'MultiSound.d/conv.l:' 'original size' '146,' 'current size' "$shar_count!"
   fi
 fi
 # ============= MultiSound.d/msndreset.c ==============
@@ -1085,6 +1086,7 @@ X *
 X ********************************************************************/
 X
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -1129,8 +1131,8 @@ c52f876521084e8eb25e12e01dcccb8a  MultiSound.d/msndreset.c
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/msndreset.c'`"
-    test 1472 -eq "$shar_count" ||
-    $echo 'MultiSound.d/msndreset.c:' 'original size' '1472,' 'current size' "$shar_count!"
+    test 1491 -eq "$shar_count" ||
+    $echo 'MultiSound.d/msndreset.c:' 'original size' '1491,' 'current size' "$shar_count!"
   fi
 fi
 rm -fr _sh01426
-- 
2.17.1
