From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: Start WM8962 FLL if SYSCLK is enabled
Date: Tue,  1 Nov 2011 18:40:39 +0000
Message-ID: <1320172842-15790-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C3CB103870
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 19:40:46 +0100 (CET)
In-Reply-To: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we have code to automatically manage the start and stop of the FLL
based on the SYSCLK widget if SYSCLK is already enabled and the FLL is
configured then we need to start it up.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 153b4ac..7f0e6dff 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3406,6 +3406,7 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	unsigned long timeout;
 	int ret;
 	int fll1 = snd_soc_read(codec, WM8962_FLL_CONTROL_1) & WM8962_FLL_ENA;
+	int sysclk = snd_soc_read(codec, WM8962_CLOCKING2) & WM8962_SYSCLK_ENA;
 
 	/* Any change? */
 	if (source == wm8962->fll_src && Fref == wm8962->fll_fref &&
@@ -3466,6 +3467,9 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	try_wait_for_completion(&wm8962->fll_lock);
 
+	if (sysclk)
+		fll1 |= WM8962_FLL_ENA;
+
 	snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 			    WM8962_FLL_FRAC | WM8962_FLL_REFCLK_SRC_MASK |
 			    WM8962_FLL_ENA, fll1);
-- 
1.7.7.1
