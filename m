From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Optimise WM9081 FLL performance
Date: Thu,  9 Dec 2010 16:17:58 +0000
Message-ID: <1291911478-19271-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7B7E103809
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 17:18:02 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mario Becroft <mb@gem.win.co.nz>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Mario Becroft <mb@gem.win.co.nz>

Tune the FLL gain for optimal performance according to evaluation
results.

Signed-off-by: Mario Becroft <mb@gem.win.co.nz>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index c706077..e5055b2 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -590,6 +590,10 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 	reg5 |= fll_div.fll_clk_ref_div << WM9081_FLL_CLK_REF_DIV_SHIFT;
 	snd_soc_write(codec, WM9081_FLL_CONTROL_5, reg5);
 
+	/* Set gain to the recommended value */
+	snd_soc_update_bits(codec, WM9081_FLL_CONTROL_4,
+			    WM9081_FLL_GAIN_MASK, 0);
+
 	/* Enable the FLL */
 	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1 | WM9081_FLL_ENA);
 
-- 
1.7.1
