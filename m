From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (hda-emu)] Adapt to new
	snd_hda_calc_stream_format
Date: Tue,  1 Jul 2014 07:55:38 +0200
Message-ID: <1404194138-6899-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E7518264F1E
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 07:55:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 configure.ac | 23 +++++++++++++++++++++++
 hda-emu.c    |  6 +++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 31b31cd..fe5c0e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -488,6 +488,29 @@ if test "$STREAM_FORMAT_WITH_SPDIF" = "1"; then
 fi
 fi
 
+AC_MSG_CHECKING(for snd_hda_calc_stream_format with codec)
+ac_save_CFLAGS="$CFLAGS"
+CFLAGS="$CFLAGS -Iinclude"
+STREAM_FORMAT_WITH_CODEC=
+AC_TRY_COMPILE([
+#include "hda-types.h"
+#include "hda-log.h"
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include "hda/hda_codec.h"
+],[
+  snd_hda_calc_stream_format(0, 0, 0, 0, 0, 0);
+],
+  [AC_MSG_RESULT(yes); STREAM_FORMAT_WITH_CODEC="1"],
+  [AC_MSG_RESULT(no)],
+  [AC_MSG_RESULT(unknown)]
+)
+CFLAGS=$ac_save_CFLAGS
+if test "$STREAM_FORMAT_WITH_CODEC" = "1"; then
+  AC_DEFINE(STREAM_FORMAT_WITH_CODEC)
+fi
+
 HAVE_COMMON_PREPARE=
 AC_MSG_CHECKING(for common snd_hda_codec_prepare/cleanup)
 if grep -q snd_hda_codec_prepare hda/hda_codec.h; then
diff --git a/hda-emu.c b/hda-emu.c
index b564e34..e8309d5 100644
--- a/hda-emu.c
+++ b/hda-emu.c
@@ -798,7 +798,11 @@ void hda_test_pcm(int id, int op, int subid,
 		hda_log(HDA_LOG_INFO, "Prepare PCM, rate=%d, channels=%d, "
 			"format=%d bits\n",
 			rate, channels, format);
-		format_val = snd_hda_calc_stream_format(rate, channels,
+		format_val = snd_hda_calc_stream_format(
+#if defined(STREAM_FORMAT_WITH_CODEC)
+							_codec,
+#endif
+							rate, channels,
 							get_alsa_format(format),
 							format
 #if defined(INDIVIDUAL_SPDIF_CTLS) || defined(STREAM_FORMAT_WITH_SPDIF)
-- 
1.9.1
