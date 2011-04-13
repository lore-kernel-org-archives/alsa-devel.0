From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: Add pin switches for fixed analogue
	inputs and outputs on Speyside
Date: Tue, 12 Apr 2011 23:06:09 -0700
Message-ID: <1302674771-17169-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D37D71038C4
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:42 +0200 (CEST)
In-Reply-To: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Pin switches enable direct control of the DAPM state from userspace,
enabling simple enabling and disabling of the path. This is especially
useful for outputs such as the speaker which are composed of several
physical devices as it allows them to be controlled as a group.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 612a39e..e171a32 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -190,6 +190,12 @@ static struct snd_soc_codec_conf speyside_codec_conf[] = {
 	},
 };
 
+static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("Main Speaker"),
+	SOC_DAPM_PIN_SWITCH("Main DMIC"),
+	SOC_DAPM_PIN_SWITCH("Main AMIC"),
+};
+
 static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -238,6 +244,8 @@ static struct snd_soc_card speyside = {
 
 	.set_bias_level = speyside_set_bias_level,
 
+	.controls = controls,
+	.num_controls = ARRAY_SIZE(controls),
 	.dapm_widgets = widgets,
 	.num_dapm_widgets = ARRAY_SIZE(widgets),
 	.dapm_routes = audio_paths,
-- 
1.7.4.1
