From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: Add basic widgets for WM8915 Speyside
Date: Tue, 12 Apr 2011 23:06:05 -0700
Message-ID: <1302674771-17169-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 79B8E103800
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:40 +0200 (CEST)
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

Provide widgets for the basic widgets connected directly to the WM8915
on Speyside - the headphones, speaker, digital and analogue microphones.
For the outputs this is just documentation, for the inputs this ensures
that the relevant microphone biases are enabled when they are in use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index f6dcee7b..6ec44a3 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -63,10 +63,38 @@ static struct snd_soc_dai_link speyside_dai[] = {
 	},
 };
 
+static struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+
+	SND_SOC_DAPM_SPK("Main Speaker", NULL),
+
+	SND_SOC_DAPM_MIC("Main AMIC", NULL),
+	SND_SOC_DAPM_MIC("Main DMIC", NULL),
+};
+
+static struct snd_soc_dapm_route audio_paths[] = {
+	{ "IN1LP", NULL, "MICB2" },
+	{ "MICB2", NULL, "Main AMIC" },
+
+	{ "DMIC1DAT", NULL, "MICB1" },
+	{ "DMIC2DAT", NULL, "MICB1" },
+	{ "MICB1", NULL, "Main DMIC" },
+
+	{ "Headphone", NULL, "HPOUT1L" },
+	{ "Headphone", NULL, "HPOUT1R" },
+
+	{ "Main Speaker", NULL, "SPKDAT" },
+};
+
 static struct snd_soc_card speyside = {
 	.name = "Speyside",
 	.dai_link = speyside_dai,
 	.num_links = ARRAY_SIZE(speyside_dai),
+
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
 static __devinit int speyside_probe(struct platform_device *pdev)
-- 
1.7.4.1
