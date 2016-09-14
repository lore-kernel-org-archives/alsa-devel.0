From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: control: move layout of TLV payload
	to UAPI header
Date: Thu, 15 Sep 2016 07:25:19 +0900
Message-ID: <1473891920-31214-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1473891920-31214-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DA7912665C1
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

In ALSA control interface, each element set can have threshold level
information. This information is transferred between drivers/applications,
in a shape of tlv packet. The layout of this packet is defined in
'uapi/sound/asound.h' (struct snd_ctl_tlv):

struct snd_ctl_tlv {
    unsigned int numid;
    unsigned int length;
    unsigned int tlv[0];
};

Data in the payload (struct snd_ctl_tlv.tlv) is expected to be filled
according to our own protocol. This protocol is described in
'include/sound/tlv.h'. A layout of the payload is expected as:

struct snd_ctl_tlv.tlv[0]: one of SNDRV_CTL_TLVT_XXX
struct snd_ctl_tlv.tlv[1]: Length of data
struct snd_ctl_tlv.tlv[2...]: data

Unfortunately, the macro is not exported to user land yet, thus
applications cannot get to know the protocol.

Additionally, ALSA control core has a feature called as 'user-defined'
element set. This allows applications to add/remove arbitrary element sets
with elements to control devices. Elements in the element set can be
operated by the same way as the ones added by in-kernel implementation.

For threshold level information of 'user-defined' element set, applications
need to register the information to an element set. However, as described
above, layout of the payload is closed in kernel land. This is quite
inconvenient, too.

This commit moves the protocol to UAPI header for TLV.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/tlv.h      | 61 ------------------------------------------------
 include/uapi/sound/tlv.h | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index df97d19..1f593b6 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -22,67 +22,6 @@
  *
  */
 
-/*
- * TLV structure is right behind the struct snd_ctl_tlv:
- *   unsigned int type  	- see SNDRV_CTL_TLVT_*
- *   unsigned int length
- *   .... data aligned to sizeof(unsigned int), use
- *        block_length = (length + (sizeof(unsigned int) - 1)) &
- *                       ~(sizeof(unsigned int) - 1)) ....
- */
-
 #include <uapi/sound/tlv.h>
 
-#define TLV_ITEM(type, ...) \
-	(type), TLV_LENGTH(__VA_ARGS__), __VA_ARGS__
-#define TLV_LENGTH(...) \
-	((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__ }))
-
-#define TLV_CONTAINER_ITEM(...) \
-	TLV_ITEM(SNDRV_CTL_TLVT_CONTAINER, __VA_ARGS__)
-#define DECLARE_TLV_CONTAINER(name, ...) \
-	unsigned int name[] = { TLV_CONTAINER_ITEM(__VA_ARGS__) }
-
-#define TLV_DB_SCALE_MASK	0xffff
-#define TLV_DB_SCALE_MUTE	0x10000
-#define TLV_DB_SCALE_ITEM(min, step, mute)			\
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_SCALE,			\
-		 (min),					\
-		 ((step) & TLV_DB_SCALE_MASK) |		\
-			((mute) ? TLV_DB_SCALE_MUTE : 0))
-#define DECLARE_TLV_DB_SCALE(name, min, step, mute) \
-	unsigned int name[] = { TLV_DB_SCALE_ITEM(min, step, mute) }
-
-/* dB scale specified with min/max values instead of step */
-#define TLV_DB_MINMAX_ITEM(min_dB, max_dB)			\
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_MINMAX, (min_dB), (max_dB))
-#define TLV_DB_MINMAX_MUTE_ITEM(min_dB, max_dB)			\
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_MINMAX_MUTE, (min_dB), (max_dB))
-#define DECLARE_TLV_DB_MINMAX(name, min_dB, max_dB) \
-	unsigned int name[] = { TLV_DB_MINMAX_ITEM(min_dB, max_dB) }
-#define DECLARE_TLV_DB_MINMAX_MUTE(name, min_dB, max_dB) \
-	unsigned int name[] = { TLV_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) }
-
-/* linear volume between min_dB and max_dB (.01dB unit) */
-#define TLV_DB_LINEAR_ITEM(min_dB, max_dB)		    \
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
-#define DECLARE_TLV_DB_LINEAR(name, min_dB, max_dB)	\
-	unsigned int name[] = { TLV_DB_LINEAR_ITEM(min_dB, max_dB) }
-
-/* dB range container:
- * Items in dB range container must be ordered by their values and by their
- * dB values. This implies that larger values must correspond with larger
- * dB values (which is also required for all other mixer controls).
- */
-/* Each item is: <min> <max> <TLV> */
-#define TLV_DB_RANGE_ITEM(...) \
-	TLV_ITEM(SNDRV_CTL_TLVT_DB_RANGE, __VA_ARGS__)
-#define DECLARE_TLV_DB_RANGE(name, ...) \
-	unsigned int name[] = { TLV_DB_RANGE_ITEM(__VA_ARGS__) }
-/* The below assumes that each item TLV is 4 words like DB_SCALE or LINEAR */
-#define TLV_DB_RANGE_HEAD(num)			\
-	SNDRV_CTL_TLVT_DB_RANGE, 6 * (num) * sizeof(unsigned int)
-
-#define TLV_DB_GAIN_MUTE	-9999999
-
 #endif /* __SOUND_TLV_H */
diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index ffc4f20..b741e0e 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -28,4 +28,64 @@
 #define SNDRV_CTL_TLVT_CHMAP_VAR	0x102	/* channels freely swappable */
 #define SNDRV_CTL_TLVT_CHMAP_PAIRED	0x103	/* pair-wise swappable */
 
+/*
+ * TLV structure is right behind the struct snd_ctl_tlv:
+ *   unsigned int type  	- see SNDRV_CTL_TLVT_*
+ *   unsigned int length
+ *   .... data aligned to sizeof(unsigned int), use
+ *        block_length = (length + (sizeof(unsigned int) - 1)) &
+ *                       ~(sizeof(unsigned int) - 1)) ....
+ */
+#define TLV_ITEM(type, ...) \
+	(type), TLV_LENGTH(__VA_ARGS__), __VA_ARGS__
+#define TLV_LENGTH(...) \
+	((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__ }))
+
+#define TLV_CONTAINER_ITEM(...) \
+	TLV_ITEM(SNDRV_CTL_TLVT_CONTAINER, __VA_ARGS__)
+#define DECLARE_TLV_CONTAINER(name, ...) \
+	unsigned int name[] = { TLV_CONTAINER_ITEM(__VA_ARGS__) }
+
+#define TLV_DB_SCALE_MASK	0xffff
+#define TLV_DB_SCALE_MUTE	0x10000
+#define TLV_DB_SCALE_ITEM(min, step, mute)			\
+	TLV_ITEM(SNDRV_CTL_TLVT_DB_SCALE,			\
+		 (min),					\
+		 ((step) & TLV_DB_SCALE_MASK) |		\
+			((mute) ? TLV_DB_SCALE_MUTE : 0))
+#define DECLARE_TLV_DB_SCALE(name, min, step, mute) \
+	unsigned int name[] = { TLV_DB_SCALE_ITEM(min, step, mute) }
+
+/* dB scale specified with min/max values instead of step */
+#define TLV_DB_MINMAX_ITEM(min_dB, max_dB)			\
+	TLV_ITEM(SNDRV_CTL_TLVT_DB_MINMAX, (min_dB), (max_dB))
+#define TLV_DB_MINMAX_MUTE_ITEM(min_dB, max_dB)			\
+	TLV_ITEM(SNDRV_CTL_TLVT_DB_MINMAX_MUTE, (min_dB), (max_dB))
+#define DECLARE_TLV_DB_MINMAX(name, min_dB, max_dB) \
+	unsigned int name[] = { TLV_DB_MINMAX_ITEM(min_dB, max_dB) }
+#define DECLARE_TLV_DB_MINMAX_MUTE(name, min_dB, max_dB) \
+	unsigned int name[] = { TLV_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) }
+
+/* linear volume between min_dB and max_dB (.01dB unit) */
+#define TLV_DB_LINEAR_ITEM(min_dB, max_dB)		    \
+	TLV_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
+#define DECLARE_TLV_DB_LINEAR(name, min_dB, max_dB)	\
+	unsigned int name[] = { TLV_DB_LINEAR_ITEM(min_dB, max_dB) }
+
+/* dB range container:
+ * Items in dB range container must be ordered by their values and by their
+ * dB values. This implies that larger values must correspond with larger
+ * dB values (which is also required for all other mixer controls).
+ */
+/* Each item is: <min> <max> <TLV> */
+#define TLV_DB_RANGE_ITEM(...) \
+	TLV_ITEM(SNDRV_CTL_TLVT_DB_RANGE, __VA_ARGS__)
+#define DECLARE_TLV_DB_RANGE(name, ...) \
+	unsigned int name[] = { TLV_DB_RANGE_ITEM(__VA_ARGS__) }
+/* The below assumes that each item TLV is 4 words like DB_SCALE or LINEAR */
+#define TLV_DB_RANGE_HEAD(num)			\
+	SNDRV_CTL_TLVT_DB_RANGE, 6 * (num) * sizeof(unsigned int)
+
+#define TLV_DB_GAIN_MUTE	-9999999
+
 #endif
-- 
2.7.4
