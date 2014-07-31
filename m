From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 10/35] ASoC: wm8741: Convert to params_width()
Date: Thu, 31 Jul 2014 12:57:53 +0100
Message-ID: <1406807898-5927-10-git-send-email-broonie@kernel.org>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 481E026517A
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:59:34 +0200 (CEST)
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
 sound/soc/codecs/wm8741.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index b33542a04607..a237f1627f61 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -241,26 +241,26 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* bit size */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		iface |= 0x0001;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		iface |= 0x0002;
 		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
+	case 32:
 		iface |= 0x0003;
 		break;
 	default:
 		dev_dbg(codec->dev, "wm8741_hw_params:    Unsupported bit size param = %d",
-			params_format(params));
+			params_width(params));
 		return -EINVAL;
 	}
 
 	dev_dbg(codec->dev, "wm8741_hw_params:    bit size param = %d",
-		params_format(params));
+		params_width(params));
 
 	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
 	return 0;
-- 
2.0.1
