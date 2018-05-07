From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH v3] ALSA: core api: define offsets for TLV items
Date: Mon,  7 May 2018 14:04:31 -0700
Message-ID: <20180507210431.4332-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id C89DE267651
 for <alsa-devel@alsa-project.org>; Mon,  7 May 2018 23:04:34 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Currently, there are no pre-defined accessors for the elements
in topology TLV data. In the absence of such offsets, the
tlv data will have to be decoded using hardwired offset
numbers 0-N depending on the type of TLV. This patch defines
accessor offsets for the type, length, min and mute/step items
in TLV data for DB_SCALE type tlv's. These will be used by drivers to
decode the TLV data while loading topology thereby improving
code readability. The type and len offsets are common for all TLV
types. The min and step/mute offsets are specific to DB_SCALE tlv type.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---

Notes:
    v3: fix prefix for offset definitions

 include/uapi/sound/tlv.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index be5371f09a62..13f425c2abbd 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -98,4 +98,12 @@
 
 #define SNDRV_CTL_TLVD_DB_GAIN_MUTE	-9999999
 
+/* Accessor offsets for TLV data items */
+#define SNDRV_CTL_TLVO_TYPE		0
+#define SNDRV_CTL_TLVO_LEN		1
+
+/* Accessor offsets for min, mute and step items in dB scale type TLV */
+#define SNDRV_CTL_TLVO_DB_SCALE_MIN		2
+#define SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP	3
+
 #endif
-- 
2.14.1
