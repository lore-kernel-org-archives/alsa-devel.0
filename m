From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix swapped order of function arguments dir and pin_index
Date: Wed, 20 Sep 2017 14:01:25 +0100
Message-ID: <20170920130125.12984-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The call to slk_tplg_fill_res_tkn is passing dir and pin_index in the
wrong order, they need to be in pin_index, dir order to match the function
slk_tplg_fill_res_tkn  correctly.

Detected by CoveritScan, CID#1454992 ("Arguments in wrong order")

Fixes: f6fa56e22559 ("ASoC: Intel: Skylake: Parse and update module config structure")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 22f768ca3c73..27bcb62568fb 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2382,7 +2382,7 @@ static int skl_tplg_get_token(struct device *dev,
 	case SKL_TKN_U32_MAX_MCPS:
 	case SKL_TKN_U32_OBS:
 	case SKL_TKN_U32_IBS:
-		ret = skl_tplg_fill_res_tkn(dev, tkn_elem, res, dir, pin_index);
+		ret = skl_tplg_fill_res_tkn(dev, tkn_elem, res, pin_index, dir);
 		if (ret < 0)
 			return ret;
 
-- 
2.14.1
