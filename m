From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: wm8962: Only configure BCLK in
	hw_params when audio is active
Date: Thu, 16 Feb 2012 22:30:04 -0800
Message-ID: <1329460209-30495-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6B1D103A4A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:30:47 +0100 (CET)
In-Reply-To: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensourc.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Otherwise we might not have a sensible clocking setup ready.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 3f37a91..95428dc 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2675,7 +2675,8 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 			    WM8962_SAMPLE_RATE_INT_MODE |
 			    WM8962_SAMPLE_RATE_MASK, adctl3);
 
-	wm8962_configure_bclk(codec);
+	if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
+		wm8962_configure_bclk(codec);
 
 	return 0;
 }
-- 
1.7.9.rc1
