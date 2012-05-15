From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Fix AIF2ADC power down
Date: Tue, 15 May 2012 18:29:08 +0100
Message-ID: <1337102948-18898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CBFBC24DA6
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 19:29:31 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6c1fe3a..2de12eb 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1144,7 +1144,7 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
 				    WM8994_AIF2DACL_ENA |
 				    WM8994_AIF2DACR_ENA, 0);
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
 				    WM8994_AIF2ADCL_ENA |
 				    WM8994_AIF2ADCR_ENA, 0);
 
-- 
1.7.10
