From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: rt5640: Provide more useful hw_params
	error reasons.
Date: Fri, 13 Sep 2013 17:57:35 +0100
Message-ID: <1379091456-7223-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 703112608EC
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 18:57:46 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 2f6bb16..de40bd9 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1609,7 +1609,8 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	rt5640->lrck[dai->id] = params_rate(params);
 	pre_div = get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
 	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting\n");
+		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
+			rt5640->lrck[dai->id], dai->id);
 		return -EINVAL;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
-- 
1.8.1.2
