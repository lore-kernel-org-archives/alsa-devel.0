From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: control: complement TLV macro for
	db-minmax and db-linear types
Date: Mon, 14 May 2018 07:09:50 +0900
Message-ID: <20180513220953.15118-2-o-takashi@sakamocchi.jp>
References: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 165AE267692
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 00:10:27 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so5065002pfn.6
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:10:27 -0700 (PDT)
In-Reply-To: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

A commit 08f9f4485f21 ('ALSA: core api: define offsets for TLV items')
introduced a series of macro for offset of db-scale type of TLV, however
there are some types of TLV to add similar macros.

This commit complements macros for offset of db-minmax and db-linear types
of TLV data.

Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/tlv.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index e3437e96519a..7d6d65f60a42 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -83,6 +83,10 @@
 		SNDRV_CTL_TLVD_DB_MINMAX_MUTE_ITEM(min_dB, max_dB) \
 	}
 
+/* Accessor offsets for min, max items in db-minmax types of TLV. */
+#define SNDRV_CTL_TLVO_DB_MINMAX_MIN	2
+#define SNDRV_CTL_TLVO_DB_MINMAX_MAX	3
+
 /* linear volume between min_dB and max_dB (.01dB unit) */
 #define SNDRV_CTL_TLVD_DB_LINEAR_ITEM(min_dB, max_dB) \
 	SNDRV_CTL_TLVD_ITEM(SNDRV_CTL_TLVT_DB_LINEAR, (min_dB), (max_dB))
@@ -91,6 +95,10 @@
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
