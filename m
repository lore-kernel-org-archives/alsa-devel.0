From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Convert WM8804 to table based
	control init
Date: Fri,  9 Dec 2011 20:27:19 +0800
Message-ID: <1323433640-29538-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C98910383D
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 13:27:31 +0100 (CET)
In-Reply-To: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index ae4b8fb..d54a3ca 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -659,8 +659,6 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 
 	wm8804_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, wm8804_snd_controls,
-			     ARRAY_SIZE(wm8804_snd_controls));
 	return 0;
 
 err_reg_enable:
@@ -715,7 +713,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.reg_cache_size = ARRAY_SIZE(wm8804_reg_defs),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = wm8804_reg_defs,
-	.volatile_register = wm8804_volatile
+	.volatile_register = wm8804_volatile,
+
+	.controls = wm8804_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8804_snd_controls),
 };
 
 static const struct of_device_id wm8804_of_match[] = {
-- 
1.7.7.3
