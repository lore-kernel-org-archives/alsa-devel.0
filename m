From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - [hdspmixer] 1/1] hdspmixer: Don't use
	channelmap from hdspm.h
Date: Thu, 27 Jan 2011 11:41:47 +0100
Message-ID: <1296124907-7995-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The channel mapping has been moved to hdspm.c, so it's no longer
available to userspace tools. For now, let's simply copy (duplicate) the
data and wait for a way to query this information from the driver.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.h
index 9303d21..cfb2402 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -28,6 +28,7 @@
 #include <alsa/sound/hdsp.h>
 #include <alsa/sound/hdspm.h>
 #include "defines.h"
+#include "channelmap.h"
 #include "HDSPMixerWindow.h"
 
 class HDSPMixerWindow;
diff --git a/hdspmixer/src/channelmap.h b/hdspmixer/src/channelmap.h
new file mode 100644
index 0000000..de89140
--- /dev/null
+++ b/hdspmixer/src/channelmap.h
@@ -0,0 +1,167 @@
+#ifndef channelmap_H
+#define channelmap_H
+
+static char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
+	0, 1, 2, 3, 4, 5, 6, 7,
+	8, 9, 10, 11, 12, 13, 14, 15,
+	16, 17, 18, 19, 20, 21, 22, 23,
+	24, 25, 26, 27, 28, 29, 30, 31,
+	32, 33, 34, 35, 36, 37, 38, 39,
+	40, 41, 42, 43, 44, 45, 46, 47,
+	48, 49, 50, 51, 52, 53, 54, 55,
+	56, 57, 58, 59, 60, 61, 62, 63
+};
+
+static char channel_map_unity_ds[HDSPM_MAX_CHANNELS] = {
+	0, 2, 4, 6, 8, 10, 12, 14,
+	16, 18, 20, 22, 24, 26, 28, 30,
+	32, 34, 36, 38, 40, 42, 44, 46,
+	48, 50, 52, 54, 56, 58, 60, 62,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_unity_qs[HDSPM_MAX_CHANNELS] = {
+	0, 4, 8, 12, 16, 20, 24, 28,
+	32, 36, 40, 44, 48, 52, 56, 60,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_ss[HDSPM_MAX_CHANNELS] = {
+	4, 5, 6, 7, 8, 9, 10, 11,	/* ADAT 1 */
+	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT 2 */
+	20, 21, 22, 23, 24, 25, 26, 27,	/* ADAT 3 */
+	28, 29, 30, 31, 32, 33, 34, 35,	/* ADAT 4 */
+	0, 1,			/* AES */
+	2, 3,			/* SPDIF */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_ds[HDSPM_MAX_CHANNELS] = {
+	4, 5, 6, 7,		/* ADAT 1 */
+	8, 9, 10, 11,		/* ADAT 2 */
+	12, 13, 14, 15,		/* ADAT 3 */
+	16, 17, 18, 19,		/* ADAT 4 */
+	0, 1,			/* AES */
+	2, 3,			/* SPDIF */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
+	4, 5,			/* ADAT 1 */
+	6, 7,			/* ADAT 2 */
+	8, 9,			/* ADAT 3 */
+	10, 11,			/* ADAT 4 */
+	0, 1,			/* AES */
+	2, 3,			/* SPDIF */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line in */
+	8, 9,			/* aes in, */
+	10, 11,			/* spdif in */
+	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
+	-1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
+	6, 7,			/* phone out */
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line in */
+	8, 9,			/* aes in */
+	10, 11,			/* spdif in */
+	12, 14, 16, 18,		/* adat in */
+	-1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 14, 16, 18,		/* adat out */
+	6, 7,			/* phone out */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line in */
+	8, 9,			/* aes in */
+	10, 11,			/* spdif in */
+	12, 16,			/* adat in */
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 16,			/* adat out */
+	6, 7,			/* phone out */
+	-1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+#endif /* channelmap_H */
-- 
1.7.2.3
