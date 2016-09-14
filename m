From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: rename TLV-related macros so that
	they're friendly to user applications
Date: Thu, 15 Sep 2016 07:25:20 +0900
Message-ID: <1473891920-31214-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1473891920-31214-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DB7B526669C
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 00:25:28 +0200 (CEST)
In-Reply-To: <1473891920-31214-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

In a previous commit, some macros newly appeared to UAPI header for TLV
packet. These macros have short names and they easily bring name conflist
to applications. The conflict can be avoided to rename them with a proper
prefix.

For this purpose, this commit renames these macros with prefix
'SNDRV_CTL_TLVD_'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/tlv.h      | 26 ++++++++++++++++
 include/uapi/sound/tlv.h | 80 ++++++++++++++++++++++++++++--------------------
 2 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index 1f593b6..6e2e773 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -24,4 +24,30 @@
 
 #include <uapi/sound/tlv.h>
 
+/* For historical reasons, these macros are aliases to the ones in UAPI. */
+#define TLV_ITEM			SNDRV_CTL_TLVD_ITEM
+#define TLV_LENGTH			SNDRV_CTL_TLVD_LENGTH
+
+#define TLV_CONTAINER_ITEM		SNDRV_CTL_TLVD_CONTAINER_ITEM
+#define DECLARE_TLV_CONTAINER		SNDRV_CTL_TLVD_DECLARE_CONTAINER
+
+#define TLV_DB_SCALE_MASK		SNDRV_CTL_TLVD_DB_SCALE_MASK
+#define TLV_DB_SCALE_MUTE		SNDRV_CTL_TLVD_DB_SCALE_MUTE
+#define TLV_DB_SCALE_ITEM		SNDRV_CTL_TLVD_DB_SCALE_ITEM
+#define DECLARE_TLV_DB_SCALE		SNDRV_CTL_TLVD_DECLARE_DB_SCALE
+
+#define TLV_DB_MINMAX_ITEM		SNDRV_CTL_TLVD_DB_MINMAX_ITEM
+#define TLV_DB_MINMAX_MUTE_ITEM		SNDRV_CTL_TLVD_DB_MINMAX_MUTE_ITEM
+#define DECLARE_TLV_DB_MINMAX		SNDRV_CTL_TLVD_DECLARE_DB_MINMAX
+#define DECLARE_TLV_DB_MINMAX_MUTE	SNDRV_CTL_TLVD_DECLARE_DB_MINMAX_MUTE
+
+#define TLV_DB_LINEAR_ITEM		SNDRV_CTL_TLVD_DB_LINEAR_ITEM
+#define DECLARE_TLV_DB_LINEAR		SNDRV_CTL_TLVD_DECLARE_DB_LINEAR
+
+#define TLV_DB_RANGE_ITEM		SNDRV_CTL_TLVD_DB_RANGE_ITEM
+#define DECLARE_TLV_DB_RANGE		SNDRV_CTL_TLVD_DECLARE_DB_RANGE
+#define TLV_DB_RANGE_HEAD		SNDRV_CTL_TLVD_DB_RANGE_HEAD
+
+#define TLV_DB_GAIN_MUTE		SNDRV_CTL_TLVD_DB_GAIN_MUTE
+
 #endif /* __SOUND_TLV_H */
diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index b741e0e..f3c198f 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -36,41 +36,51 @@
  *        block_length = (length + (sizeof(unsigned int) - 1)) &
  *                       ~(sizeof(unsigned int) - 1)) ....
  */
-#define TLV_ITEM(type, ...) \
-	(type), TLV_LENGTH(__VA_ARGS__), __VA_ARGS__
-#define TLV_LENGTH(...) \
+#define SNDRV_CTL_TLVD_ITEM(type, ...) \
+	(type), SNDRV_CTL_TLVD_LENGTH(__VA_ARGS__), __VA_ARGS__
+#define SNDRV_CTL_TLVD_LENGTH(...) \
 	((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__ }))
 
-#define TLV_CONTAINER_ITEM(...) \
-	TLV_ITEM(SNDRV_CTL_TLVT_CONTAINER, __VA_ARGS__)
-#define DECLARE_TLV_CONTAINER(name, ...) \
-	unsigned int name[] = { TLV_CONTAINER_ITEM(__VA_ARGS__) }
+#define SNDRV_CTL_TLVD_CONTAINER_ITEM(...) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_CONTAINER, __VA_ARGS__)
+#define SNDRV_CTL_TLVD_DECLARE_CONTAINER(name, ...) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_CONTAINER_ITEM(__VA_ARGS__) \
+	}
 
