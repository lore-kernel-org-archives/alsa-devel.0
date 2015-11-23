From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Skylake: Update pcm capability
Date: Mon, 23 Nov 2015 22:26:26 +0530
Message-ID: <1448297789-6524-5-git-send-email-vinod.koul@intel.com>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2919626572D
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:52:57 +0100 (CET)
In-Reply-To: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
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

This patch adds pcm capability to support 16/8k rates and 32 bit formats

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 43944aff8dcb..787fd3c0cc4e 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -40,9 +40,12 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
 				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
 				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
-	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_48000,
-	.rate_min =		48000,
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S32_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+	.rates =		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 |
+				SNDRV_PCM_RATE_8000,
+	.rate_min =		8000,
 	.rate_max =		48000,
 	.channels_min =		2,
 	.channels_max =		2,
-- 
1.9.1
