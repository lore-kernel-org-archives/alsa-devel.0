From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: Fixed kbuild warnings
Date: Mon,  4 May 2015 13:43:47 -0700
Message-ID: <1430772227-98776-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 77948260681
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 22:44:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

fix following sparse warnings: (new ones prefixed by >>)

>> sound/soc/intel/boards/cht_bsw_max98090_ti.c:168:37: sparse:
>> incorrect type in argument 2 (different base types)
   sound/soc/intel/boards/cht_bsw_max98090_ti.c:168:37:    expected
unsigned int [unsigned] val
   sound/soc/intel/boards/cht_bsw_max98090_ti.c:168:37:    got
restricted snd_pcm_format_t [usertype] <noident>

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 3c518b1..1be0794 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -163,9 +163,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP2 to 24-bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S24_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
-- 
1.7.9.5
