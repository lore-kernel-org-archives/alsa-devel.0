From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 15/17] ASoC: Intel: Skylake: Ignore rate check
	for DMIC link
Date: Tue, 27 Oct 2015 09:22:58 +0900
Message-ID: <1445905380-18167-16-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FC8265341
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:24:04 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

DMIC NHLT entry is sample rate agnostic, so ignore the rate
checks for DMIC type

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 3ff22eba5875..6e4b21cdb1bd 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -55,7 +55,7 @@ void skl_nhlt_free(void *addr)
 
 static struct nhlt_specific_cfg *skl_get_specific_cfg(
 		struct device *dev, struct nhlt_fmt *fmt,
-		u8 no_ch, u32 rate, u16 bps)
+		u8 no_ch, u32 rate, u16 bps, u8 linktype)
 {
 	struct nhlt_specific_cfg *sp_config;
 	struct wav_fmt *wfmt;
@@ -68,11 +68,17 @@ static struct nhlt_specific_cfg *skl_get_specific_cfg(
 		wfmt = &fmt_config->fmt_ext.fmt;
 		dev_dbg(dev, "ch=%d fmt=%d s_rate=%d\n", wfmt->channels,
 			 wfmt->bits_per_sample, wfmt->samples_per_sec);
-		if (wfmt->channels == no_ch && wfmt->samples_per_sec == rate &&
-					wfmt->bits_per_sample == bps) {
+		if (wfmt->channels == no_ch && wfmt->bits_per_sample == bps) {
+			/*
+			 * if link type is dmic ignore rate check as the blob is
+			 * generic for all rates
+			 */
 			sp_config = &fmt_config->config;
+			if (linktype == NHLT_LINK_DMIC)
+				return sp_config;
 
-			return sp_config;
+			if (wfmt->samples_per_sec == rate)
+				return sp_config;
 		}
 
 		fmt_config = (struct nhlt_fmt_cfg *)(fmt_config->config.caps +
@@ -128,7 +134,8 @@ struct nhlt_specific_cfg
 		if (skl_check_ep_match(dev, epnt, instance, link_type, dirn)) {
 			fmt = (struct nhlt_fmt *)(epnt->config.caps +
 						 epnt->config.size);
-			sp_config = skl_get_specific_cfg(dev, fmt, num_ch, s_rate, bps);
+			sp_config = skl_get_specific_cfg(dev, fmt, num_ch,
+							s_rate, bps, link_type);
 			if (sp_config)
 				return sp_config;
 		}
-- 
2.4.3
