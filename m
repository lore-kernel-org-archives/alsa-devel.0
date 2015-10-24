From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: da7219: Use logical instead of bitwise
 OR for boolean expression
Date: Sat, 24 Oct 2015 14:28:33 +0800
Message-ID: <1445668113.26836.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D12D2656FB
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 08:28:39 +0200 (CEST)
Received: by pacfv9 with SMTP id fv9so143120156pac.3
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 23:28:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index abba4b3..86c528a 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1306,7 +1306,7 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	channels = params_channels(params);
-	if ((channels < 1) | (channels > DA7219_DAI_CH_NUM_MAX)) {
+	if ((channels < 1) || (channels > DA7219_DAI_CH_NUM_MAX)) {
 		dev_err(codec->dev,
 			"Invalid number of channels, only 1 to %d supported\n",
 			DA7219_DAI_CH_NUM_MAX);
-- 
2.1.4
