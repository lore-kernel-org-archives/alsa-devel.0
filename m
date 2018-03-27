From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] ASoC: Add accessor macros for TLV items
Date: Tue, 27 Mar 2018 11:39:45 -0700
Message-ID: <20180327183945.6551-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 062752671CC
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 20:39:46 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds macros for accessing the type, length, min, mute
and step items in TLV data. These will be used by drivers to extract
the TLV data while loading topology.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/tlv.h      | 5 +++++
 include/uapi/sound/tlv.h | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index 3677ebb928d5..8fa379e8a568 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -49,6 +49,11 @@
 
 #define TLV_DB_GAIN_MUTE		SNDRV_CTL_TLVD_DB_GAIN_MUTE
 
+#define TLV_ITEM_TYPE			SNDRV_CTL_TLVD_ITEM_TYPE
+#define TLV_ITEM_LEN			SNDRV_CTL_TLVD_ITEM_LEN
+#define TLV_DB_MIN			SNDRV_CTL_TLVD_DB_SCALE_MIN
+#define TLV_DB_MUTE_AND_STEP		SNDRV_CTL_TLVD_DB_SCALE_MUTE_AND_STEP
+
 /*
  * The below assumes that each item TLV is 4 words like DB_SCALE or LINEAR.
  * This is an old fasion and obsoleted by commit bf1d1c9b6179("ALSA: tlv: add
diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index be5371f09a62..f3fba49ef6e8 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -60,6 +60,13 @@
 	unsigned int name[] = { \
 		SNDRV_CTL_TLVD_DB_SCALE_ITEM(min, step, mute) \
 	}
+/* Accessor macros for TLV type and len */
+#define SNDRV_CTL_TLVD_ITEM_TYPE		0
+#define SNDRV_CTL_TLVD_ITEM_LEN			1
+
+/* Accessor macros for min, mute and step values from dB scale type TLV */
+#define SNDRV_CTL_TLVD_DB_SCALE_MIN		2
+#define SNDRV_CTL_TLVD_DB_SCALE_MUTE_AND_STEP	3
 
 /* dB scale specified with min/max values instead of step */
 #define SNDRV_CTL_TLVD_DB_MINMAX_ITEM(min_dB, max_dB) \
-- 
2.14.1
