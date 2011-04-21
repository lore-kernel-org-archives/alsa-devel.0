From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support 24.576MHz MCLKs in WM8915
Date: Thu, 21 Apr 2011 14:17:40 +0100
Message-ID: <1303391860-5099-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4674E1038E4
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 15:17:34 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We can safely divide these down to within the supported SYSCLK range.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 0836094..4a3c5cc 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -1831,6 +1831,7 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8915_priv *wm8915 = snd_soc_codec_get_drvdata(codec);
 	int lfclk = 0;
+	int ratediv = 0;
 	int src;
 	int old;
 
@@ -1862,6 +1863,8 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 		snd_soc_update_bits(codec, WM8915_AIF_RATE,
 				    WM8915_SYSCLK_RATE, 0);
 		break;
+	case 24576000:
+		ratediv = WM8915_SYSCLK_DIV;
 	case 12288000:
 		snd_soc_update_bits(codec, WM8915_AIF_RATE,
 				    WM8915_SYSCLK_RATE, WM8915_SYSCLK_RATE);
@@ -1877,8 +1880,8 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 	}
 
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_1,
-			    WM8915_SYSCLK_SRC_MASK,
-			    src << WM8915_SYSCLK_SRC_SHIFT);
+			    WM8915_SYSCLK_SRC_MASK | WM8915_SYSCLK_DIV_MASK,
+			    src << WM8915_SYSCLK_SRC_SHIFT | ratediv);
 	snd_soc_update_bits(codec, WM8915_CLOCKING_1, WM8915_LFCLK_ENA, lfclk);
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_1,
 			    WM8915_SYSCLK_ENA, old);
-- 
1.7.4.1
