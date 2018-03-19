From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2 2/3] ASoC: AMD: Enable da7219 master clock
	using common clock framework
Date: Mon, 19 Mar 2018 11:07:42 +0530
Message-ID: <1521437863-12389-2-git-send-email-akshu.agrawal@amd.com>
References: <1521437863-12389-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0064.outbound.protection.outlook.com [104.47.34.64])
 by alsa0.perex.cz (Postfix) with ESMTP id E1AC1267299
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 06:53:28 +0100 (CET)
In-Reply-To: <1521437863-12389-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

DA7219 is clock master for other codecs. DA7219 has exposed clock
control by using common clock framework and same is used to enable
and disable clock for all codecs in the system.

V2: Removed compiler errors and warning.

TEST=aplay -D hw:0,0 -vv <file>
arecord -D hw:0,0 -f dat -d 5 -vv <file>
aplay -D hw:0,1 -vv <file>

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index d07c2a1..99c6b5c 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -29,6 +29,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-dapm.h>
 #include <sound/jack.h>
+#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -42,11 +43,13 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
+struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_component *component = codec_dai->component;
 
@@ -66,6 +69,8 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	da7219_dai_clk = clk_get(codec->dev, "da7219-dai-clks");
+
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
@@ -81,6 +86,28 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	ret = clk_prepare_enable(da7219_dai_clk);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
+{
+	clk_disable_unprepare(da7219_dai_clk);
+
+	return 0;
+}
+
 static const unsigned int channels[] = {
 	DUAL_CHANNEL,
 };
@@ -119,9 +146,21 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 }
 
 static struct snd_soc_ops cz_da7219_cap_ops = {
+	.hw_params = cz_da7219_hw_params,
+	.hw_free = cz_da7219_hw_free,
 	.startup = cz_fe_startup,
 };
 
+static struct snd_soc_ops cz_max_play_ops = {
+	.hw_params = cz_da7219_hw_params,
+	.hw_free = cz_da7219_hw_free,
+};
+
+static struct snd_soc_ops cz_dmic_cap_ops = {
+	.hw_params = cz_da7219_hw_params,
+	.hw_free = cz_da7219_hw_free,
+};
+
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
 		.name = "amd-da7219-play-cap",
@@ -147,6 +186,7 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_playback = 1,
+		.ops = &cz_max_play_ops,
 	},
 	{
 		.name = "dmic",
@@ -158,6 +198,7 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
+		.ops = &cz_dmic_cap_ops,
 	},
 };
 
-- 
1.9.1
