From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm5110: Stub hookup for Slimbus
	interface
Date: Fri, 17 May 2013 13:29:05 +0100
Message-ID: <1368793745-30887-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1368793745-30887-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6BC292607D7
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 14:29:12 +0200 (CEST)
In-Reply-To: <1368793745-30887-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |  179 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index ac40d6f..e77410e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -347,6 +347,15 @@ ARIZONA_MIXER_CONTROLS("AIF2TX2", ARIZONA_AIF2TX2MIX_INPUT_1_SOURCE),
 
 ARIZONA_MIXER_CONTROLS("AIF3TX1", ARIZONA_AIF3TX1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("AIF3TX2", ARIZONA_AIF3TX2MIX_INPUT_1_SOURCE),
+
+ARIZONA_MIXER_CONTROLS("SLIMTX1", ARIZONA_SLIMTX1MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX2", ARIZONA_SLIMTX2MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX3", ARIZONA_SLIMTX3MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX4", ARIZONA_SLIMTX4MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX5", ARIZONA_SLIMTX5MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX6", ARIZONA_SLIMTX6MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX7", ARIZONA_SLIMTX7MIX_INPUT_1_SOURCE),
+ARIZONA_MIXER_CONTROLS("SLIMTX8", ARIZONA_SLIMTX8MIX_INPUT_1_SOURCE),
 };
 
 ARIZONA_MIXER_ENUMS(EQ1, ARIZONA_EQ1MIX_INPUT_1_SOURCE);
