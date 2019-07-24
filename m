From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: cs4271: Fix a typo in the
	CS4171_NR_RATIOS
Date: Wed, 24 Jul 2019 08:00:23 +0200
Message-ID: <20190724060023.31302-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD349F8026F
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 08:01:17 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This should be CS4271_NR_RATIOS.
Fix it and use it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/cs4271.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 1d03a1348162..04b86a51e055 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -334,7 +334,7 @@ static struct cs4271_clk_cfg cs4271_clk_tab[] = {
 	{0, CS4271_MODE1_MODE_4X, 256,  CS4271_MODE1_DIV_2},
 };
 
-#define CS4171_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
+#define CS4271_NR_RATIOS ARRAY_SIZE(cs4271_clk_tab)
 
 static int cs4271_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
@@ -383,13 +383,13 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 		val = CS4271_MODE1_MODE_4X;
 
 	ratio = cs4271->mclk / cs4271->rate;
-	for (i = 0; i < CS4171_NR_RATIOS; i++)
+	for (i = 0; i < CS4271_NR_RATIOS; i++)
 		if ((cs4271_clk_tab[i].master == cs4271->master) &&
 		    (cs4271_clk_tab[i].speed_mode == val) &&
 		    (cs4271_clk_tab[i].ratio == ratio))
 			break;
 
-	if (i == CS4171_NR_RATIOS) {
+	if (i == CS4271_NR_RATIOS) {
 		dev_err(component->dev, "Invalid sample rate\n");
 		return -EINVAL;
 	}
-- 
2.20.1
