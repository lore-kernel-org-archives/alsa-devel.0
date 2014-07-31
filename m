From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 20/35] ASoC: wm8960: Convert to params_width()
Date: Thu, 31 Jul 2014 12:58:03 +0100
Message-ID: <1406807898-5927-20-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0E83265489
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:43 +0200 (CEST)
In-Reply-To: <1406807898-5927-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The CODEC doesn't care how data is laid out in memory.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8960.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e96349b04ba6..4dc4e85116cd 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -567,24 +567,21 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
-	snd_pcm_format_t format = params_format(params);
 	int i;
 
 	/* bit size */
-	switch (format) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-	case SNDRV_PCM_FORMAT_S16_BE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-	case SNDRV_PCM_FORMAT_S20_3BE:
+	case 20:
 		iface |= 0x0004;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-	case SNDRV_PCM_FORMAT_S24_BE:
+	case 24:
 		iface |= 0x0008;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported format %i\n", format);
+		dev_err(codec->dev, "unsupported width %d\n",
+			params_width(params));
 		return -EINVAL;
 	}
 
-- 
2.0.1
