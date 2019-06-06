From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek:
	mt8183-mt6358-ts3a227-max98357: use modern dai_link style" to
	the asoc tree
Date: Thu,  6 Jun 2019 22:27:11 +0100 (BST)
Message-ID: <20190606212712.0464D440046@finisterre.sirena.org.uk>
References: <87zhmvl67t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C20EFF89805
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:12 +0200 (CEST)
In-Reply-To: <87zhmvl67t.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fa284fd002477d5e96bd96f638fbebd65316a750 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:08:49 +0900
Subject: [PATCH] ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: use modern
 dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 168 +++++++++++-------
 1 file changed, 106 insertions(+), 62 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 23c422f13808..887c932229d0 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -96,193 +96,246 @@ static const struct snd_soc_ops mt8183_mt6358_ts3a227_max98357_bt_sco_ops = {
 	.startup = mt8183_mt6358_ts3a227_max98357_bt_sco_startup,
 };
 
+/* FE */
+SND_SOC_DAILINK_DEFS(playback1,
+	DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback2,
+	DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback3,
+	DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture1,
+	DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture2,
+	DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture3,
+	DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture_mono,
+	DAILINK_COMP_ARRAY(COMP_CPU("UL_MONO_1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback_hdmi,
+	DAILINK_COMP_ARRAY(COMP_CPU("HDMI")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+/* BE */
+SND_SOC_DAILINK_DEFS(primary_codec,
+	DAILINK_COMP_ARRAY(COMP_CPU("ADDA")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("mt6358-sound", "mt6358-snd-codec-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(pcm1,
+	DAILINK_COMP_ARRAY(COMP_CPU("PCM 1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(pcm2,
+	DAILINK_COMP_ARRAY(COMP_CPU("PCM 2")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(i2s0,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(i2s1,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(i2s2,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S2")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(i2s3,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("max98357a", "HiFi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(i2s5,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S5")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(tdm,
+	DAILINK_COMP_ARRAY(COMP_CPU("TDM")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link
 mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 	/* FE */
 	{
 		.name = "Playback_1",
 		.stream_name = "Playback_1",
-		.cpu_dai_name = "DL1",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback1),
 	},
 	{
 		.name = "Playback_2",
 		.stream_name = "Playback_2",
-		.cpu_dai_name = "DL2",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.ops = &mt8183_mt6358_ts3a227_max98357_bt_sco_ops,
+		SND_SOC_DAILINK_REG(playback2),
 	},
 	{
 		.name = "Playback_3",
 		.stream_name = "Playback_3",
-		.cpu_dai_name = "DL3",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback3),
 	},
 	{
 		.name = "Capture_1",
 		.stream_name = "Capture_1",
-		.cpu_dai_name = "UL1",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
 		.ops = &mt8183_mt6358_ts3a227_max98357_bt_sco_ops,
+		SND_SOC_DAILINK_REG(capture1),
 	},
 	{
 		.name = "Capture_2",
 		.stream_name = "Capture_2",
-		.cpu_dai_name = "UL2",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture2),
 	},
 	{
 		.name = "Capture_3",
 		.stream_name = "Capture_3",
-		.cpu_dai_name = "UL3",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture3),
 	},
 	{
 		.name = "Capture_Mono_1",
 		.stream_name = "Capture_Mono_1",
-		.cpu_dai_name = "UL_MONO_1",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture_mono),
 	},
 	{
 		.name = "Playback_HDMI",
 		.stream_name = "Playback_HDMI",
-		.cpu_dai_name = "HDMI",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback_hdmi),
 	},
 	/* BE */
 	{
 		.name = "Primary Codec",
-		.cpu_dai_name = "ADDA",
-		.codec_dai_name = "mt6358-snd-codec-aif1",
-		.codec_name = "mt6358-sound",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(primary_codec),
 	},
 	{
 		.name = "PCM 1",
-		.cpu_dai_name = "PCM 1",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(pcm1),
 	},
 	{
 		.name = "PCM 2",
-		.cpu_dai_name = "PCM 2",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(pcm2),
 	},
 	{
 		.name = "I2S0",
-		.cpu_dai_name = "I2S0",
-		.codec_dai_name = "bt-sco-pcm",
-		.codec_name = "bt-sco",
 		.no_pcm = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s0),
 	},
 	{
 		.name = "I2S1",
-		.cpu_dai_name = "I2S1",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s1),
 	},
 	{
 		.name = "I2S2",
-		.cpu_dai_name = "I2S2",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
 		.no_pcm = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s2),
 	},
 	{
 		.name = "I2S3",
-		.cpu_dai_name = "I2S3",
-		.codec_dai_name = "HiFi",
-		.codec_name = "max98357a",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s3),
 	},
 	{
 		.name = "I2S5",
-		.cpu_dai_name = "I2S5",
-		.codec_dai_name = "bt-sco-pcm",
-		.codec_name = "bt-sco",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
+		SND_SOC_DAILINK_REG(i2s5),
 	},
 	{
 		.name = "TDM",
-		.cpu_dai_name = "TDM",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(tdm),
 	},
 };
 
@@ -343,18 +396,9 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 	}
 
 	for_each_card_prelinks(card, i, dai_link) {
-		/* In the alsa soc-core, the "platform" will be
-		 * allocated by devm_kzalloc if null.
-		 * There is a special case that registerring
-		 * sound card is failed at the first time, but
-		 * the "platform" will not null when probe is trying
-		 * again. It's not expected normally.
-		 */
-		dai_link->platforms = NULL;
-
-		if (dai_link->platform_name)
+		if (dai_link->platforms->name)
 			continue;
-		dai_link->platform_of_node = platform_node;
+		dai_link->platforms->of_node = platform_node;
 	}
 
 	mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node =
-- 
2.20.1
