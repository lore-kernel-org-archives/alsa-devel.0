From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Print more information if
	setting DAI clock failed
Date: Wed, 15 Oct 2014 13:55:32 -0700
Message-ID: <1413406532-7286-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f74.google.com (mail-pa0-f74.google.com
 [209.85.220.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 1444A260432
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 22:55:37 +0200 (CEST)
Received: by mail-pa0-f74.google.com with SMTP id kq14so376535pab.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 13:55:36 -0700 (PDT)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/rt5677.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 2f0d19f..a8d9eab 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3104,7 +3104,8 @@ static int rt5677_hw_params(struct snd_pcm_substream *substream,
 	rt5677->lrck[dai->id] = params_rate(params);
 	pre_div = rl6231_get_clk_info(rt5677->sysclk, rt5677->lrck[dai->id]);
 	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting\n");
+		dev_err(codec->dev, "Unsupported clock setting: sysclk=%dHz lrck=%dHz\n",
+			rt5677->sysclk, rt5677->lrck[dai->id]);
 		return -EINVAL;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
-- 
2.1.0.rc2.206.gedb03e5
