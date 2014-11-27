From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Remove useless loopback volume
	control for Broadwell
Date: Thu, 27 Nov 2014 14:04:23 +0800
Message-ID: <1417068263-12026-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C358426582C
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 07:03:39 +0100 (CET)
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

On Broadwell, the ADSP FW don't support loopback record volume tuning,
so here remove this control.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 331237f..20561ca 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -308,10 +308,6 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 	SOC_DOUBLE_EXT_TLV("Media1 Playback Volume", 2, 0, 8,
 		ARRAY_SIZE(volume_map), 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
-	/* Loopback volume */
-	SOC_DOUBLE_EXT_TLV("Loopback Capture Volume", 3, 0, 8,
-		ARRAY_SIZE(volume_map), 0,
-		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 	/* Mic Capture volume */
 	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 4, 0, 8,
 		ARRAY_SIZE(volume_map), 0,
-- 
1.9.1
