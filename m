From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: mop500_ab8500: Use
	snd_soc_runtime_set_dai_fmt()
Date: Tue,  6 Jan 2015 15:17:22 +0100
Message-ID: <1420553842-17335-3-git-send-email-lars@metafoo.de>
References: <1420553842-17335-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-112.synserver.de (smtp-out-112.synserver.de
 [212.40.185.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7445126109C
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 15:17:29 +0100 (CET)
In-Reply-To: <1420553842-17335-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_runtime_set_dai_fmt() to configure the format for the DAI link
rather than configuring each DAI individually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/ux500/mop500_ab8500.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index be4f1ac7..aa65370 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -290,21 +290,9 @@ static int mop500_ab8500_hw_params(struct snd_pcm_substream *substream,
 			SND_SOC_DAIFMT_GATED;
 	}
 
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		dev_err(dev,
-			"%s: ERROR: snd_soc_dai_set_fmt failed for codec_dai (ret = %d)!\n",
-			__func__, ret);
-		return ret;
-	}
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-	if (ret < 0) {
-		dev_err(dev,
-			"%s: ERROR: snd_soc_dai_set_fmt failed for cpu_dai (ret = %d)!\n",
-			__func__, ret);
+	ret = snd_soc_runtime_set_dai_fmt(rtd, fmt);
+	if (ret)
 		return ret;
-	}
 
 	/* Setup TDM-slots */
 
-- 
1.8.0
