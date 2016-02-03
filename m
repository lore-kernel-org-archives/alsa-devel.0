From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/11] ASoC: Intel: Skylake: Fix stereo DMIC
	record
Date: Wed,  3 Feb 2016 17:59:53 +0530
Message-ID: <1454502594-21700-11-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 17370265A98
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:48 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

DMIC BE can have 2 or 4 channels supported. The DMIC fixup needs
to take this into account.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 7396ddb427d8..2cbcbe412661 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -212,7 +212,10 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
-	channels->min = channels->max = 4;
+	if (params_channels(params) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
 
 	return 0;
 }
-- 
1.9.1
