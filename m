From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/5] ASoC: Intel: Skylake: Prevent sending Set
	DMA Control IPC if the widget is "On"
Date: Thu, 28 Apr 2016 18:45:27 +0530
Message-ID: <1461849329-20364-4-git-send-email-vinod.koul@intel.com>
References: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 73F742667CE
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:10:49 +0200 (CEST)
In-Reply-To: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Dharageswari.R" <dharageswari.r@intel.com>

If widget of a playback or capture DAI is already On, then no
need not send the Set DMA Control IPC message to firmware.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 8de921272f71..df24d8c6b757 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -213,7 +213,7 @@ static int skl_be_prepare(struct snd_pcm_substream *substream,
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_cfg *mconfig;
 
-	if ((dai->playback_active > 1) || (dai->capture_active > 1))
+	if (dai->playback_widget->power || dai->capture_widget->power)
 		return 0;
 
 	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
-- 
1.9.1
