From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove unneeded use of address-of
	operator
Date: Mon,  8 Nov 2010 10:41:53 +0000
Message-ID: <1289212913-13824-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69F0A243F2
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 11:42:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

There is no need to use '&' in this case.  Either way, if a is an array
of some type, then a == &a == &a[0].

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    2 +-
 sound/soc/codecs/wm8741.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index a2e0ed5..eda0e90 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -905,7 +905,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.set_bias_level = wm8580_set_bias_level,
 	.reg_cache_size = ARRAY_SIZE(wm8580_reg),
 	.reg_word_size = sizeof(u16),
-	.reg_cache_default = &wm8580_reg,
+	.reg_cache_default = wm8580_reg,
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 90e31e9..9304075 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -455,7 +455,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.resume =	wm8741_resume,
 	.reg_cache_size = ARRAY_SIZE(wm8741_reg_defaults),
 	.reg_word_size = sizeof(u16),
-	.reg_cache_default = &wm8741_reg_defaults,
+	.reg_cache_default = wm8741_reg_defaults,
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.3.2
