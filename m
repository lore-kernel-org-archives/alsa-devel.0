From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: mop500_ab8500: Replace instances of
	rtd->codec->card with rtd->card
Date: Mon, 19 May 2014 11:41:48 +0200
Message-ID: <1400492508-2732-4-git-send-email-lars@metafoo.de>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5734026519B
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 11:41:55 +0200 (CEST)
In-Reply-To: <1400492508-2732-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

No need to go via the CODEC to get a pointer to the card. This will help to
eventually remove the card field from the snd_soc_codec struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/ux500/mop500_ab8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 7e923ec..be4f1ac7 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -411,7 +411,7 @@ int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
 	drvdata->mclk_sel = MCLK_ULPCLK;
 
 	/* Add controls */
-	ret = snd_soc_add_card_controls(codec->card, mop500_ab8500_ctrls,
+	ret = snd_soc_add_card_controls(rtd->card, mop500_ab8500_ctrls,
 			ARRAY_SIZE(mop500_ab8500_ctrls));
 	if (ret < 0) {
 		pr_err("%s: Failed to add machine-controls (%d)!\n",
-- 
1.8.0
