From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND] ASoC: Remove impossible case from
	wm8994_hw_params
Date: Thu, 06 Oct 2011 07:39:59 +0800
Message-ID: <1317857999.6291.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 94F6524560
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 01:40:08 +0200 (CEST)
Received: by ywn1 with SMTP id 1so2426820ywn.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 16:40:06 -0700 (PDT)
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
 sound/soc/codecs/wm8994.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 16542de..68e769e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2235,7 +2235,6 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994 *control = codec->control_data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int aif1_reg;
 	int aif2_reg;
@@ -2278,15 +2277,6 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			dev_dbg(codec->dev, "AIF2 using split LRCLK\n");
 		}
 		break;
-	case 3:
-		switch (control->type) {
-		case WM1811:
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
