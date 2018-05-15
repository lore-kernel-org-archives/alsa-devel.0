From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 1/6] control: add a series of macro
	for offset of several types of TLV
Date: Tue, 15 May 2018 21:36:34 +0900
Message-ID: <20180515123639.18255-2-o-takashi@sakamocchi.jp>
References: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 78EB5266EDF
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:16 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id p12-v6so7667593pff.13
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:16 -0700 (PDT)
In-Reply-To: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In development period for Linux v4.18, a series of SNDRV_CTL_TLVO_XXX
macro was introduced to kernel stuffs for position offset of TLV data.

This commit adds these macros to backport header in this library.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/tlv.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index b4df440c..2ea47685 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -41,6 +41,10 @@
 #define SNDRV_CTL_TLVD_LENGTH(...) \
 	((unsigned int)sizeof((const unsigned int[]) { __VA_ARGS__ }))
 
+/* Accessor offsets for TLV data items */
+#define SNDRV_CTL_TLVO_TYPE		0
+#define SNDRV_CTL_TLVO_LEN		1
+
 #define SNDRV_CTL_TLVD_CONTAINER_ITEM(...) \
 	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_CONTAINER, __VA_ARGS__)
 #define SNDRV_CTL_TLVD_DECLARE_CONTAINER(name, ...) \
@@ -60,6 +64,10 @@
 		SNDRV_CTL_TLVD_DB_SCALE_ITEM(min, step, mute) \
 	}
 
+/* Accessor offsets for min, mute and step items in dB scale type TLV */
+#define SNDRV_CTL_TLVO_DB_SCALE_MIN		2
+#define SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP	3
+
 /* dB scale specified with min/max values instead of step */
 #define SNDRV_CTL_TLVD_DB_MINMAX_ITEM(min_dB, max_dB) \
 	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_MINMAX, (min_dB), (max_dB))
@@ -74,6 +82,10 @@
 		SNDRV_CTL_TLVD_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) \
 	}
 
+/* Accessor offsets for min, max items in db-minmax types of TLV. */
+#define SNDRV_CTL_TLVO_DB_MINMAX_MIN	2
+#define SNDRV_CTL_TLVO_DB_MINMAX_MAX	3
+
 /* linear volume between min_dB and max_dB (.01dB unit) */
 #define SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
 	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
@@ -82,6 +94,10 @@
 		SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
 	}
 
+/* Accessor offsets for min, max items in db-linear type of TLV. */
+#define SNDRV_CTL_TLVO_DB_LINEAR_MIN	2
+#define SNDRV_CTL_TLVO_DB_LINEAR_MAX	3
+
 /* dB range container:
  * Items in dB range container must be ordered by their values and by their
  * dB values. This implies that larger values must correspond with larger
-- 
2.14.1
