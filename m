From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/3] ASoC: AMD: Move clk enable from
	hw_params/free to startup/shutdown
Date: Tue, 24 Apr 2018 08:34:37 +0530
Message-ID: <1524539088-9043-2-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0074.outbound.protection.outlook.com [104.47.42.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 134C7266E30
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 05:03:08 +0200 (CEST)
In-Reply-To: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

hw_param can be called multiple times and thus we can have
more clk enable. The clk may not get diabled due to refcounting.
startup/shutdown ensures single clk enable/disable call.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 54 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..0f16f6d 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -38,8 +38,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 24000000
-#define MCLK_RATE 24576000
+#define CZ_PLAT_CLK 25000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
@@ -62,7 +61,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
-				  CZ_PLAT_CLK, MCLK_RATE);
+				  CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
@@ -85,8 +84,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -100,11 +98,9 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
+static void da7219_clk_disable(void)
 {
 	clk_disable_unprepare(da7219_dai_clk);
-
-	return 0;
 }
 
 static const unsigned int channels[] = {
@@ -127,7 +123,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_fe_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -141,23 +137,47 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	return 0;
+	return da7219_clk_enable(substream);
+}
+
+static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_max_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_max_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_dmic_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
 }
 
 static struct snd_soc_ops cz_da7219_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
-	.startup = cz_fe_startup,
+	.startup = cz_da7219_startup,
+	.shutdown = cz_da7219_shutdown,
 };
 
 static struct snd_soc_ops cz_max_play_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_max_startup,
+	.shutdown = cz_max_shutdown,
 };
 
 static struct snd_soc_ops cz_dmic_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_dmic_startup,
+	.shutdown = cz_dmic_shutdown,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
-- 
2.7.4
