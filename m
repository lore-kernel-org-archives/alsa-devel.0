From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] ASoC: sn95031: Cleanup bias level
	transitions
Date: Wed, 26 Nov 2014 20:57:53 +0100
Message-ID: <1417031880-11364-4-git-send-email-lars@metafoo.de>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C69F4265D83
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:28:58 +0100 (CET)
In-Reply-To: <1417031880-11364-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sn95031.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 6167c59..31d97cd 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -870,17 +870,8 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int sn95031_codec_remove(struct snd_soc_codec *codec)
-{
-	pr_debug("codec_remove called\n");
-	sn95031_set_vaud_bias(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver sn95031_codec = {
 	.probe		= sn95031_codec_probe,
-	.remove		= sn95031_codec_remove,
 	.set_bias_level	= sn95031_set_vaud_bias,
 	.idle_bias_off	= true,
 
-- 
1.8.0
