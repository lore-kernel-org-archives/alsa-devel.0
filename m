From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove needless codec->dapm.bias_level
 assignment to SND_SOC_BIAS_OFF
Date: Mon, 03 Oct 2011 20:17:16 +0800
Message-ID: <1317644236.2724.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 11E462448D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 14:17:28 +0200 (CEST)
Received: by ywn1 with SMTP id 1so3840944ywn.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 05:17:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This assignment is done by the snd_soc_register_codec so there is no need
to redo it in probe function of a codec driver.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sn95031.c |    1 -
 sound/soc/codecs/wm5100.c  |    2 --
 sound/soc/codecs/wm8996.c  |    1 -
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index adb85bf..09c4593 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -827,7 +827,6 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
 	pr_debug("codec_probe called\n");
 
-	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.idle_bias_off = 1;
 
 	/* PCM interface config
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index f603989..46afdf86 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2285,8 +2285,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 
 	wm5100->codec = codec;
 
-	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
-
 	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index b98a8f8..43e46c7 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2706,7 +2706,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	init_completion(&wm8996->fll_lock);
 
 	dapm->idle_bias_off = true;
-	dapm->bias_level = SND_SOC_BIAS_OFF;
 
 	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
 	if (ret != 0) {
-- 
1.7.4.1
