From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Mediatek: MT8183: change supported
	formats of DL2 and UL1" to the asoc tree
Date: Thu,  2 May 2019 03:18:12 +0100 (BST)
Message-ID: <20190502021812.8B416441D3D@finisterre.ee.mobilebroadband>
References: <20190408104728.57351-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 358DDF89725
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:18:19 +0200 (CEST)
In-Reply-To: <20190408104728.57351-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, shunli.wang@mediatek.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: MT8183: change supported formats of DL2 and UL1

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1df1e5457cd1e115bd279f7d12015a4834057f68 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 8 Apr 2019 18:47:28 +0800
Subject: [PATCH] ASoC: Mediatek: MT8183: change supported formats of DL2 and
 UL1

DL2 and UL1 are for BTSCO.  They should only provide 16-bit, mono,
8kHz and 16kHz to userspace.  Change the formats accordingly.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 681bedb524f9..4e44e5689d6f 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -69,6 +69,46 @@ mt8183_mt6358_ts3a227_max98357_dapm_routes[] = {
 	{"IT6505_8CH", NULL, "TDM"},
 };
 
+static int
+mt8183_mt6358_ts3a227_max98357_bt_sco_startup(
+	struct snd_pcm_substream *substream)
+{
+	static const unsigned int rates[] = {
+		8000, 16000
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list  = rates,
+		.mask = 0,
+	};
+	static const unsigned int channels[] = {
+		1,
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_channels = {
+		.count = ARRAY_SIZE(channels),
+		.list = channels,
+		.mask = 0,
+	};
+
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+	runtime->hw.channels_max = 1;
+	snd_pcm_hw_constraint_list(runtime, 0,
+			SNDRV_PCM_HW_PARAM_CHANNELS,
+			&constraints_channels);
+
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8183_mt6358_ts3a227_max98357_bt_sco_ops = {
+	.startup = mt8183_mt6358_ts3a227_max98357_bt_sco_startup,
+};
+
 static struct snd_soc_dai_link
 mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 	/* FE */
@@ -93,6 +133,7 @@ mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		.ops = &mt8183_mt6358_ts3a227_max98357_bt_sco_ops,
 	},
 	{
 		.name = "Playback_3",
@@ -115,6 +156,7 @@ mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		.ops = &mt8183_mt6358_ts3a227_max98357_bt_sco_ops,
 	},
 	{
 		.name = "Capture_2",
-- 
2.20.1