-#define TLV_DB_SCALE_MASK	0xffff
-#define TLV_DB_SCALE_MUTE	0x10000
-#define TLV_DB_SCALE_ITEM(min, step, mute)			\
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_SCALE,			\
-		 (min),					\
-		 ((step) & TLV_DB_SCALE_MASK) |		\
-			((mute) ? TLV_DB_SCALE_MUTE : 0))
-#define DECLARE_TLV_DB_SCALE(name, min, step, mute) \
-	unsigned int name[] = { TLV_DB_SCALE_ITEM(min, step, mute) }
+#define SNDRV_CTL_TLVD_DB_SCALE_MASK	0xffff
+#define SNDRV_CTL_TLVD_DB_SCALE_MUTE	0x10000
+#define SNDRV_CTL_TLVD_DB_SCALE_ITEM(min, step, mute) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_SCALE, \
+			    (min), \
+			    ((step) & SNDRV_CTL_TLVD_DB_SCALE_MASK) | \
+			     ((mute) ? SNDRV_CTL_TLVD_DB_SCALE_MUTE : 0))
+#define SNDRV_CTL_TLVD_DECLARE_DB_SCALE(name, min, step, mute) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_SCALE_ITEM(min, step, mute) \
+	}
 
 /* dB scale specified with min/max values instead of step */
-#define TLV_DB_MINMAX_ITEM(min_dB, max_dB)			\
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_MINMAX, (min_dB), (max_dB))
-#define TLV_DB_MINMAX_MUTE_ITEM(min_dB, max_dB)			\
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_MINMAX_MUTE, (min_dB), (max_dB))
-#define DECLARE_TLV_DB_MINMAX(name, min_dB, max_dB) \
-	unsigned int name[] = { TLV_DB_MINMAX_ITEM(min_dB, max_dB) }
-#define DECLARE_TLV_DB_MINMAX_MUTE(name, min_dB, max_dB) \
-	unsigned int name[] = { TLV_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) }
+#define SNDRV_CTL_TLVD_DB_MINMAX_ITEM(min_dB, max_dB) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_MINMAX, (min_dB), (max_dB))
+#define SNDRV_CTL_TLVD_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_MINMAX_MUTE, (min_dB), (max_dB))
+#define SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(name, min_dB, max_dB) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_MINMAX_ITEM(min_dB, max_dB) \
+	}
+#define SNDRV_CTL_TLVD_DECLARE_DB_MINMAX_MUTE(name, min_dB, max_dB) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) \
+	}
 
 /* linear volume between min_dB and max_dB (.01dB unit) */
-#define TLV_DB_LINEAR_ITEM(min_dB, max_dB)		    \
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
-#define DECLARE_TLV_DB_LINEAR(name, min_dB, max_dB)	\
-	unsigned int name[] = { TLV_DB_LINEAR_ITEM(min_dB, max_dB) }
+#define SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
+#define SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(name, min_dB, max_dB) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
+	}
 
 /* dB range container:
  * Items in dB range container must be ordered by their values and by their
@@ -78,14 +88,16 @@
  * dB values (which is also required for all other mixer controls).
  */
 /* Each item is: <min> <max> <TLV> */
-#define TLV_DB_RANGE_ITEM(...) \
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_RANGE, __VA_ARGS__)
-#define DECLARE_TLV_DB_RANGE(name, ...) \
-	unsigned int name[] = { TLV_DB_RANGE_ITEM(__VA_ARGS__) }
+#define SNDRV_CTL_TLVD_DB_RANGE_ITEM(...) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_RANGE, __VA_ARGS__)
+#define SNDRV_CTL_TLVD_DECLARE_DB_RANGE(name, ...) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_RANGE_ITEM(__VA_ARGS__) \
+	}
 /* The below assumes that each item TLV is 4 words like DB_SCALE or LINEAR */
-#define TLV_DB_RANGE_HEAD(num)			\
+#define SNDRV_CTL_TLVD_DB_RANGE_HEAD(num) \
 	SNDRV_CTL_TLVT_DB_RANGE, 6 * (num) * sizeof(unsigned int)
 
-#define TLV_DB_GAIN_MUTE	-9999999
+#define SNDRV_CTL_TLVD_DB_GAIN_MUTE	-9999999
 
 #endif
-- 
2.7.4
