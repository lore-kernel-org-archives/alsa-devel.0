From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: cs4270: Add DAPM support
Date: Sun, 11 Aug 2013 12:39:22 +0100
Message-ID: <1376221162-13363-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E5CC4264EFF
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:39:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This makes it possible to hook the device into a more complex board and
ensures it will continue to work with non-DAPM support removed from the
core.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/cs4270.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 8e47798..83c835d 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -139,6 +139,22 @@ struct cs4270_private {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
+static const struct snd_soc_dapm_widget cs4270_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("AINL"),
+SND_SOC_DAPM_INPUT("AINR"),
+
+SND_SOC_DAPM_OUTPUT("AOUTL"),
+SND_SOC_DAPM_OUTPUT("AOUTR"),
+};
+
+static const struct snd_soc_dapm_route cs4270_dapm_routes[] = {
+	{ "Capture", NULL, "AINA" },
+	{ "Capture", NULL, "AINB" },
+
+	{ "AOUTA", NULL, "Playback" },
+	{ "AOUTB", NULL, "Playback" },
+};
+
 /**
  * struct cs4270_mode_ratios - clock ratio tables
  * @ratio: the ratio of MCLK to the sample rate
@@ -612,6 +628,10 @@ static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
 
 	.controls =		cs4270_snd_controls,
 	.num_controls =		ARRAY_SIZE(cs4270_snd_controls),
+	.dapm_widgets =		cs4270_dapm_widgets,
+	.num_dapm_widgets =	ARRAY_SIZE(cs4270_dapm_widgets),
+	.dapm_routes =		cs4270_dapm_routes,
+	.num_dapm_routes =	ARRAY_SIZE(cs4270_dapm_routes),
 };
 
 /*
-- 
1.8.4.rc1
