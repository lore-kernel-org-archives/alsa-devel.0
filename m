From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove impossible case from
	wm8994_hw_params
Date: Wed, 05 Oct 2011 07:15:51 +0800
Message-ID: <1317770151.2547.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A667F1038DD
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 01:16:03 +0200 (CEST)
Received: by yxk8 with SMTP id 8so1190370yxk.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 16:16:02 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

We set hw_params callback for wm8994_aif3_dai_ops to wm8994_aif3_hw_params.
Thus no need to check wm8994-aif3 in wm8994_hw_params.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8994.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d5b69c0..94a8db2 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2210,7 +2210,6 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994 *control = codec->control_data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int aif1_reg;
 	int aif2_reg;
@@ -2253,14 +2252,6 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			dev_dbg(codec->dev, "AIF2 using split LRCLK\n");
 		}
 		break;
-	case 3:
-		switch (control->type) {
-		case WM8958:
-			aif1_reg = WM8958_AIF3_CONTROL_1;
-			break;
-		default:
-			return 0;
-		}
 	default:
 		return -EINVAL;
 	}
-- 
1.7.4.1
