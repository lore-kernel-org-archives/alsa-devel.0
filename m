From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 04/14] ASoC: compress: Fix memory leak from snd_soc_new_compress
Date: Wed,  5 Jun 2019 15:45:46 +0200
Message-ID: <20190605134556.10322-5-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

Change kzalloc to devm_kzalloc, so compr gets automatically freed when
it's no longer needed.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-compress.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 03d5b9ccd3fc..ddef4ff677ce 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -896,16 +896,14 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	else
 		direction = SND_COMPRESS_CAPTURE;
 
-	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
+	compr = devm_kzalloc(rtd->card->dev, sizeof(*compr), GFP_KERNEL);
 	if (!compr)
 		return -ENOMEM;
 
 	compr->ops = devm_kzalloc(rtd->card->dev, sizeof(soc_compr_ops),
 				  GFP_KERNEL);
-	if (!compr->ops) {
-		ret = -ENOMEM;
-		goto compr_err;
-	}
+	if (!compr->ops)
+		return -ENOMEM;
 
 	if (rtd->dai_link->dynamic) {
 		snprintf(new_name, sizeof(new_name), "(%s)",
@@ -918,7 +916,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			dev_err(rtd->card->dev,
 				"Compress ASoC: can't create compressed for %s: %d\n",
 				rtd->dai_link->name, ret);
-			goto compr_err;
+			return ret;
 		}
 
 		rtd->pcm = be_pcm;
@@ -954,7 +952,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		dev_err(component->dev,
 			"Compress ASoC: can't create compress for codec %s: %d\n",
 			component->name, ret);
-		goto compr_err;
+		return ret;
 	}
 
 	/* DAPM dai link stream work */
@@ -965,10 +963,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 
 	dev_info(rtd->card->dev, "Compress ASoC: %s <-> %s mapping ok\n",
 		 codec_dai->name, cpu_dai->name);
-	return ret;
 
-compr_err:
-	kfree(compr);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_compress);
-- 
2.17.1
