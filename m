From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: Mediatek: MT8183: change supported
	formats of DL2 and UL1
Date: Mon,  8 Apr 2019 18:47:28 +0800
Message-ID: <20190408104728.57351-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92801F8076C
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 12:47:43 +0200 (CEST)
Received: by mail-qk1-x749.google.com with SMTP id d131so11175074qkc.18
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2019 03:47:43 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, tzungbi@google.com, shunli.wang@mediatek.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

DL2 and UL1 are for BTSCO.  They should only provide 16-bit, mono,
8kHz and 16kHz to userspace.  Change the formats accordingly.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
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
2.21.0.392.gf8f6787159e-goog