@@ -414,6 +423,15 @@ ARIZONA_MIXER_ENUMS(AIF2TX2, ARIZONA_AIF2TX2MIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(AIF3TX1, ARIZONA_AIF3TX1MIX_INPUT_1_SOURCE);
 ARIZONA_MIXER_ENUMS(AIF3TX2, ARIZONA_AIF3TX2MIX_INPUT_1_SOURCE);
 
+ARIZONA_MIXER_ENUMS(SLIMTX1, ARIZONA_SLIMTX1MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX2, ARIZONA_SLIMTX2MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX3, ARIZONA_SLIMTX3MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX4, ARIZONA_SLIMTX4MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX5, ARIZONA_SLIMTX5MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX6, ARIZONA_SLIMTX6MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX7, ARIZONA_SLIMTX7MIX_INPUT_1_SOURCE);
+ARIZONA_MIXER_ENUMS(SLIMTX8, ARIZONA_SLIMTX8MIX_INPUT_1_SOURCE);
+
 ARIZONA_MUX_ENUMS(ASRC1L, ARIZONA_ASRC1LMIX_INPUT_1_SOURCE);
 ARIZONA_MUX_ENUMS(ASRC1R, ARIZONA_ASRC1RMIX_INPUT_1_SOURCE);
 ARIZONA_MUX_ENUMS(ASRC2L, ARIZONA_ASRC2LMIX_INPUT_1_SOURCE);
@@ -608,6 +626,56 @@ SND_SOC_DAPM_AIF_IN("AIF2RX1", NULL, 0,
 SND_SOC_DAPM_AIF_IN("AIF2RX2", NULL, 0,
 		    ARIZONA_AIF2_RX_ENABLES, ARIZONA_AIF2RX2_ENA_SHIFT, 0),
 
+SND_SOC_DAPM_AIF_IN("SLIMRX1", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX2", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX2_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX3", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX3_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX4", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX4_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX5", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX5_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX6", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX6_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX7", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX7_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_IN("SLIMRX8", NULL, 0,
+		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
+		    ARIZONA_SLIMRX8_ENA_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_OUT("SLIMTX1", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX1_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX2", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX2_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX3", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX3_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX4", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX4_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX5", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX5_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX6", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX6_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX7", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX7_ENA_SHIFT, 0),
+SND_SOC_DAPM_AIF_OUT("SLIMTX8", NULL, 0,
+		     ARIZONA_SLIMBUS_TX_CHANNEL_ENABLE,
+		     ARIZONA_SLIMTX8_ENA_SHIFT, 0),
+
 SND_SOC_DAPM_AIF_OUT("AIF3TX1", NULL, 0,
 		     ARIZONA_AIF3_TX_ENABLES, ARIZONA_AIF3TX1_ENA_SHIFT, 0),
 SND_SOC_DAPM_AIF_OUT("AIF3TX2", NULL, 0,
@@ -698,6 +766,15 @@ ARIZONA_MIXER_WIDGETS(AIF2TX2, "AIF2TX2"),
 ARIZONA_MIXER_WIDGETS(AIF3TX1, "AIF3TX1"),
 ARIZONA_MIXER_WIDGETS(AIF3TX2, "AIF3TX2"),
 
+ARIZONA_MIXER_WIDGETS(SLIMTX1, "SLIMTX1"),
+ARIZONA_MIXER_WIDGETS(SLIMTX2, "SLIMTX2"),
+ARIZONA_MIXER_WIDGETS(SLIMTX3, "SLIMTX3"),
+ARIZONA_MIXER_WIDGETS(SLIMTX4, "SLIMTX4"),
+ARIZONA_MIXER_WIDGETS(SLIMTX5, "SLIMTX5"),
+ARIZONA_MIXER_WIDGETS(SLIMTX6, "SLIMTX6"),
+ARIZONA_MIXER_WIDGETS(SLIMTX7, "SLIMTX7"),
+ARIZONA_MIXER_WIDGETS(SLIMTX8, "SLIMTX8"),
+
 ARIZONA_MUX_WIDGETS(ASRC1L, "ASRC1L"),
 ARIZONA_MUX_WIDGETS(ASRC1R, "ASRC1R"),
 ARIZONA_MUX_WIDGETS(ASRC2L, "ASRC2L"),
@@ -753,6 +830,14 @@ SND_SOC_DAPM_OUTPUT("MICSUPP"),
 	{ name, "AIF2RX2", "AIF2RX2" }, \
 	{ name, "AIF3RX1", "AIF3RX1" }, \
 	{ name, "AIF3RX2", "AIF3RX2" }, \
+	{ name, "SLIMRX1", "SLIMRX1" }, \
+	{ name, "SLIMRX2", "SLIMRX2" }, \
+	{ name, "SLIMRX3", "SLIMRX3" }, \
+	{ name, "SLIMRX4", "SLIMRX4" }, \
+	{ name, "SLIMRX5", "SLIMRX5" }, \
+	{ name, "SLIMRX6", "SLIMRX6" }, \
+	{ name, "SLIMRX7", "SLIMRX7" }, \
+	{ name, "SLIMRX8", "SLIMRX8" }, \
 	{ name, "EQ1", "EQ1" }, \
 	{ name, "EQ2", "EQ2" }, \
 	{ name, "EQ3", "EQ3" }, \
@@ -864,13 +949,41 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "AIF3RX1", NULL, "AIF3 Playback" },
 	{ "AIF3RX2", NULL, "AIF3 Playback" },
 
+	{ "Slim1 Capture", NULL, "SLIMTX1" },
+	{ "Slim1 Capture", NULL, "SLIMTX2" },
+	{ "Slim1 Capture", NULL, "SLIMTX3" },
+	{ "Slim1 Capture", NULL, "SLIMTX4" },
+
+	{ "SLIMRX1", NULL, "Slim1 Playback" },
+	{ "SLIMRX2", NULL, "Slim1 Playback" },
+	{ "SLIMRX3", NULL, "Slim1 Playback" },
+	{ "SLIMRX4", NULL, "Slim1 Playback" },
+
+	{ "Slim2 Capture", NULL, "SLIMTX5" },
+	{ "Slim2 Capture", NULL, "SLIMTX6" },
+
+	{ "SLIMRX5", NULL, "Slim2 Playback" },
+	{ "SLIMRX6", NULL, "Slim2 Playback" },
+
+	{ "Slim3 Capture", NULL, "SLIMTX7" },
+	{ "Slim3 Capture", NULL, "SLIMTX8" },
+
+	{ "SLIMRX7", NULL, "Slim3 Playback" },
+	{ "SLIMRX8", NULL, "Slim3 Playback" },
+
 	{ "AIF1 Playback", NULL, "SYSCLK" },
 	{ "AIF2 Playback", NULL, "SYSCLK" },
 	{ "AIF3 Playback", NULL, "SYSCLK" },
+	{ "Slim1 Playback", NULL, "SYSCLK" },
+	{ "Slim2 Playback", NULL, "SYSCLK" },
+	{ "Slim3 Playback", NULL, "SYSCLK" },
 
 	{ "AIF1 Capture", NULL, "SYSCLK" },
 	{ "AIF2 Capture", NULL, "SYSCLK" },
 	{ "AIF3 Capture", NULL, "SYSCLK" },
+	{ "Slim1 Capture", NULL, "SYSCLK" },
+	{ "Slim2 Capture", NULL, "SYSCLK" },
+	{ "Slim3 Capture", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
@@ -916,6 +1029,15 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("AIF3TX1", "AIF3TX1"),
 	ARIZONA_MIXER_ROUTES("AIF3TX2", "AIF3TX2"),
 
+	ARIZONA_MIXER_ROUTES("SLIMTX1", "SLIMTX1"),
+	ARIZONA_MIXER_ROUTES("SLIMTX2", "SLIMTX2"),
+	ARIZONA_MIXER_ROUTES("SLIMTX3", "SLIMTX3"),
+	ARIZONA_MIXER_ROUTES("SLIMTX4", "SLIMTX4"),
+	ARIZONA_MIXER_ROUTES("SLIMTX5", "SLIMTX5"),
+	ARIZONA_MIXER_ROUTES("SLIMTX6", "SLIMTX6"),
+	ARIZONA_MIXER_ROUTES("SLIMTX7", "SLIMTX7"),
+	ARIZONA_MIXER_ROUTES("SLIMTX8", "SLIMTX8"),
+
 	ARIZONA_MIXER_ROUTES("EQ1", "EQ1"),
 	ARIZONA_MIXER_ROUTES("EQ2", "EQ2"),
 	ARIZONA_MIXER_ROUTES("EQ3", "EQ3"),
@@ -1055,6 +1177,63 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
 	},
+	{
+		.name = "wm5110-slim1",
+		.id = 4,
+		.playback = {
+			.stream_name = "Slim1 Playback",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+		.capture = {
+			 .stream_name = "Slim1 Capture",
+			 .channels_min = 1,
+			 .channels_max = 4,
+			 .rates = WM5110_RATES,
+			 .formats = WM5110_FORMATS,
+		 },
+		.ops = &arizona_simple_dai_ops,
+	},
+	{
+		.name = "wm5110-slim2",
+		.id = 5,
+		.playback = {
+			.stream_name = "Slim2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+		.capture = {
+			 .stream_name = "Slim2 Capture",
+			 .channels_min = 1,
+			 .channels_max = 2,
+			 .rates = WM5110_RATES,
+			 .formats = WM5110_FORMATS,
+		 },
+		.ops = &arizona_simple_dai_ops,
+	},
+	{
+		.name = "wm5110-slim3",
+		.id = 6,
+		.playback = {
+			.stream_name = "Slim3 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+		.capture = {
+			 .stream_name = "Slim3 Capture",
+			 .channels_min = 1,
+			 .channels_max = 2,
+			 .rates = WM5110_RATES,
+			 .formats = WM5110_FORMATS,
+		 },
+		.ops = &arizona_simple_dai_ops,
+	},
 };
 
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
-- 
1.7.10.4
