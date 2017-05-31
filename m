From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 3/3] ASoC: Intel: Boards: Add 4-channel DMIC
	fixup.
Date: Wed, 31 May 2017 10:30:26 +0530
Message-ID: <1496206826-28125-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1496206826-28125-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 57354266EF9
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 07:14:56 +0200 (CEST)
In-Reply-To: <1496206826-28125-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

This patch adds a 4-channel dmic fixup so that DMIC copier will receive
4 channel data and further selection will be done by mic-select module.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 1a68d043c803..36ee7480e9f1 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -222,16 +222,13 @@ static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	if (params_channels(params) == 2)
-		channels->min = channels->max = 2;
-	else
-		channels->min = channels->max = 4;
+	channels->min = channels->max = 4;
 
 	return 0;
 }
 
 static unsigned int channels_dmic[] = {
-	2, 4,
+	1, 2, 3, 4,
 };
 
 static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
-- 
1.9.1
