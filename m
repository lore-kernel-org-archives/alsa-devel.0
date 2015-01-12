From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ad193x: Don't power down DAC in CODEC
	probe
Date: Mon, 12 Jan 2015 13:54:13 +0100
Message-ID: <1421067253-14483-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-147.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id AA11B26054E
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 13:54:28 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAC powerdown bit is managed by DAPM. Manually powering down the DAC in
the CODEC probe function may cause unnecessary power state transitions which
can lead to click and pop noises.

So leave the DAC powerdown bit in its default poweron-reset state and let
DAPM do all the management.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 387530b..17c9535 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -333,8 +333,8 @@ static int ad193x_codec_probe(struct snd_soc_codec *codec)
 	regmap_write(ad193x->regmap, AD193X_DAC_CHNL_MUTE, 0x0);
 	/* de-emphasis: 48kHz, powedown dac */
 	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
-	/* powerdown dac, dac in tdm mode */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x41);
+	/* dac in tdm mode */
+	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x40);
 	/* high-pass filter enable */
 	regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
 	/* sata delay=1, adc aux mode */
-- 
1.8.0
