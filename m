From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Correct the xmax volume
Date: Fri, 28 Nov 2014 10:41:28 +0800
Message-ID: <1417142488-14577-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C841C26040C
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 03:40:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The xmax volume should be corrected to ARRAY_SIZE(volume_map)-1, otherwise,
the xmax value will be mapped to 0 wrongly.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 20561ca..5f70d81 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -298,19 +298,19 @@ static const DECLARE_TLV_DB_SCALE(hsw_vol_tlv, -9000, 300, 1);
 static const struct snd_kcontrol_new hsw_volume_controls[] = {
 	/* Global DSP volume */
 	SOC_DOUBLE_EXT_TLV("Master Playback Volume", 0, 0, 8,
-		ARRAY_SIZE(volume_map) -1, 0,
+		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_volume_get, hsw_volume_put, hsw_vol_tlv),
 	/* Offload 0 volume */
 	SOC_DOUBLE_EXT_TLV("Media0 Playback Volume", 1, 0, 8,
-		ARRAY_SIZE(volume_map), 0,
+		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 	/* Offload 1 volume */
 	SOC_DOUBLE_EXT_TLV("Media1 Playback Volume", 2, 0, 8,
-		ARRAY_SIZE(volume_map), 0,
+		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 	/* Mic Capture volume */
 	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 4, 0, 8,
-		ARRAY_SIZE(volume_map), 0,
+		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 };
 
-- 
1.9.1
