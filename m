From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040: Select LPPLL during standby"
	to the asoc tree
Date: Wed, 11 May 2016 17:13:56 +0100
Message-ID: <E1b0Wlo-0006bT-RX@debutante>
References: <1462965245-7111-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E5332667EF
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 18:16:12 +0200 (CEST)
In-Reply-To: <1462965245-7111-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl6040: Select LPPLL during standby

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1135ef1139b3ebd5dc762b6b02384f8a7a84f8d4 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 11 May 2016 14:14:05 +0300
Subject: [PATCH] ASoC: twl6040: Select LPPLL during standby

When the codec is in standby we do not need to keep the HPPLL active.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index bc3de2e844e6..7a744b581cc1 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -824,7 +824,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 {
 	struct twl6040 *twl6040 = codec->control_data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
+	int ret = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -832,12 +832,16 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (priv->codec_powered)
+		if (priv->codec_powered) {
+			/* Select low power PLL in standby */
+			ret = twl6040_set_pll(twl6040, TWL6040_SYSCLK_SEL_LPPLL,
+					      32768, 19200000);
 			break;
+		}
 
 		ret = twl6040_power(twl6040, 1);
 		if (ret)
-			return ret;
+			break;
 
 		priv->codec_powered = 1;
 
@@ -853,7 +857,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int twl6040_startup(struct snd_pcm_substream *substream,
-- 
2.8.1
