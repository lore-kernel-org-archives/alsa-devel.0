From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: ak4671: Convert to table based
	control init
Date: Tue, 11 Feb 2014 19:56:57 +0000
Message-ID: <1392148618-24830-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 250C826084D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 20:57:11 +0100 (CET)
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

Saves code and adds error handling.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4671.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 25bdf6ad4a54..456bd0a065b1 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -628,9 +628,6 @@ static int ak4671_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	snd_soc_add_codec_controls(codec, ak4671_snd_controls,
-			     ARRAY_SIZE(ak4671_snd_controls));
-
 	ak4671_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return ret;
@@ -646,6 +643,8 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.probe = ak4671_probe,
 	.remove = ak4671_remove,
 	.set_bias_level = ak4671_set_bias_level,
+	.controls = ak4671_snd_controls,
+	.num_controls = ARRAY_SIZE(ak4671_snd_controls),
 	.reg_cache_size = AK4671_CACHEREGNUM,
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = ak4671_reg,
-- 
1.9.0.rc3
