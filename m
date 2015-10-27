From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/17] ASoC: Intel: Skylake: Fix not to ignore
	return value in be hw_params
Date: Tue, 27 Oct 2015 09:22:45 +0900
Message-ID: <1445905380-18167-3-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 529FC2651ED
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:17 +0100 (CET)
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

Return value from skl_tplg_be_update_params() is ignored. But if the
blob is null then the hw_params needs to return error.
This patch fixes the issue by not ignoring return value from
skl_tplg_be_update_params().

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a2f94ce1679d..1242beac4e46 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -291,9 +291,8 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 	p_params.ch = params_channels(params);
 	p_params.s_freq = params_rate(params);
 	p_params.stream = substream->stream;
-	skl_tplg_be_update_params(dai, &p_params);
 
-	return 0;
+	return skl_tplg_be_update_params(dai, &p_params);
 }
 
 static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -352,9 +351,7 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	p_params.stream = substream->stream;
 	p_params.link_dma_id = hdac_stream(link_dev)->stream_tag - 1;
 
-	skl_tplg_be_update_params(dai, &p_params);
-
-	return 0;
+	return skl_tplg_be_update_params(dai, &p_params);
 }
 
 static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
-- 
2.4.3
