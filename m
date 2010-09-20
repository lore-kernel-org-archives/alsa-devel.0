From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix merge issue with WM8962 control
	addition
Date: Mon, 20 Sep 2010 19:27:30 +0100
Message-ID: <1285007250-28565-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F334E24520
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 20:27:32 +0200 (CEST)
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

Let's not add the core controls twice.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 28adc6c..c4deea1 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1845,8 +1845,6 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	wm8962->reg_cache[WM8962_HPOUTL_VOLUME] |= WM8962_HPOUT_VU;
 	wm8962->reg_cache[WM8962_HPOUTR_VOLUME] |= WM8962_HPOUT_VU;
 
-	snd_soc_add_controls(codec, wm8962_snd_controls,
-			     ARRAY_SIZE(wm8962_snd_controls));
 	wm8962_add_widgets(codec);
 
 	wm8962_init_beep(codec);
-- 
1.7.1
