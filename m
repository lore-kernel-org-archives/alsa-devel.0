From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 3/3] ALSA: topology: Export ID types for TLV
	controls.
Date: Mon, 25 May 2015 18:22:50 +0100
Message-ID: <1432574570-7436-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A8672625C4
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 19:23:43 +0200 (CEST)
In-Reply-To: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Make sure userspace can define TLV controls for topolofy using the correct
type numbers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/tlv.h      |  7 +------
 include/uapi/sound/tlv.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/sound/tlv.h

diff --git a/include/sound/tlv.h b/include/sound/tlv.h
index e11e179..7209331 100644
--- a/include/sound/tlv.h
+++ b/include/sound/tlv.h
@@ -31,12 +31,7 @@
  *                       ~(sizeof(unsigned int) - 1)) ....
  */
 
-#define SNDRV_CTL_TLVT_CONTAINER 0	/* one level down - group of TLVs */
-#define SNDRV_CTL_TLVT_DB_SCALE	1       /* dB scale */
-#define SNDRV_CTL_TLVT_DB_LINEAR 2	/* linear volume */
-#define SNDRV_CTL_TLVT_DB_RANGE 3	/* dB range container */
-#define SNDRV_CTL_TLVT_DB_MINMAX 4	/* dB scale with min/max */
-#define SNDRV_CTL_TLVT_DB_MINMAX_MUTE 5	/* dB scale with min/max with mute */
+#include <uapi/sound/tlv.h>
 
 #define TLV_ITEM(type, ...) \
 	(type), TLV_LENGTH(__VA_ARGS__), __VA_ARGS__
diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
new file mode 100644
index 0000000..33d747d
--- /dev/null
+++ b/include/uapi/sound/tlv.h
@@ -0,0 +1,23 @@
+/*
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef __UAPI_SOUND_TLV_H
+#define __UAPI_SOUND_TLV_H
+
+#define SNDRV_CTL_TLVT_CONTAINER 0	/* one level down - group of TLVs */
+#define SNDRV_CTL_TLVT_DB_SCALE	1       /* dB scale */
+#define SNDRV_CTL_TLVT_DB_LINEAR 2	/* linear volume */
+#define SNDRV_CTL_TLVT_DB_RANGE 3	/* dB range container */
+#define SNDRV_CTL_TLVT_DB_MINMAX 4	/* dB scale with min/max */
+#define SNDRV_CTL_TLVT_DB_MINMAX_MUTE 5	/* dB scale with min/max with mute */
+
+#endif
-- 
2.1.4
