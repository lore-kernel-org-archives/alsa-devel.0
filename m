From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/13] ASoC: Use supplied DAI for WM9713 rather
	than substream
Date: Tue, 25 Nov 2008 15:44:37 +0000
Message-ID: <1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 335DC24497
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:52 +0100 (CET)
In-Reply-To: <20081125154302.GA8319@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7be811a..a502667 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -931,9 +931,7 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0xfff3;
 
 	switch (params_format(params)) {
@@ -958,9 +956,7 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 static void wm9713_voiceshutdown(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 status;
 
 	/* Gracefully shut down the voice interface. */
@@ -974,10 +970,8 @@ static void wm9713_voiceshutdown(struct snd_pcm_substream *substream,
 static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
+	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->codec;
 	int reg;
 	u16 vra;
 
@@ -995,10 +989,8 @@ static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
+	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->codec;
 	u16 vra, xsle;
 
 	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-- 
1.5.6.5
