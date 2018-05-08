From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 07/10] ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
Date: Tue, 8 May 2018 10:17:50 +0530
Message-ID: <1525754888-14124-7-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wei Yongjun <weiyongjun1@huawei.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

hw_param can be called multiple times and thus we can have
more clk enable. The clk may not get diabled due to refcounting.
startup/shutdown ensures single clk enable/disable call.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 49 +++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 215b06b..6495eed 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -91,8 +91,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -106,11 +105,9 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
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
@@ -133,7 +130,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_fe_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -147,23 +144,47 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
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
