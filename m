From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: Use table based control init for
	WM8903
Date: Fri,  2 Dec 2011 19:08:23 +0000
Message-ID: <1322852908-27588-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111202190710.GB27227@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD8CD24603
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:08:31 +0100 (CET)
In-Reply-To: <20111202190710.GB27227@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index fa44c9a..7e4b178 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2236,9 +2236,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 			    WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE,
 			    WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE);
 
-	snd_soc_add_controls(codec, wm8903_snd_controls,
-				ARRAY_SIZE(wm8903_snd_controls));
-
 	wm8903_init_gpio(codec);
 
 	return ret;
@@ -2268,6 +2265,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.reg_cache_default = wm8903_reg_defaults,
 	.volatile_register = wm8903_volatile_register,
 	.seq_notifier = wm8903_seq_notifier,
+	.controls = wm8903_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8903_snd_controls),
 	.dapm_widgets = wm8903_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm8903_dapm_widgets),
 	.dapm_routes = wm8903_intercon,
-- 
1.7.7.3
