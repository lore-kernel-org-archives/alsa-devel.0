From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: evea: fix typo 'eva' -> 'evea'
Date: Tue, 20 Feb 2018 18:53:10 +0900
Message-ID: <20180220095310.13464-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 39642266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:53:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/evea.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index cad7e60de21d..ac2d30b55fb6 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -292,7 +292,7 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 	return evea_update_switch_hp(evea);
 }
 
-static const struct snd_kcontrol_new eva_controls[] = {
+static const struct snd_kcontrol_new evea_controls[] = {
 	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
 			    evea_get_switch_lin, evea_set_switch_lin),
 	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
@@ -384,8 +384,8 @@ static struct snd_soc_component_driver soc_codec_evea = {
 	.num_dapm_widgets	= ARRAY_SIZE(evea_widgets),
 	.dapm_routes		= evea_routes,
 	.num_dapm_routes	= ARRAY_SIZE(evea_routes),
-	.controls		= eva_controls,
-	.num_controls		= ARRAY_SIZE(eva_controls),
+	.controls		= evea_controls,
+	.num_controls		= ARRAY_SIZE(evea_controls),
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.16.1
