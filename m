From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/6] ASoC: tlv320aic3x: Move to table based
	DAPM init
Date: Tue, 24 Sep 2013 00:12:46 +0100
Message-ID: <1379977968-25982-4-git-send-email-broonie@kernel.org>
References: <1379977968-25982-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A04902615CC
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 01:13:00 +0200 (CEST)
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
 sound/soc/codecs/tlv320aic3x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 397a213..16fc74c 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -818,12 +818,6 @@ static int aic3x_add_widgets(struct snd_soc_codec *codec)
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
-				  ARRAY_SIZE(aic3x_dapm_widgets));
-
-	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
 	if (aic3x->model == AIC3X_MODEL_3007) {
 		snd_soc_dapm_new_controls(dapm, aic3007_dapm_widgets,
 			ARRAY_SIZE(aic3007_dapm_widgets));
@@ -1428,6 +1422,10 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.resume = aic3x_resume,
 	.controls = aic3x_snd_controls,
 	.num_controls = ARRAY_SIZE(aic3x_snd_controls),
+	.dapm_widgets = aic3x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aic3x_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
 /*
-- 
1.8.4.rc3
