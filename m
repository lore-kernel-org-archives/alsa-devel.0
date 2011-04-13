From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Mark Speyside widgets as ignoring
	suspend
Date: Tue, 12 Apr 2011 23:06:11 -0700
Message-ID: <1302674771-17169-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 640A21038C0
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

Allow audio paths through the Speyside system to be kept active while the
system is suspended (for example, when on a voice call) by marking all the
external widgets and the DAI link to the WM1250-EV1 baseband module as
ignoring suspend.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index a0c14a8..337855a 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -153,6 +153,19 @@ static int speyside_wm8915_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int speyside_late_probe(struct snd_soc_card *card)
+{
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headset Mic");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Main AMIC");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Main DMIC");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "WM1250 Output");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "WM1250 Input");
+
+	return 0;
+}
+
 static struct snd_soc_dai_link speyside_dai[] = {
 	{
 		.name = "CPU",
@@ -172,6 +185,7 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.codec_name = "wm1250-ev1.1-0027",
 		.platform_name = "samsung-audio",
 		.ops = &speyside_ops,
+		.ignore_suspend = 1,
 	},
 };
 
@@ -261,6 +275,8 @@ static struct snd_soc_card speyside = {
 	.num_dapm_widgets = ARRAY_SIZE(widgets),
 	.dapm_routes = audio_paths,
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+
+	.late_probe = speyside_late_probe,
 };
 
 static __devinit int speyside_probe(struct platform_device *pdev)
-- 
1.7.4.1
