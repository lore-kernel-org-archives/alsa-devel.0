From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: core: fix .info for SND_SOC_BYTES_TLV
Date: Mon, 18 Aug 2014 14:53:03 +0530
Message-ID: <1408353783-8740-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1322B2654E0
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 11:37:54 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Commit 7523a271 - "ASoC: core: add a helper for extended byte controls using
TLV" introduced support for TLV byte controls but had a typo for the info
function, so fix the same

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index be6ecae..c83a334 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -277,7 +277,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE | \
 		  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
 	.tlv.c = (snd_soc_bytes_tlv_callback), \
-	.info = snd_soc_info_bytes_ext, \
+	.info = snd_soc_bytes_info_ext, \
 	.private_value = (unsigned long)&(struct soc_bytes_ext) \
 		{.max = xcount, .get = xhandler_get, .put = xhandler_put, } }
 #define SOC_SINGLE_XR_SX(xname, xregbase, xregcount, xnbits, \
-- 
1.7.0.4
