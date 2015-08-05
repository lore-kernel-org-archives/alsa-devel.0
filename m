From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 3/3] ASoC: topology: Add private data type
	and bump ABI version to 3
Date: Wed,  5 Aug 2015 14:41:15 +0100
Message-ID: <1438782075-19977-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438782075-19977-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EAB2265E5B
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 15:41:31 +0200 (CEST)
In-Reply-To: <1438782075-19977-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Add ID for standalone private data object types and bump ABI version to
3 in order to userpsace features.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/uapi/sound/asoc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index d5281ac..51b8066 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -77,7 +77,7 @@
 #define SND_SOC_TPLG_NUM_TEXTS		16
 
 /* ABI version */
-#define SND_SOC_TPLG_ABI_VERSION	0x2
+#define SND_SOC_TPLG_ABI_VERSION	0x3
 
 /* Max size of TLV data */
 #define SND_SOC_TPLG_TLV_SIZE		32
@@ -97,7 +97,8 @@
 #define SND_SOC_TPLG_TYPE_PCM		7
 #define SND_SOC_TPLG_TYPE_MANIFEST	8
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
-#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_CODEC_LINK
+#define SND_SOC_TPLG_TYPE_PDATA		10
+#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
 
 /* vendor block IDs - please add new vendor types to end */
 #define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
-- 
2.1.4
