From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] pcm_ladspa: add support for softfloat
Date: Wed,  7 Jan 2009 05:06:50 -0500
Message-ID: <1231322810-5973-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 647661037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 11:06:56 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id CF37C6422D
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 10:06:50 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The ladspa module uses math functions unconditionally which breaks when
building with --with-softfloat.  Tweak the code to only call the math
functions when HAVE_SOFT_FLOAT is not defined.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 src/pcm/pcm_ladspa.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index 5161820..0e9321c 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -34,7 +34,9 @@
   
 #include <dirent.h>
 #include <locale.h>
+#ifndef HAVE_SOFT_FLOAT
 #include <math.h>
+#endif
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
@@ -511,36 +513,39 @@ static void snd_pcm_ladspa_get_default_cvalue(const LADSPA_Descriptor * desc, un
                 *val = desc->PortRangeHints[port].LowerBound;
                 break;
         case LADSPA_HINT_DEFAULT_LOW:
-                if (LADSPA_IS_HINT_LOGARITHMIC(hdesc)) {
+#ifndef HAVE_SOFT_FLOAT
+                if (LADSPA_IS_HINT_LOGARITHMIC(hdesc))
                         *val = exp(log(desc->PortRangeHints[port].LowerBound)
                                         * 0.75
                                         + log(desc->PortRangeHints[port].UpperBound)
                                         * 0.25);
-                } else {
+                else
+#endif
                         *val = (desc->PortRangeHints[port].LowerBound * 0.75) +
                                (desc->PortRangeHints[port].UpperBound * 0.25);
-                }
                 break;
         case LADSPA_HINT_DEFAULT_MIDDLE:
-                if (LADSPA_IS_HINT_LOGARITHMIC(hdesc)) {
+#ifndef HAVE_SOFT_FLOAT
+                if (LADSPA_IS_HINT_LOGARITHMIC(hdesc))
                         *val = sqrt(desc->PortRangeHints[port].LowerBound *
                                     desc->PortRangeHints[port].UpperBound);
-                } else {
+                else
+#endif
                         *val = 0.5 *
                                (desc->PortRangeHints[port].LowerBound +
                                 desc->PortRangeHints[port].UpperBound);
-                }
                 break;
         case LADSPA_HINT_DEFAULT_HIGH:
-                if (LADSPA_IS_HINT_LOGARITHMIC(hdesc)) {
+#ifndef HAVE_SOFT_FLOAT
+                if (LADSPA_IS_HINT_LOGARITHMIC(hdesc))
                         *val = exp(log(desc->PortRangeHints[port].LowerBound)
                                         * 0.25
                                         + log(desc->PortRangeHints[port].UpperBound)
                                         * 0.75);
-                } else {
+                else
+#endif
                         *val = (desc->PortRangeHints[port].LowerBound * 0.25) +
                                (desc->PortRangeHints[port].UpperBound * 0.75);
-                }
                 break;
         case LADSPA_HINT_DEFAULT_MAXIMUM:
                 *val = desc->PortRangeHints[port].UpperBound;
-- 
1.6.0.6
