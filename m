From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix masking of WM8962 FLL1 register
Date: Mon, 27 Sep 2010 18:52:21 -0700
Message-ID: <1285638741-8987-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2ECF10387A
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 03:52:05 +0200 (CEST)
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

When configuring the FLL we preserve the FLL enable configuration in order
to allow us to reenable the FLL after configuration but we do not clear
the other bits in the register, causing old configuration to be preserved.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7de5194..12286d6 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1342,7 +1342,7 @@ static int wm8962_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct _fll_div fll_div;
 	int ret;
-	int fll1 = snd_soc_read(codec, WM8962_FLL_CONTROL_1);
+	int fll1 = snd_soc_read(codec, WM8962_FLL_CONTROL_1) & WM8962_FLL_ENA;
 
 	/* Any change? */
 	if (source == wm8962->fll_src && Fref == wm8962->fll_fref &&
-- 
1.7.1
