From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: smd845: fix memory leak
Date: Fri, 3 Aug 2018 08:42:11 -0500
Message-ID: <20180803134211.GA24593@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In case memory resources for *card* were allocated, release them before
return.

Addresses-Coverity-ID: 1472244 ("Resource leak")
Fixes: 6b1687bf76ef ("ASoC: qcom: add sdm845 sound card support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
NOTE: Notice that there are many places in which the return values of
      functions snd_soc_dai_set_sysclk() and snd_soc_dai_set_fmt() are
      not being checked. I wonder if this is intentional. Otherwise, I
      can send a patch for that. Please, confirm. Thanks!

 sound/soc/qcom/sdm845.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index be0cb11..c1adb77 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -222,8 +222,10 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 
 	/* Allocate the private data */
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto data_alloc_fail;
+	}
 
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
@@ -248,6 +250,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	kfree(card->dai_link);
 parse_dt_fail:
 	kfree(data);
+data_alloc_fail:
 	kfree(card);
 	return ret;
 }
-- 
2.7.4
