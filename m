From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 2/2] ASoC: AMD: Enable da7219 master clock
	using common clock framework
Date: Mon, 12 Mar 2018 14:41:23 +0530
Message-ID: <1520845883-24062-2-git-send-email-akshu.agrawal@amd.com>
References: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0042.outbound.protection.outlook.com [104.47.37.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E322267332
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 10:26:42 +0100 (CET)
In-Reply-To: <1520845883-24062-1-git-send-email-akshu.agrawal@amd.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

DA7219 is clock master for other codecs. DA7219 has exposed clock
control by using common clock framework and same is used to enable
and disable clock for all codecs in the system.

TEST=Build, apply grunt_mixer_settings:
iotools mmio_write32 0xfed80e40 0x040c40c0
iotools mmio_write32 0xfed80e28 0x10000
aplay -D hw:0,0 -vv <file>
arecord -D hw:0,0 -f dat -d 5 -vv <file>
aplay -D hw:0,1 -vv <file>

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index d07c2a1..1441be3 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -42,6 +42,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
+struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -66,6 +67,8 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	da7219_dai_clk = clk_get(codec->dev, "da7219-dai-clks");
+
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
@@ -81,6 +84,30 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
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
+	int ret = 0;
+
+	clk_disable_unprepare(da7219_dai_clk);
+
+	return ret;
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
