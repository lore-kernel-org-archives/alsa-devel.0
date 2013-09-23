From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: max98088: Use table based control
	init
Date: Mon, 23 Sep 2013 17:58:25 +0100
Message-ID: <1379955506-11658-2-git-send-email-broonie@kernel.org>
References: <1379955506-11658-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E5A82610AC
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 18:58:40 +0200 (CEST)
In-Reply-To: <1379955506-11658-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, Chih-Chung Chang <chihchung@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98088.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 391f669..8896d5e 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -2048,9 +2048,6 @@ static int max98088_probe(struct snd_soc_codec *codec)
 
        max98088_handle_pdata(codec);
 
-       snd_soc_add_codec_controls(codec, max98088_snd_controls,
-                            ARRAY_SIZE(max98088_snd_controls));
-
 err_access:
        return ret;
 }
@@ -2071,6 +2068,8 @@ static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
 	.suspend = max98088_suspend,
 	.resume  = max98088_resume,
 	.set_bias_level = max98088_set_bias_level,
+	.controls = max98088_snd_controls,
+	.num_controls = ARRAY_SIZE(max98088_snd_controls),
 	.reg_cache_size = ARRAY_SIZE(max98088_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = max98088_reg,
-- 
1.8.4.rc3
