From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: tlv320aic23: Convert to table based
	control init
Date: Tue, 24 Sep 2013 19:27:17 +0100
Message-ID: <1380047238-16909-2-git-send-email-broonie@kernel.org>
References: <1380047238-16909-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A5A4261A88
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 20:27:23 +0200 (CEST)
In-Reply-To: <1380047238-16909-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic23.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 3299459..3a6be8c 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -586,9 +586,6 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 
 	snd_soc_write(codec, TLV320AIC23_ACTIVE, 0x1);
 
-	snd_soc_add_codec_controls(codec, tlv320aic23_snd_controls,
-				ARRAY_SIZE(tlv320aic23_snd_controls));
-
 	return 0;
 }
 
@@ -607,6 +604,8 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
 	.suspend = tlv320aic23_suspend,
 	.resume = tlv320aic23_resume,
 	.set_bias_level = tlv320aic23_set_bias_level,
+	.controls = tlv320aic23_snd_controls,
+	.num_controls = ARRAY_SIZE(tlv320aic23_snd_controls),
 	.dapm_widgets = tlv320aic23_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
 	.dapm_routes = tlv320aic23_intercon,
-- 
1.8.4.rc3
