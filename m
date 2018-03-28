From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH v2] ALSA: core api: define offsets for TLV items
Date: Wed, 28 Mar 2018 10:09:04 -0700
Message-ID: <20180328170904.19845-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D55266E07
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 19:09:07 +0200 (CEST)
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

This patch defines accessor offsets for the type, length, min,
mute and step items in TLV data. These will be used by drivers to
extract the TLV data while loading topology.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
V2: removed redundant redefinitions and updated prefix
---
 include/uapi/sound/tlv.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index be5371f09a62..1fd786a5e57b 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -98,4 +98,12 @@
 
 #define SNDRV_CTL_TLVD_DB_GAIN_MUTE	-9999999
 
+/* Accessor offsets for TLV data items */
+#define SNDRV_CTL_TLV_OFFSET_TYPE		0
+#define SNDRV_CTL_TLV_OFFSET_LEN		1
+
+/* Accessor offsets for min, mute and step items in dB scale type TLV */
+#define SNDRV_CTL_TLV_OFFSET_DB_MIN		2
+#define SNDRV_CTL_TLV_OFFSET_DB_MUTE_AND_STEP	3
+
 #endif
-- 
2.14.1
