From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Improve WM8994 digital power
	sequencing
Date: Thu,  3 Feb 2011 16:27:35 +0000
Message-ID: <1296750455-8175-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1296750455-8175-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED169103865
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 17:27:37 +0100 (CET)
In-Reply-To: <1296750455-8175-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

On WM8994 revision D and earlier ensure optimal sequencing with
simultaneous usage of AIF1 and AIF2 by tying the signals together
so if paths through both are connected the streams are started
simultaneously.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index f53b5a9..0024b4c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1584,6 +1584,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Right Headphone Mux", "DAC", "DAC1R" },
 };
 
+static const struct snd_soc_dapm_route wm8994_revd_intercon[] = {
+	{ "AIF1DACDAT", NULL, "AIF2DACDAT" },
+	{ "AIF2DACDAT", NULL, "AIF1DACDAT" },
+	{ "AIF1ADCDAT", NULL, "AIF2ADCDAT" },
+	{ "AIF2ADCDAT", NULL, "AIF1ADCDAT" },
+};
+
 static const struct snd_soc_dapm_route wm8994_intercon[] = {
 	{ "AIF2DACL", NULL, "AIF2DAC Mux" },
 	{ "AIF2DACR", NULL, "AIF2DAC Mux" },
@@ -3135,6 +3142,11 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	case WM8994:
 		snd_soc_dapm_add_routes(dapm, wm8994_intercon,
 					ARRAY_SIZE(wm8994_intercon));
+
+		if (wm8994->revision < 4)
+			snd_soc_dapm_add_routes(dapm, wm8994_revd_intercon,
+						ARRAY_SIZE(wm8994_revd_intercon));
+			
 		break;
 	case WM8958:
 		snd_soc_dapm_add_routes(dapm, wm8958_intercon,
-- 
1.7.3.5
