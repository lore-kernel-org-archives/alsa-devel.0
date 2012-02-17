From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: wm8962: Log the selected SYSCLK ratio
Date: Thu, 16 Feb 2012 22:30:05 -0800
Message-ID: <1329460209-30495-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E50E4103A48
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 95428dc..798ee01 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2479,6 +2479,8 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 		return;
 	}
 
+	dev_dbg(codec->dev, "Selected sysclk ratio %d\n", sysclk_rates[i]);
+
 	snd_soc_update_bits(codec, WM8962_CLOCKING_4,
 			    WM8962_SYSCLK_RATE_MASK, clocking4);
 
-- 
1.7.9.rc1
