From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 1/5] Update include/sound/tlv.h from 4.9-pre
	kernel uapi
Date: Thu, 29 Sep 2016 08:57:20 +0900
Message-ID: <1475107044-30647-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C0FD52665E5
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 01:57:28 +0200 (CEST)
In-Reply-To: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The UAPI header in 4.9-pre kernel newly includes existent macros related
to tlv operation, mainly for layout of TLV packet payload.

This commit updates corresponding backport header in this library.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/tlv.h | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index 33d747d..b4df440 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -20,4 +20,81 @@
 #define SNDRV_CTL_TLVT_DB_MINMAX 4	/* dB scale with min/max */
 #define SNDRV_CTL_TLVT_DB_MINMAX_MUTE 5	/* dB scale with min/max with mute */
 
+/*
+ * channel-mapping TLV items
+ *  TLV length must match with num_channels
+ */
+#define SNDRV_CTL_TLVT_CHMAP_FIXED	0x101	/* fixed channel position */
+#define SNDRV_CTL_TLVT_CHMAP_VAR	0x102	/* channels freely swappable */
+#define SNDRV_CTL_TLVT_CHMAP_PAIRED	0x103	/* pair-wise swappable */
+
+/*
+ * TLV structure is right behind the struct snd_ctl_tlv:
+ *   unsigned int type  	- see SNDRV_CTL_TLVT_*
+ *   unsigned int length
+ *   .... data aligned to sizeof(unsigned int), use
+ *        block_length = (length + (sizeof(unsigned int) - 1)) &
+ *                       ~(sizeof(unsigned int) - 1)) ....
+ */
+#define SNDRV_CTL_TLVD_ITEM(type, ...) \
+	(type), SNDRV_CTL_TLVD_LENGTH(__VA_ARGS__), __VA_ARGS__
+#define SNDRV_CTL_TLVD_LENGTH(...) \
+	((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__ }))
+
+#define SNDRV_CTL_TLVD_CONTAINER_ITEM(...) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_CONTAINER, __VA_ARGS__)
+#define SNDRV_CTL_TLVD_DECLARE_CONTAINER(name, ...) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_CONTAINER_ITEM(__VA_ARGS__) \
+	}
+
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
+
+/* dB scale specified with min/max values instead of step */
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
+
+/* linear volume between min_dB and max_dB (.01dB unit) */
+#define SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
+#define SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(name, min_dB, max_dB) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
+	}
+
+/* dB range container:
+ * Items in dB range container must be ordered by their values and by their
+ * dB values. This implies that larger values must correspond with larger
+ * dB values (which is also required for all other mixer controls).
+ */
+/* Each item is: <min> <max> <TLV> */
+#define SNDRV_CTL_TLVD_DB_RANGE_ITEM(...) \
+	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_RANGE, __VA_ARGS__)
+#define SNDRV_CTL_TLVD_DECLARE_DB_RANGE(name, ...) \
+	unsigned int name[] = { \
+		SNDRV_CTL_TLVD_DB_RANGE_ITEM(__VA_ARGS__) \
+	}
+
+#define SNDRV_CTL_TLVD_DB_GAIN_MUTE	-9999999
+
 #endif
-- 
2.7.4
