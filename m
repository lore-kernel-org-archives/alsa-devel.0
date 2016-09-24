From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: cage TLV_DB_RANGE_HEAD in
	kernel land because it was obsoleted
Date: Sat, 24 Sep 2016 19:28:23 +0900
Message-ID: <1474712903-32427-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D556F261A81
 for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2016 12:28:28 +0200 (CEST)
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

In commit bf1d1c9b6179 ("ALSA: tlv: add DECLARE_TLV_DB_RANGE()"), the new
macro was added so that "dB range information can be specified without
having to count the items manually for TLV_DB_RANGE_HEAD()". In short,
TLV_DB_RANGE_HEAD macro was obsoleted.

In commit 46e860f76804 ("ALSA: rename TLV-related macros so that they're
friendly to user applications"), TLV-related macros are exposed for
applications in user land to get content of data structured by
Type/Length/Value shape. The commit managed to expose TLV-related macros
as many as possible, while obsoleted TLV_DB_RANGE_HEAD() was included to
the list of exposed macros.

This situation brings some confusions to application developers because
they might think all exposed macros have their own purpose and useful for
applications.

For the reason, this commit moves TLV_DB_RANGE_HEAD macro from UAPI header
to a header for kernel land, again. The above commit is done within the
same development period for kernel 4.9, thus not published yet. This
commit might certainly brings no confusions to user land.

Reference: commit bf1d1c9b6179 ("ALSA: tlv: add DECLARE_TLV_DB_RANGE()")
Reference: commit 46e860f76804 ("ALSA: rename TLV-related macros so that they're friendly to user applications")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/tlv.h      | 9 ++++++++-
 include/uapi/sound/tlv.h | 3 ---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index 6e2e773..3677ebb 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -46,8 +46,15 @@
 
 #define TLV_DB_RANGE_ITEM		SNDRV_CTL_TLVD_DB_RANGE_ITEM
 #define DECLARE_TLV_DB_RANGE		SNDRV_CTL_TLVD_DECLARE_DB_RANGE
-#define TLV_DB_RANGE_HEAD		SNDRV_CTL_TLVD_DB_RANGE_HEAD
 
 #define TLV_DB_GAIN_MUTE		SNDRV_CTL_TLVD_DB_GAIN_MUTE
 
+/*
+ * The below assumes that each item TLV is 4 words like DB_SCALE or LINEAR.
+ * This is an old fasion and obsoleted by commit bf1d1c9b6179("ALSA: tlv: add
+ * DECLARE_TLV_DB_RANGE()").
+ */
+#define TLV_DB_RANGE_HEAD(num) \
+	SNDRV_CTL_TLVT_DB_RANGE, 6 * (num) * sizeof(unsigned int)
+
 #endif /* __SOUND_TLV_H */
diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index f3c198f..b4df440 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -94,9 +94,6 @@
 	unsigned int name[] = { \
 		SNDRV_CTL_TLVD_DB_RANGE_ITEM(__VA_ARGS__) \
 	}
-/* The below assumes that each item TLV is 4 words like DB_SCALE or LINEAR */
-#define SNDRV_CTL_TLVD_DB_RANGE_HEAD(num) \
-	SNDRV_CTL_TLVT_DB_RANGE, 6 * (num) * sizeof(unsigned int)
 
 #define SNDRV_CTL_TLVD_DB_GAIN_MUTE	-9999999
 
-- 
2.7.4
