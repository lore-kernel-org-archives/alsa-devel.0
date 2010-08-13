From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: Convert WM8580 hw_params to use
	snd_soc_update_bits()
Date: Fri, 13 Aug 2010 20:35:02 +0100
Message-ID: <1281728107-25386-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39070103903
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

All the cool kids are using snd_soc_update_bits() these days.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index b1a80e5..4f41419 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -485,9 +485,8 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
-	u16 paifb = snd_soc_read(codec, WM8580_PAIF3 + dai->driver->id);
+	u16 paifb = 0;
 
-	paifb &= ~WM8580_AIF_LENGTH_MASK;
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -505,7 +504,8 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8580_PAIF3 + dai->driver->id, paifb);
+	snd_soc_update_bits(codec, WM8580_PAIF3 + dai->driver->id,
+			    WM8580_AIF_LENGTH_MASK, paifb);
 	return 0;
 }
 
-- 
1.7.1
