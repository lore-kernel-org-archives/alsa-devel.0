From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/6] ASoC: tlv320aic3x: Move to table based
	control init
Date: Tue, 24 Sep 2013 00:12:45 +0100
Message-ID: <1379977968-25982-3-git-send-email-broonie@kernel.org>
References: <1379977968-25982-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 08CFF261600
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 01:13:02 +0200 (CEST)
In-Reply-To: <1379977968-25982-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index de17a36..397a213 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1369,8 +1369,6 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 			      (aic3x->setup->gpio_func[1] & 0xf) << 4);
 	}
 
-	snd_soc_add_codec_controls(codec, aic3x_snd_controls,
-			     ARRAY_SIZE(aic3x_snd_controls));
 	if (aic3x->model == AIC3X_MODEL_3007)
 		snd_soc_add_codec_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
 
@@ -1428,6 +1426,8 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.remove = aic3x_remove,
 	.suspend = aic3x_suspend,
 	.resume = aic3x_resume,
+	.controls = aic3x_snd_controls,
+	.num_controls = ARRAY_SIZE(aic3x_snd_controls),
 };
 
 /*
-- 
1.8.4.rc3
